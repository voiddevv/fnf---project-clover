shader_type canvas_item;
render_mode blend_mix;
vec3 hsv2rgb(vec3 col){
	vec3 c = col;
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	COLOR.rgb += tan(length(UV - VERTEX)*0.1 - TIME);
}
