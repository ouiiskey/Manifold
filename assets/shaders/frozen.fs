uniform float dissolve;
uniform float time;
uniform vec4 texture_details;
uniform vec2 image_details;
uniform bool shadow;
uniform vec4 burn_colour_1;
uniform vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv) {
    if (dissolve < 0.001) {
        return shadow ? vec4(0.0, 0.0, 0.0, tex.a * 0.3) : tex;
    }

    float adjusted_dissolve = dissolve * dissolve * (3.0 - 2.0 * dissolve) * 1.02 - 0.01;
    //Adjusting 0.0 - 1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.0;
	vec2 floored_uv = floor(uv * texture_details.ba) / max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.0 * vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.0 * vec2(cos(t / 53.1532), cos(t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.0 * vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.0 + cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) + cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92)) / 2.0;
    vec2 borders = vec2(0.2, 0.8);
    
    float res = 0.5 + 0.5 * cos(adjusted_dissolve / 82.612 + (field + -0.5) * 3.14)
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve;

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.0, 0.0, 0.0) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a * 0.3: tex.a) : 0.0);
}

uniform vec2 frozen;
// x -> shine
// y -> seed

// Hash without Sine - David Hoskins (2014)
// MIT License
// https://www.shadertoy.com/view/4djSRW
vec2 hash22(vec2 p) {
	vec3 p3 = fract(vec3(p.xyx) * vec3(0.1031, 0.1030, 0.0973));
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.xx + p3.yz) * p3.zy);
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    if (Texel(texture, texture_coords).a == 0.0) {
        return vec4(0.0);
    }
    vec2 ice_coords = (texture_coords * image_details - texture_details.xy * texture_details.zw) / vec2(71.0, 95.0);
    vec2 grid_coords = floor(ice_coords * 3);
    vec2 relative_coords = fract(ice_coords * 3);
    float dist = 1.0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 offset = vec2(float(x), float(y));
            vec2 point = hash22(grid_coords + offset + frozen.y);
            vec2 disp = offset + point - relative_coords;
            float curr_dist = length(disp);
            dist = min(dist, curr_dist);
        }
    }
    float trans = min(dist + 0.25, 1);
    vec4 ratio = vec4(vec3(trans * trans * trans * trans * trans), dist);
    vec4 light = vec4(0.83137, 0.86667, 0.88627, 0.9);
    vec4 dark = vec4(0.35, 0.37058, 0.53529, 0.75);
    vec4 base = light * ratio + dark * (1 - ratio);
    vec2 uv = (texture_coords * image_details - texture_details.xy * texture_details.zw) / texture_details.zw;

    // Apply shine (similar to negative_shine)
    float fac = 0.8 + 0.9 * sin(11.0 * uv.x + 4.32 * uv.y + frozen.x * 12.0 + cos(frozen.x * 5.3 + uv.y * 4.2 - uv.x * 4.0));
    float fac2 = 0.5 + 0.5 * sin(8.0 * uv.x + 2.32 * uv.y + frozen.x * 5.0 - cos(frozen.x * 2.3 + uv.x * 8.2));
    float fac3 = 0.5 + 0.5 * sin(10.0 * uv.x + 5.32 * uv.y + frozen.x * 6.111 + sin(frozen.x * 5.3 + uv.y * 3.2));
    float fac4 = 0.5 + 0.5 * sin(3.0 * uv.x + 2.32 * uv.y + frozen.x * 8.111 + sin(frozen.x * 1.3 + uv.y * 11.2));
    float fac5 = sin(14.4 * uv.x + 5.32 * uv.y + frozen.x * 12.0 + cos(frozen.x * 5.3 + uv.y * 4.2 - uv.x * 4.0));

    float maxfac = 0.2 * max(max(fac, max(fac2, max(fac3, 0.0))) + fac + fac2 + fac3 * fac4, 0.0);

    base.r += (1 - base.r) * maxfac * (0.1 + fac5 * 0.1);
    base.g += (1 - base.g) * maxfac * (0.1 - fac5 * 0.1);
    base.b += (1 - base.b) * maxfac * 0.1;
    base.a += maxfac * 0.1;

    return dissolve_mask(base, texture_coords, uv);
}

uniform vec2 mouse_screen_pos;
uniform float hovering;
uniform float screen_scale;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position) {
    if (hovering <= 0.0) {
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;
    float scale = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - mid_dist)) * hovering * (length(mouse_offset) * length(mouse_offset)) / (2.0 - mid_dist);
    return transform_projection * vertex_position + vec4(0.0, 0.0, 0.0, scale);
}
#endif