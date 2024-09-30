extends Node2D

func _ready() -> void:
	Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao2.dtl")

func _process(_delta: float) -> void:
	if Dialogic.VAR.quest == 1:
		get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem_default.tscn")
