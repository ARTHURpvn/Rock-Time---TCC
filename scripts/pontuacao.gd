extends Node2D

func _process(delta: float) -> void:
	var points = GlobalTime.points
	$points.text = points
