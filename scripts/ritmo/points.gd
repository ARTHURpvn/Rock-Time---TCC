extends Node3D

var points: int
var special = false
var tiles: float
var combo: float

func add_points(point):
	if special:
		points += (point * combo) * 1.3
	
	points += (point * combo)

	if tiles <= 0.5 and !special:
		tiles += 0.01
	$Points.text = str(points)

func _on_timer_timeout() -> void:
	if special:
		if tiles > 0:
			tiles -= 0.01
			
		if tiles <= 0:
			special = false
			Dialogic.VAR.special = false
