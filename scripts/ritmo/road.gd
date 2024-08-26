extends Node3D
@onready var bars_node = $BarsNode

var bar_scn = preload("res://scenes/ritmo/bar.tscn")
var bars = []

var bar_length_in_m
var curr_location
var speed
var note_scale

var curr_bar_index
var tracks_data

func setup(game) -> void:
	speed = Vector3(0,0,game.speed)
	bar_length_in_m = game.bar_length_in_m
	curr_location = Vector3(0, 0, -bar_length_in_m)
	note_scale = game.note_scale
	curr_bar_index = 0
	tracks_data = game.map.tracks
	add_bars()

func _process(delta: float) -> void:
	bars_node.translate(speed*delta)

	for bar in bars:
		if bar.position.z + bars_node.position.z >= bar_length_in_m:
			remove_bar(bar)
			add_bar()

func add_bar():
	var bar = bar_scn.instantiate()
	bar.set_position(Vector3(curr_location.x, curr_location.y, curr_location.z))
	bar.note_scale = note_scale
	bar.bar_data = get_bar_data()
	bar.speed = speed
	bars.append(bar)
	bars_node.add_child(bar)
	curr_location += Vector3(0, 0, - bar_length_in_m)
	curr_bar_index += 1


func get_bar_data():
	var left_data = tracks_data[0].bars[curr_bar_index]
	var middle_data = tracks_data[1].bars[curr_bar_index]
	var right_data = tracks_data[2].bars[curr_bar_index]
	return [left_data, middle_data, right_data]

func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)

func add_bars():
	for i in range(4):
		add_bar()
