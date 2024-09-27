extends Node
var scene = false

func _ready():
	Dialogic.start_timeline("res://dialogo/timeline/timelineTutorial.dtl")


func _process(_delta):
	var isPLaiyng = Dialogic.VAR.playing

	if isPLaiyng and !scene :
		scene = true
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")

	if Dialogic.VAR.musicEnd == true:
		print("Musica Acabou")
		Dialogic.VAR.quest = 2

	if Dialogic.VAR.quest >= 1:
		print("Apareceu a Quest")
		get_tree().change_scene_to_file("res://scenes/quest.tscn")
