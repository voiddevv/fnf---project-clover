class_name NoteGroup extends Node2D
@onready var strumline:StrumLine = $"../"
const scroll_speed:float = 2.7 # this is temp will make it work on indepedent notes later :3
var ngtps:int = DisplayServer.screen_get_refresh_rate()
var _time:float = 0.0
signal notegrouptick

func _process(delta) -> void:
	_time += delta
	if _time <= 1.0/ngtps:return
	_time = 0
	for note in get_children():
		note = note as Note
		note.sustain.scale.y = note.sustain.scale.x * -(strumline.scroll_direction - 0.5) * 2.0
		note.sustain.length = note.length*30
		note.position.y = ((Conductor.time - note.hit_time)*1000) + strumline.receptors[note.direction].position.y
		if strumline.auto_play:
			if note.hit_time - Conductor.time <= 0:
				note.was_hit = true
		if note.was_hit:
			note.sprite.visible = false
			note.length -= delta*(scroll_speed + note.og_length)
			note.position.y = strumline.receptors[note.direction].position.y
			if note.length <= 0:
				if note.strum.handle_input: print("PLAYER NOTE KILLED")
				note.queue_free()
		if note.too_late and not note.was_hit:
			note.modulate.a = 0.6
			note.queue_free()
			if not note.missed:
				note.missed = true
	notegrouptick.emit()


