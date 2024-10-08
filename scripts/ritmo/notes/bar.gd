extends Node3D

var short_note_scn = preload("res://scenes/ritmo/short_note.tscn")
var long_note_scn = preload("res://scenes/ritmo/long_note.tscn")

var note_scale 
var bar_data
var speed
var line = 1

func _ready() -> void:
	add_notes()

func add_notes():
	for line_data in bar_data:
		var notes_data = line_data.notes
		for note_data in notes_data:
			add_note(line, note_data)
		line += 1


func add_note(lines, data):
	var note_scn
	if int(data.len) >= 300:
		note_scn = long_note_scn
	else:
		note_scn = short_note_scn

	var note = note_scn.instantiate()

	note.line = lines
	note.position.z = int(data.pos)

	note.length = int(data.len)
	note.length_scale = note_scale
	note.speed = speed
	add_child(note)
