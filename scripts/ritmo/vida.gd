extends Node3D
var life = 100

func _process(_delta: float) -> void:
	var vida = str(life)
	$Life.text = vida

	if life <= 0:
		get_tree().change_scene_to_file("res://scenes/derrota.tscn")
