#if __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define P highp
#else
	#define P mediump
#endif

uniform int floating;
uniform vec2 aspects;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 p = texture_coords * aspects;
    float x = mod(p.x, 71.0);
    float y = mod(p.y, 95.0);
    if (x < 5.0 || x > 66.0 || y < 5.0 || y > 90.0 || ((x < 6.0 || x > 65.0) && (y < 6.0 || y > 89.0))) {
        return vec4(0.0);
    }
    vec3[16] palette = vec3[](
        vec3(0.3255),
        vec3(0.3542),
        vec3(0.3830),
        vec3(0.4118),
        vec3(0.4405),
        vec3(0.4693),
        vec3(0.4980),
        vec3(0.5268),
        vec3(0.5556),
        vec3(0.5843),
        vec3(0.6131),
        vec3(0.6418),
        vec3(0.6706),
        vec3(0.6993),
        vec3(0.7281),
        vec3(0.7569)
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