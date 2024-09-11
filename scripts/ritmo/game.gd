extends Node3D

@onready var music_node = $Music
@onready var road_node = $Road

var audio
@export var audio_file = "res://musicas/teste.mp3"
@export var map_file = "res://musicas/solo.mboy"

var map
var tempo
var bar_length_in_m
var quarter_time_in_sec
var speed
var note_scale
var start_pos_in_sec

func _ready() -> void:
	audio = load(audio_file)
	map = load_map()
	calc_params()

	music_node.setup(self)
	road_node.setup(self)

func calc_params():
	tempo = int(map.tempo)  
	bar_length_in_m = 16
	quarter_time_in_sec = 60 / float(tempo)
	speed = bar_length_in_m / float(4 * quarter_time_in_sec)
	note_scale = bar_length_in_m / float(4 * 400)
	start_pos_in_sec = (float(map.start_pos) / 400.0) * quarter_time_in_sec 

func load_map():
	var file = FileAccess.open(map_file, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	var json_result = JSON.parse_string(json_text)
	return json_result
