class_name Chart extends Resource
var display_name:String = "test"
var name:String = "test"
var bpm:float
var notes:Array[NoteData] = []
var events:Array = []
static func load_chart(songname:String,diff:String):
	var json:Dictionary = load("res://assets/songs/%s/%s.json" %[songname,diff]).data.song
	var ret:Chart = Chart.new()
	ret.name = songname.to_lower()
	ret.display_name = songname
	ret.bpm = json.bpm
	for bar in json.notes:
		for note in bar.sectionNotes:
			var _strum_index:int = 0
			_strum_index += int(bar.mustHitSection) + int(note[1] >= 4)
			if bar.mustHitSection: note[0] += 4
			var out_lat:float= AudioServer.get_output_latency()
			var note_data:NoteData = NoteData.new(note[0]/1000.0 + out_lat,int(note[1])%4,note[2]/1000.0,0)
			note_data.strum_index = _strum_index
			ret.notes.append(note_data)
			
		var bar_index:int = json.notes.find(bar)
	ret.notes.sort_custom(func(a:NoteData,b:NoteData): return a.hit_time < b.hit_time)
	return ret
static func sort_hit_notes(a:Note, b:Note):
	if not a.should_hit and b.should_hit: return false
	elif a.should_hit and not b.should_hit: return true
	return a.hit_time < b.hit_time
