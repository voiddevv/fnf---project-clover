shader_type canvas_item;
uniform vec3 R:source_color;
uniform vec3 G:source_color;
uniform vec3 B:source_color;


void fragment() {
	COLOR.rgb = COLOR.r * R + COLOR.b * B + COLOR.g * G;
	// Called for every pixel the material is visible on.
}