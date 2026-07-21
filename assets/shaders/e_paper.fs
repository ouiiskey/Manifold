uniform int floating;
uniform vec2 aspects;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 p = texture_coords * aspects;
    float x = mod(p.x, 71.0);
    float y = mod(p.y, 95.0);
    if (x < 5.0 || x > 66.0 || y < 5.0 || y > 90.0 || ((x < 6.0 || x > 65.0) && (y < 6.0 || y > 89.0))) {
        return vec4(0.0);
    }
    vec3 palette[16] = vec3[](
        vec3(83.0 / 255.0),
        vec3(90.0 / 255.0),
        vec3(98.0 / 255.0),
        vec3(105.0 / 255.0),
        vec3(112.0 / 255.0),
        vec3(120.0 / 255.0),
        vec3(127.0 / 255.0),
        vec3(134.0 / 255.0),
        vec3(142.0 / 255.0),
        vec3(149.0 / 255.0),
        vec3(156.0 / 255.0),
        vec3(164.0 / 255.0),
        vec3(171.0 / 255.0),
        vec3(178.0 / 255.0),
        vec3(186.0 / 255.0),
        vec3(193.0 / 255.0)
    );
    vec4 c = Texel(texture, texture_coords);
    int i;
    float a;
    if (floating == 1) {
        i = int((c.r + c.g + c.b) * 16 / 3);
        a = c.a > 0.5 ? 1.0 : 0.0;
    } else {
        i = int((c.r + c.g + c.b) * c.a * 16 / 3);
        a = 1.0;
    }
    if (i == 16) {
        i = 15;
    }
    return vec4(palette[i], a);
}