@tool
class_name Sustain
extends Node2D

@export var sustain_texture:Texture2D = PlaceholderTexture2D.new()
@export var tail_texture:Texture2D = PlaceholderTexture2D.new()
@export var length:float = 1.0

func _process(delta):
	queue_redraw()


func _draw():
	if length <= 0: return
	draw_texture_rect(sustain_texture,Rect2((-sustain_texture.get_width()/2.0),0,sustain_texture.get_width(),length),true)
	draw_texture_rect(tail_texture,Rect2((-tail_texture.get_width()/2.0),abs(length),tail_texture.get_width(),tail_texture.get_height()),false)	
