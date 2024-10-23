extends Node3D
var normalStyle = preload("res://scenes/special.tres")
var activeStyle = preload("res://scenes/specialActive.tres")

var tile: float

func _process(_delta):
	tile = GlobalTime.acertos
	$tiles.scale.y = tile

	if tile <= 0.5 and !GlobalTime.special:
		$tiles.scale.y = tile
		$tiles.material_override = normalStyle

	else:
		$tiles.material_override = activeStyle
		if !GlobalTime.special and Input.is_action_just_pressed("special"):
			GlobalTime.special = true

	if tile >= 0.01 and GlobalTime.special:
		GlobalTime.acertos -= 0.001

	elif tile <= 0.01 and GlobalTime.special:
		GlobalTime.special = false
