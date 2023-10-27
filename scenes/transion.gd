@tool
extends ColorRect
@export var progress:float = 0.0:
	set(v):
		progress = v
		material.set_shader_parameter("progress",progress)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
