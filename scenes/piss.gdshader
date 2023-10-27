shader_type canvas_item;
uniform sampler2D noise:hint_default_black,repeat_enable;
uniform vec4 color:source_color;
uniform float progress:hint_range(0.0, 1.0, 0.01);
void fragment() {
	vec4 noise_color = texture(noise,UV / length(FRAGCOORD.xy * UV)*25.0);
	
	COLOR = step(distance(fract(FRAGCOORD.x-UV*8.0),vec2(0.5)),(((1.0) - (progress / sin(length(UV)))))) * color;
}