shader_type canvas_item;

uniform sampler2D noise_:hint_default_black,repeat_enable;
uniform vec4 color:source_color = vec4(1.0); 

void fragment() {
	vec2 inverse_uv = (vec2(1.0) - UV);
	vec4 noise_color = texture(noise_,UV);
	COLOR = color;
	COLOR.rgb -= (tan(TIME*2.0 - length(UV*32.0 * inverse_uv))) + length(texture(noise_,UV).rgb);
}
