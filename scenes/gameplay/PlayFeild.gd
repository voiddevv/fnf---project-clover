class_name PlayFeild extends Node2D
@onready var hud = $"HUD Layer/HUD"
var hud_lerp:bool = true
@onready var tracks = $tracks
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
	Global.CHART = Chart.load_chart("ghost","hard")
	load_song_meta()
	Conductor.bpm = Global.CHART.bpm
	tracks.load_tracks()
func _process(delta):
	Conductor.time += delta
#	var funni:float = 1.0 - (0.1 * fmod(Conductor.beatf,1.0))
#	hud.scale = lerp(hud.scale,Vector2(funni,funni),delta*10.0)


func spawn_notes():
	var last_data:NoteData = null
	for i in range(notes_spawned, Global.CHART.notes.size()):
		var data = Global.CHART.notes[i]
		if data.hit_time - Conductor.time <= 0.5 / NoteGroup.scroll_speed:
			if last_data != null and abs(data.hit_time - last_data.hit_time) >= 0.005 and last_data.direction == data.direction and last_data.strum_index == data.strum_index:
				print("stack note found")
				continue
				notes_spawned += 1 
			var _note:Note = template_notes["Default"].instantiate()
			_note.hit_time = data.hit_time
			_note.og_length = 0
			_note.direction = data.direction
			_note.strum = strums.get_child(data.strum_index%2)
			_note.strum.note_group.add_child(_note)
			_note.sprite.play(Receptor.NoteDirection.keys()[_note.direction].to_lower())
			notes_spawned += 1
			last_data = data

func load_song_meta():
	var path:String = "res://assets/songs/%s/meta.tres"%[Global.CHART.name.to_lower()]
	if ResourceLoader.exists(path): song_meta = load(path)
