extends Node3D
@onready var bars_node = $BarsNode

var bar_scn = preload("res://scenes/ritmo/bar.tscn")
var bars = []

var bar_lenght_in_m = 8
var curr_location = Vector3(0, 0, -bar_lenght_in_m)
var speed = Vector3(0,0,2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4):
		add_bar()

func _process(delta: float) -> void:
	bars_node.translate(speed*delta)

	for bar in bars:
		if bar.position.z + bars_node.position.z >= bar_lenght_in_m:
			remove_bar(bar)
			add_bar()

func add_bar():
	var bar = bar_scn.instantiate()
	bar.set_position(Vector3(curr_location.x, curr_location.y, curr_location.z))
	bars.append(bar)
	bars_node.add_child(bar)
	curr_location += Vector3(0, 0, -bar_lenght_in_m)

func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)
