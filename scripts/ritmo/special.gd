extends Node3D
var normalStyle = preload("res://scenes/special.tres")
var activeStyle = preload("res://scenes/specialActive.tres")

@onready var point = get_node("/root/Game/Points")
var tile: float

func _process(_delta):
	tile = point.tiles
	$tiles.scale.y = tile

	if tile <= 0.5 and !point.special:
		$tiles.scale.y = tile
		$tiles.material_override = normalStyle

	else:
		$tiles.material_override = activeStyle
		if !point.special && Input.is_action_just_pressed("special"):
			point.special = true
			Dialogic.VAR.special - true
