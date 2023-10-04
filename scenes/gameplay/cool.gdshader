shader_type canvas_item;

uniform sampler2D noise_:hint_default_black,repeat_enable;
uniform vec4 color:source_color = vec4(1.0); 
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 0.666, 0.333, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec2 inverse_uv = (vec2(1.0) - UV);
	vec4 noise_color = texture(noise_,UV);
	COLOR = color;
	COLOR.rgb *= (tan(TIME*2.0 - length(UV*32.0 * inverse_uv))) * length(texture(noise_,UV).rgb);
}
