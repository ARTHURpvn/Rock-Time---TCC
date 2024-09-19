extends Node3D

var red_mat = preload("res://scenes/ritmo/notas/red_beam_mat.tres")
var green_mat = preload("res://scenes/ritmo/notas/green_beam_mat.tres")
var blue_mat = preload("res://scenes/ritmo/notas/blue_beam_mat.tres")
	
func set_material(line, special):
	print(special)
	if special:
		print("foi")

		match line:
			1: $MeshInstance3D.material_override = blue_mat
			2: $MeshInstance3D.material_override = blue_mat
			3: $MeshInstance3D.material_override = blue_mat
	else:
		match line:
			1: $MeshInstance3D.material_override = green_mat
			2: $MeshInstance3D.material_override = blue_mat
			3: $MeshInstance3D.material_override = red_mat
