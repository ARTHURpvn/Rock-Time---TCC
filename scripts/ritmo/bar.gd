extends Node3D

var note_scn = preload("res://scenes/ritmo/note.tscn")

var notes_data = [
	{
		"pos": 0,
		"len": 100
	},
	{
		"pos": 400,
		"len": 100
	},
	{
		"pos": 800,
		"len": 100
	},
	{
		"pos": 1200,
		"len": 100
	},
]

var note_scale = 0.005

func _ready() -> void:
	add_notes()


func add_notes():
	for note_data in notes_data:
		randomize()
		var note = note_scn.instantiate()
		note.line = (randi() % 3) + 1
		note.position.z = int(note_data.pos)*note_scale
		add_child(note)
