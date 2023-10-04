extends Node
## chart var for gameplay
var CHART:Chart = null


func _input(event):
	if event.is_action("fullscreen") and event.is_pressed():
		var window := get_window()
		if window.mode == Window.MODE_FULLSCREEN: window.mode = Window.MODE_WINDOWED;return
		window.mode = Window.MODE_FULLSCREEN
