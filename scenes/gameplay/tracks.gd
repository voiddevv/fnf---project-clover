extends Node
@onready var game:PlayFeild = $"../"

func _ready():
	Conductor.bar_hit.connect(bar_hit)
func bar_hit(_beat:int):
	for i in get_children():
		i = i as AudioStreamPlayer
		if Conductor.time - i.get_playback_position() < 0.020:
			Conductor.time = i.get_playback_position()

func load_tracks():
	var streams:Array[AudioStream] = game.song_meta.tracks
	for i in streams:
		var player := AudioStreamPlayer.new()
		player.stream = i
		add_child(player)
		player.pitch_scale = Conductor.rate
		player.play()
