extends Node2D
var inRange : bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/primeira-fase/jogo.tscn")

func _process(_delta: float) -> void:
	if Dialogic.VAR.quest == 2:
		if inRange and Input.is_action_pressed("dialog"):
			Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao2.dtl")

func _on_quest_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		inRange = true

func _on_quest_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		inRange = false
