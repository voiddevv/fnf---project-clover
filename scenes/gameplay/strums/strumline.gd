class_name StrumLine extends Node2D

var pressed:Array[bool] = [false,false,false,false]
var actions:PackedStringArray = ["note_left","note_down","note_up","note_right"]
# if the strum will do input stuff
@export var handle_input = false
@export var auto_play:bool = true
@onready var receptors:Array[Receptor] = [$"0", $"1", $"2", $"3"]
@onready var game:PlayFeild = $"../../../.."

@onready var note_group:NoteGroup = $notegroup
var base_position_y:float = 75.0
# 1 = down scroll 0 = upscroll
@export var scroll_direction:float = 1

func _ready() -> void:
	for r in receptors:
		r = r as Receptor
		r.play_anim(Receptor.STATIC)

func _process(delta) -> void:
	position.y = (base_position_y + (720 - base_position_y*2.0)*scroll_direction)
	for i in receptors:
		if not handle_input: break
		if pressed[receptors.find(i)]:
			if i.state != Receptor.CONFIRM and i.state != Receptor.PRESSED:
				i.play_anim(Receptor.PRESSED)
		if not pressed[receptors.find(i)]:
			i.play_anim(Receptor.STATIC)

func int_from_event(ev:InputEvent) -> int:
	for str in actions:
		if(ev.is_action(str)): 
			return actions.find(str)
	return -1
	
func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion or event == null or not handle_input: return
	var input_dir:int = int_from_event(event)
	if input_dir == -1: return
	var cool_notes:Array = note_group.get_children().duplicate().filter(func(_note:Note): return not _note.too_late and _note.can_hit and _note.direction == input_dir)
	cool_notes.sort_custom(Chart.sort_hit_notes)
	for note in cool_notes:
		if note.direction == input_dir and note.can_hit and not note.too_late and not pressed[note.direction]:
			game.call_deferred_thread_group("player_notehit",note)
			break
	pressed[input_dir] = event.is_pressed()
