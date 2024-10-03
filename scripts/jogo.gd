extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var static_npc = preload("res://scenes/player/static_npc.tscn")
var instanciate 

var names = ["Harry", "Keith", "Lana"]
var positions = [Vector2(-1041, -149), Vector2(-1169, -149), Vector2(-1122, -149)]
var createdStatic : bool = false

var created: bool = false 
var dialog : bool = false
var follow : bool = false
var npc_name : String

func _ready() -> void:
	$Player.position = GlobalTime.player_position

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
		npc_name = "Cecilia"
		if created:
			created = false
			remove_child(instanciate)
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = npc_name
			instanciate.position = Vector2(-950, -100)
			add_child(instanciate)

	if Dialogic.VAR.quest == 1 and !created and !follow:
		npc_name = "Cecilia"
		created = true
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-950, -100)
		instanciate.npc_pos = Vector2(-1, 0)
		add_child(instanciate)

	if Dialogic.VAR.quest == 3 and !created:
		npc_name = "Finn"
		created = true
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-1090, -398)
		instanciate.npc_pos = Vector2(0, 0)
		add_child(instanciate)


func _on_quest_body_entered(_body: Node2D) -> void:
	if Dialogic.VAR.quest == 3 and !dialog:
		dialog = true
		Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao1.dtl")

func _on_garagem_body_entered(_body: Node2D) -> void:
	GlobalTime.player_position = Vector2(GlobalTime.player_position.x, -144)
	if Dialogic.VAR.quest == 5:
		get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem.tscn") 
		return

	get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem_default.tscn") 
