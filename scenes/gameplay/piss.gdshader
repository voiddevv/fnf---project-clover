shader_type canvas_item;
uniform vec3 from:source_color = vec3(0.0,0.0,0.0);
uniform vec3 to:source_color = vec3(0.0,0.0,0.0);
void fragment() {
	COLOR.rgb /= (to * from);
}
