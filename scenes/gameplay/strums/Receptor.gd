
class_name Receptor extends AnimatedSprite2D
@export var direction:NoteDirection = 0
var state:int = 0
enum {
	STATIC = 0,
	PRESSED = 1,
	CONFIRM = 2
}

enum NoteDirection {
	LEFT = 0,
	DOWN = 1,
	UP = 2,
	RIGHT = 3
}



func play_anim(type:int):
	var dir_str = NoteDirection.keys()[direction].to_lower()
	state = abs(type%4)
	match type:
		STATIC:
			play(dir_str + " static")
		PRESSED:
			play(dir_str + " pressed")
		CONFIRM:
			play(dir_str + " confirm")
