extends Node
var created : bool = false

func _ready() -> void:
	Dialogic.start_timeline("res://dialogo/timeline/tutorial.dtl")
	$AnimationPlayer.current_animation = "inicial"

func _process(_delta : float) -> void:
	if Dialogic.VAR.paused and !created:
		created = true
		$teclas.visible = true
		get_tree().paused = true
