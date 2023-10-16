class_name NoteGroup extends Node2D
@onready var strumline:StrumLine = $"../"
const scroll_speed:float = 2.4 # this is temp will make it work on indepedent notes later :3
var ngtps:int = DisplayServer.screen_get_refresh_rate()
var _time:float = 0.0
signal notegrouptick

func _process(delta) -> void:
	_time += delta
	if _time <= 1.0/ngtps:return
	delta = 1.0/ngtps
	_time = 0
	for note in get_children():
		note = note as Note
		note.sustain.scale.y = note.sustain.scale.x * -(strumline.scroll_direction - 0.5)
		note.sustain.length = (70 * (scroll_speed * note.length)*15)/note.scale.y
		note.position.y = ((Conductor.time - note.hit_time)*1000*scroll_speed*0.45) + strumline.receptors[note.direction].position.y
		if strumline.auto_play:
			if note.hit_time - Conductor.time <= 0:
				note.was_hit = true
		if note.was_hit:
			note.sprite.visible = false
			note.length -= 1.0/ngtps
			note.position.y = strumline.receptors[note.direction].position.y
			if note.length <= 0:
				note.queue_free()
		if note.too_late and not note.was_hit:
			note.modulate.a = 0.6
			note.queue_free()
			if not note.missed:
				note.missed = true
	notegrouptick.emit()
