extends Node
var scene = false

func _ready():
	Dialogic.start_timeline("res://dialogo/timeline/timelineTutorial.dtl")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var isPLaiyng = Dialogic.VAR.playing

	if isPLaiyng and !scene :
		scene = true
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")