shader_type canvas_item;

uniform float speed = .1;

void vertex() {
	UV.x += TIME * speed;
	UV.y += TIME * speed;
	
	// Called for every vertex the material is visible on.
}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
