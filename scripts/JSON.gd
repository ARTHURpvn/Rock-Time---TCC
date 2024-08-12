extends Node

@export var tiles: PackedScene

var notes_info = []

const JSON_PATH = "res://data/snd_helena.json"

func _ready():
	notes_info = load_json()

func load_json():
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	file.close()
	return content

func get_notes_info() -> Array:
	return notes_info

