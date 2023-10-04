extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	label_settings.font_color = Color.from_hsv(cos(Conductor.time),1.0,0.7,1.0)
