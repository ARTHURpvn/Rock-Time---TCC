extends Node3D

var points: int
var special = false
var tiles: float
var acertos: float
var combo: float

func add_points(point):
	if special:
		points += (point * combo) * 1.3
	
	points += (point * combo)

	if acertos <= 0.5 and !special:
		tiles += 1
		acertos += 0.01
	$Points.text = str(points)
	GlobalTime.points = points

func _on_timer_timeout() -> void:
	if special:
		if acertos > 0:
			acertos -= 0.01
			
		if acertos <= 0:
			special = false
			Dialogic.VAR.Ritmo.special = false
