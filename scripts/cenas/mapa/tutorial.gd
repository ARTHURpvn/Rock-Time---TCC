extends Node
var scene = false
var zoom = 1
var endAnim = false

func _ready():
	Dialogic.start_timeline("res://dialogo/timeline/tutorial.dtl")

func _process(_delta):
	var isPLaiyng = Dialogic.VAR.Ritmo.playing

	if $Camera2D.zoom.x <= 2.5:
		zoom += 0.005

	$Camera2D.zoom.x = zoom
	$Camera2D.zoom.y = zoom

	if isPLaiyng and !scene :
		scene = true
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")

	if Dialogic.VAR.Logo:
		$Logo.visible = true
	
	if endAnim and !Dialogic.VAR.Logo:
		$Logo.visible = false
		$City.visible = false

	if Dialogic.VAR.Ritmo.special:
		Dialogic.start_timeline("res://dialogo/timeline/tutorial.dtl")
