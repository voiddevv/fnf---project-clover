class_name NoteData extends Resource
var hit_time:float
var direction:int
var length:float
var type:String
var strum_index:int
func _init(_time:float,_direction:int,_length:float,strum_index:int,_type:String = "Default"):
	self.hit_time = _time
	self.direction = _direction
	self.length = _length
	self.type = _type
