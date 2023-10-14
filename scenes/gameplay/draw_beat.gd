extends Control
@export var dps:int = 240
# this shit will draw da beat step and bar / section

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var _t:float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _t >= 1.0/dps:
		queue_redraw()
		_t = 0
	_t += delta

	pass
func _draw():
	var _y:float = fmod(Conductor.barf,1.0) * size.y
	draw_line(Vector2(0,_y),Vector2(size.x,_y),Color.BURLYWOOD,4,true)
