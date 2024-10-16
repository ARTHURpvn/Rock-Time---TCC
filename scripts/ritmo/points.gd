extends Node3D

var points: int = GlobalTime.points
var special : bool = GlobalTime.special
var tiles: float = GlobalTime.tiles
var acertos: float = GlobalTime.acertos
var combo: float = GlobalTime.combo


func _on_timer_timeout() -> void:
	if special:
		if acertos > 0:
			acertos -= 0.01
			
		if acertos <= 0:
			special = false
			Dialogic.VAR.Ritmo.special = false

func _process(_delta: float) -> void:
	points = GlobalTime.points
	special = GlobalTime.special
	tiles = GlobalTime.tiles
	acertos = GlobalTime.acertos
	combo = GlobalTime.combo

	$Points.text = str(points)