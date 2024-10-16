extends Node3D
var life : int

func _process(_delta: float) -> void:
	life = GlobalTime.life
	var vida = str(life)
	$Life.text = vida

	if life <= 0:
		get_tree().change_scene_to_file("res://scenes/cenas/derrota.tscn")
