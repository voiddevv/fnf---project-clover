shader_type spatial;

void fragment() {
	// Place fragment code here.
}

void vertex(){
	VERTEX.y -= tan(TIME * (VERTEX.x * VERTEX.z*2.0));
}