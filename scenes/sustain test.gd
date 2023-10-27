extends Node2D
@onready var animation_player = $layer/animation_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("note_left"): animation_player.play("in")
	if Input.is_action_just_pressed("note_right"): animation_player.play("out")
	pass
