class_name PlayFeild extends Node2D
@onready var hud = $"HUD Layer/HUD"
@onready var hud_layer = $"HUD Layer"

var hud_lerp:bool = true
@onready var tracks = $tracks

@export_flags("alive:2","has_notes:4","has_events:6","is_playable:8","subtitles:12") var flags:int = 0

enum FLGAS_PISS{
	ALIVE = 2,
	HAS_NOTES = 4,
	HAS_EVENTS = 6,
	IS_PLAYABLE = 8,
	SUBTITLES = 12,
	ALL = ALIVE | HAS_NOTES| HAS_EVENTS | IS_PLAYABLE | SUBTITLES
}
@export_category("Strums")
@export var cpu_strums:Array[Node] = []
@export var player_strums:Array[Node] = []
@onready var strums = $"HUD Layer/HUD/strums"
var notes_spawned:int = 0
var template_notes:Dictionary = {
	"Default" : preload("res://scenes/gameplay/notes/Default.tscn"),
}
# stuff 
var song_meta:SongMetaData = SongMetaData.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.CHART = Chart.load_chart("detected","funky")
	load_song_meta()
	Conductor.bpm = Global.CHART.bpm
	tracks.load_tracks()
	Conductor.bar_hit.connect(bar_hit)
func _process(delta):
	Conductor.time += delta
	hud.scale = lerp(hud.scale,Vector2(1.0,1.0),delta*10.0)

func bar_hit(bar:int):
	hud.scale = Vector2(1.05,1.05)

func spawn_notes():
	var last_data:NoteData = null
	for i in range(notes_spawned, Global.CHART.notes.size()):
		var data = Global.CHART.notes[i]
		if data.hit_time - Conductor.time <= NoteGroup.scroll_speed / 0.5:
			if last_data != null and abs(data.hit_time - last_data.hit_time) >= 0.005 and last_data.direction == data.direction and last_data.strum_index == data.strum_index:
				print("stack note found")
				continue
				notes_spawned += 1 
			var _note:Note = template_notes["Default"].instantiate()
			_note.hit_time = data.hit_time
			_note.og_length = data.length*0.7
			_note.length = data.length*0.7

			_note.direction = data.direction
			_note.strum = strums.get_child(data.strum_index%2)
			_note.strum.note_group.add_child(_note)
			_note.sprite.play(Receptor.NoteDirection.keys()[_note.direction].to_lower())
			notes_spawned += 1
			_note.position_x_to_strum()
			last_data = data

func load_song_meta():
	var path:String = "res://assets/songs/%s/meta.tres"%[Global.CHART.name.to_lower()]
	if ResourceLoader.exists(path): song_meta = load(path)

func player_notehit(note:Note):
	note.was_hit = true
	pass
func _input(event):
	if event.is_action_released("hide_hud"):
		hud_layer.visible = !hud_layer.visible
