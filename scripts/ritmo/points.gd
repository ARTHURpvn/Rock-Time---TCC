extends Node3D

var points: int

func add_points(point):
	points += point
	$Points.text = str(points)
