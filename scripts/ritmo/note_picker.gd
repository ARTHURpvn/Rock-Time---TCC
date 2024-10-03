extends Node3D

var is_collecting = false
var is_pressed = false

@export var line: int = 2
var red_mat = preload("res://scenes/ritmo/notas/red_picker_mat.tres")
var green_mat = preload("res://scenes/ritmo/notas/green_picker_mat.tres")
var blue_mat = preload("res://scenes/ritmo/notas/blue_picker_mat.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_material()
	pass

func set_material():
	match line:
		1: $MeshInstance3D.material_override = green_mat
		2: $MeshInstance3D.material_override = blue_mat
		3: $MeshInstance3D.material_override = red_mat
	pass

func _process(_delta: float) -> void:
	if is_pressed:
		self.scale = Vector3(0.9, 0.9, 0.9)
	else :
		self.scale = Vector3(1, 1, 1)

func _input(event):
	match line:
		1:
			if event.is_action_pressed("ui_left"):
				is_pressed = true
				is_collecting = true

			elif event.is_action_released("ui_left"):
				is_pressed = false
				is_collecting = false
		2:
			if event.is_action_pressed("ui_down"):
				is_pressed = true
				is_collecting = true

			elif event.is_action_released("ui_down"):
				is_pressed = false
				is_collecting = false
		3: 
			if event.is_action_pressed("ui_right"):
				is_pressed = true
				is_collecting = true

			elif event.is_action_released("ui_right"):
				is_pressed = false
				is_collecting = false
