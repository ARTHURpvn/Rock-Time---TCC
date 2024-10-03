extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var static_npc = preload("res://scenes/player/static_npc.tscn")
var instanciate 

var names = ["Harry", "Keith", "Lana"]
var positions = [Vector2(-4, 79), Vector2(97, 68), Vector2(41, 39)]
var createdStatic : bool = false

var created: bool = false 
var follow : bool = false
var npc_name = "Cecilia"

func _ready() -> void:

	$Player.position = GlobalTime.player_position

func _on_garagem_body_entered(_body: Node2D) -> void:
	GlobalTime.player_position = Vector2(GlobalTime.player_position.x, -144)
	get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem_default.tscn") 

func _process(_delta: float) -> void:
	GlobalTime.player_position = $Player.position
	follow = Dialogic.VAR.follow

	if Dialogic.VAR.follow and !createdStatic and Dialogic.VAR.quest == 3:
		createdStatic = true
		for i in range(3):
			var instantiate = follow_npc.instantiate()
			instantiate.set_name(names[i - 1])
			instantiate.npc_name = names[i - 1]
			instantiate.position = positions[i - 1]
			add_child(instantiate)

	if follow and Dialogic.VAR.quest == 2:
		if created:
			created = false
			remove_child(instanciate)
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = npc_name
			instanciate.position = Vector2(-950, -100)
			add_child(instanciate)

	if Dialogic.VAR.quest == 1 and !created and !follow:
		created = true
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-950, -100)
		instanciate.npc_pos = Vector2(-1, 0)
		add_child(instanciate)


func _on_quest_body_entered(_body: Node2D) -> void:
	if Dialogic.VAR.quest == 3 and !created:
		created = true
		Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao1.dtl")
