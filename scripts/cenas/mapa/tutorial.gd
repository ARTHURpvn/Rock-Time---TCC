extends Node

func _ready():
	Dialogic.start_timeline("res://dialogo/timeline/tutorial.dtl")
	$AnimationPlayer.current_animation = "inicial"
