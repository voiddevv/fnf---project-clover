class_name NoteGroup extends Node2D
@onready var strumline:StrumLine = $"../"
const scroll_speed:float = 2.0
var ngtps:int = DisplayServer.screen_get_refresh_rate()
var _time:float = 0.0
signal notegrouptick

func _process(delta) -> void:
	_time += delta
	if _time <= 1.0/ngtps:return
	_time = 0
	notegrouptick.emit()
