extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var inRange : bool = false
var created : bool = false
var instanciate

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/primeira-fase/jogo.tscn")
		
func _process(_delta: float) -> void:
	if Dialogic.VAR.follow:
		if !created:
			created = true
			var npc_name = "Cecilia"
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = npc_name
			instanciate.position = Vector2(231, 184)
			add_child(instanciate)
