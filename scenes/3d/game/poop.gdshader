shader_type spatial;

void vertex() {
 VERTEX.y += cos(VERTEX.x*16.0) * sin(VERTEX.z - TIME);
}
