extends Node

#signals
signal beat_hit(beat:int)
signal step_hit(step:int)
signal bar_hit(bar:int)

var rate:float = 1.0:
	set(v): 
		rate = v
		Engine.time_scale = rate

var time:float = 0.0
var bpm:float = 100.0
# float shit
var beatf:float = 0.0
var barf:float = 0.0
var stepf:float = 0.0
#int stuff
var beati:int = 0:
	get: return floori(beatf)
var bari:int = 0:
	get: return floori(barf)
var stepi:int = 0:
	get: return floori(stepf)
	
# these var are the time between step, bar, and beat and are to be used in math functions or tween
var beat_delta:float:
	get: return (bpm/60.0)
var bar_delta:float:
	get: return (bpm/60.0)*4.0
var step_delta:float:
	get: return (bpm/60.0)/4.0

var last_time:float = 0.0
func _process(_delta:float) -> void:
	var dt:float = time - last_time
	var last_beat:int = beati
	var last_step:int = stepi
	var last_bar:int = bari
	
	var _beat_delta:float = (bpm/60.0) * dt
	
	beatf += _beat_delta
	stepf += _beat_delta*4.0
	barf += _beat_delta/4.0
	
	last_time = time
	
	if last_beat != beati:
		beat_hit.emit(beati)
	if last_step != stepi:
		step_hit.emit(stepi)
	if last_bar != bari:
		bar_hit.emit(bari)
