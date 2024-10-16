extends Node2D

func _process(_delta: float) -> void:
	GlobalTime.musicEnded = false
	Dialogic.VAR.Ritmo.playing = false
	var points = GlobalTime.points
	$"Pontuação/points".text = str(points)

	if $"Pontuação/Button".button_pressed:
		if Dialogic.VAR.quest == 0:
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem.tscn")

		if Dialogic.VAR.quest == 1 or Dialogic.VAR.quest == 6:
			Dialogic.VAR.Logo = true
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")

		if Dialogic.VAR.quest == 7:
			Dialogic.VAR.Cecilia = true
			Dialogic.VAR.Logo = true
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")
