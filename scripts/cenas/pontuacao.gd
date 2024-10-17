extends Node2D
var clicked : bool = false

func _process(_delta: float) -> void:
	GlobalTime.musicEnded = false
	Dialogic.VAR.Ritmo.playing = false
	var points = GlobalTime.points
	$Pontuacao/points.text = str(points)

	if $Pontuacao/Button.button_pressed:
		print("clicou")
		print(Dialogic.VAR.quest, clicked)
		if Dialogic.VAR.quest == 0 and !clicked:
			print("passou aqui")
			clicked = true
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem.tscn")

		if Dialogic.VAR.quest == 1 or Dialogic.VAR.quest == 6 and !clicked:
			clicked = true
			Dialogic.VAR.Logo = true
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")

		if Dialogic.VAR.quest == 7 and !clicked:
			clicked = true
			Dialogic.VAR.Cecilia = true
			Dialogic.VAR.Logo = true
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")
