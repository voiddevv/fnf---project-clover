class_name Note extends Node2D

var hit_time:float
var direction:int
var length:float
var og_length:float
var strum:StrumLine
const hit_window:float = 0.180
var too_late:bool:
	get:
		return (hit_time + length < Conductor.time - hit_window and not can_hit and not was_hit)
var can_hit:bool:
	get:
		return hit_time > Conductor.time - hit_window and hit_time < Conductor.time + hit_window
		
var missed:bool = false:
	get:
		return too_late
		
var was_hit:bool = false

# exports
@export var should_hit:bool = true
@export var type:String = "Default"

# scene vars
@onready var sprite = $sprite
@onready var sustain:Sustain = $sustain


func position_x_to_strum():
	position.x = strum.receptors[direction].position.x
