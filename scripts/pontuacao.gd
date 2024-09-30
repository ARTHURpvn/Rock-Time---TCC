extends Node2D

func _process(delta: float) -> void:
	var points = GlobalTime.points
	$points.text = str(points)

	if $Button.button_pressed:
		get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem.tscn")
