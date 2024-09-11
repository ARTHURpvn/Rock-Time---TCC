extends Node3D

var red_mat = preload("res://scenes/ritmo/notas/red_note_mat.tres")
var green_mat = preload("res://scenes/ritmo/notas/green_note_mat.tres")
var blue_mat = preload("res://scenes/ritmo/notas/blue_note_mat.tres")

@onready var point = get_node("/root/Game/Points")
@export var line: int = 2
var length
var length_scale
var speed

var is_colliding = false
var collected = false
var picker

func _ready() -> void:
	_on_ready()

func _on_ready() -> void:
	set_material() 
	set_note_position()
	add_listeners()

func _process(_delta: float) -> void:
	_on_process(_delta)

func _on_process(_delta: float) -> void:
	pass

func set_material() -> void:
	match line:
		1: $MeshInstance3D.material_override = green_mat
		2: $MeshInstance3D.material_override = blue_mat
		3: $MeshInstance3D.material_override = red_mat


func set_note_position() -> void:
	var x
	match line:
		1: x = -1.2
		2: x = 0
		3: x = 1.2
			
	self.set_position(Vector3(x, 0, -position.z * length_scale))

func add_listeners():
	$Area.add_to_group("note")
	$Area.connect("area_entered", _on_area_entered) 
	$Area.connect("area_exited", _on_area_exited) 

func collect() -> void:
	collected = true
	picker.is_collecting = false
	hide()

func _on_area_entered(area) -> void:
	if area.is_in_group("picker"):
		is_colliding = true
		picker = area.get_parent()


func _on_area_exited(area) -> void:
	if area.is_in_group("picker"):
		is_colliding = false
