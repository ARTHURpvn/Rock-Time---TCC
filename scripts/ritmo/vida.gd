extends Node3D
var life = 100

func _process(delta: float) -> void:
	var vida = str(life)
	$Life.text = vida
