extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var static_npc = preload("res://scenes/player/static_npc.tscn")
var instanciate 

var created: bool = false

var follow : bool = false
var npc_name = "Keith"

func _on_garagem_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem_default.tscn") 

func _on_quest_body_entered(_body: Node2D) -> void:
	if Dialogic.VAR.quest == 1:
		GlobalTime.questEnded = true 

func _process(_delta: float) -> void:
	if Dialogic.VAR.quest == 2 and !created:
		created = true
		
		if !follow:
			instanciate = static_npc.instantiate()
			instanciate.npc_name = npc_name
			instanciate.position = Vector2(-950, -100)
			instanciate.npc_pos = Vector2(-1, 0)
			add_child(instanciate)
			
		else:
			remove_child(instanciate)
			instanciate = follow_npc.instantiate()
			add_child(instanciate)
