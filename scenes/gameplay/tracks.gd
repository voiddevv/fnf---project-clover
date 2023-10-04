extends Node
@onready var game:PlayFeild = $"../"

func load_tracks():
	var streams:Array[AudioStream] = game.song_meta.tracks
	for i in streams:
		var player := AudioStreamPlayer.new()
		player.stream = i
		add_child(player)
		player.pitch_scale = Conductor.rate
		player.play()
