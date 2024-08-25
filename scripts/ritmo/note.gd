extends Node3D

@export var line: int = 2
var red_mat = preload("res://scenes/ritmo/notas/red_note_mat.tres")
var green_mat = preload("res://scenes/ritmo/notas/green_note_mat.tres")
var blue_mat = preload("res://scenes/ritmo/notas/blue_note_mat.tres")

var is_colliding = false
var collected = false
var picker

func _ready() -> void:
	set_material() 
	set_note_position()

func _process(_delta: float) -> void:
	collect()

func set_material() -> void:
	match line:
		1: $MeshInstance3D.material_override = green_mat
		2: $MeshInstance3D.material_override = blue_mat
		3: $MeshInstance3D.material_override = red_mat
	pass


func set_note_position() -> void:
	var x
	match line:
		1: x = -1.2
		2: x = 0
		3: x = 1.2
			
	self.set_position(Vector3(x, 0, -position.z))
	
func collect() -> void:
	if not collected:
		if is_colliding and picker:
			if picker.is_collecting:
				collected = true
				picker.is_collecting = false
				hide()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_colliding = true
		picker = area.get_parent()


func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("picker"):
		is_colliding = false
