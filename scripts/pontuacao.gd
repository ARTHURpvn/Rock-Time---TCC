extends Node2D

func _process(_delta: float) -> void:
	GlobalTime.musicEnded = false
	Dialogic.VAR.Ritmo.playing = false
	var points = GlobalTime.points
	$points.text = str(points)

	if $Button.button_pressed:
		if Dialogic.VAR.quest == 0:
			get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem.tscn")

		if Dialogic.VAR.quest == 1:
			Dialogic.VAR.Logo = true
			get_tree().change_scene_to_file("res://scenes/primeira-fase/jogo.tscn")
