extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var static_npc = preload("res://scenes/player/static_npc.tscn")
var npc = preload("res://scenes/player/npc_teste.tscn")

var alert = preload("res://scenes/cenas/ui/minimapa/alert.tscn")
var menu = preload("res://scenes/cenas/ui/menu.tscn")

var instanciate 
var instAlert
var instMenu

var isPlayer : bool = false
var isMenu : bool = false

var names = ["Harry", "Keith", "Lana"]
var positions = [ Vector2(-1041, 114), Vector2(-1169, 114), Vector2(-1122, 114) ]
var createdStatic : bool = false

var created: bool = false 
var follow : bool = false
var npc_name : String

func _ready() -> void:
	$Player.position = GlobalTime.player_position
	follow = Dialogic.VAR.follow

	if Dialogic.VAR.quest == 1 and !follow:
		if !Dialogic.VAR.Logo:
			instAlert = alert.instantiate()
			instAlert.position = Vector2(182, -776)
			add_child(instAlert)
		else:
			instAlert = alert.instantiate()
			instAlert.position = Vector2(-1120, 83)
			add_child(instAlert)

		npc_name = "Cecilia"
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(182, -776)
		instanciate.npc_pos = Vector2(-1, 0)
		add_child(instanciate)

func _process(_delta: float) -> void:
	GlobalTime.player_position = $Player.position
	follow = Dialogic.VAR.follow

	if Dialogic.VAR.quest == 1 and !Dialogic.VAR.isTalking and Dialogic.VAR.Logo:
		Dialogic.start_timeline("res://dialogo/timeline/fimQuestCeci.dtl")

	if follow and Dialogic.VAR.quest == 2:
		npc_name = "Cecilia"
		if !created:
			created = true
			remove_child(instanciate)
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = npc_name
			instanciate.position = Vector2(182, -776)
			add_child(instanciate)

	if Dialogic.VAR.follow and !createdStatic and Dialogic.VAR.quest == 3:
		createdStatic = true
		instAlert = alert.instantiate()
		instAlert.position = Vector2(-1090, -398)
		add_child(instAlert)

		for i in range(3):
			var instantiate = follow_npc.instantiate()
			instantiate.set_name(names[i - 1])
			instantiate.npc_name = names[i - 1]
			instantiate.position = positions[i - 1]
			add_child(instantiate)

	if Dialogic.VAR.quest == 3 and !created:
		npc_name = "Finn"
		created = true
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-1090, -398)
		instanciate.npc_pos = Vector2(0, 0)
		add_child(instanciate)

	if Dialogic.VAR.quest >= 5 and GlobalTime.quests[4].finished and !created:
		created = true
		positions[0] = Vector2(370, -277) 
		positions[1] = Vector2(373, -290)
		positions[2] = Vector2(365, -270) 

		for i in range(3):
			var instantiate = follow_npc.instantiate()
			instantiate.set_name(names[i - 1])
			instantiate.npc_name = names[i - 1]
			instantiate.position = positions[i - 1]
			add_child(instantiate)

		if !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/novoMundo1.dtl")

	if GlobalTime.year == 1990 and !createdStatic and Dialogic.VAR.quest == 5 or GlobalTime.year == 1990 and !createdStatic and Dialogic.VAR.quest == 6:
		createdStatic = true
		npc_name = "Finn"
		instanciate = npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(437, -230)
		add_child(instanciate)
		
		npc_name = "Bruno Mars"
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(192, -263)
		instanciate.npc_pos = Vector2(1, 0)
		add_child(instanciate)

	if Dialogic.VAR.quest == 5 and GlobalTime.quests[4].finished and !Dialogic.VAR.isTalking and !Dialogic.VAR.Cecilia and !Dialogic.VAR.Logo or Dialogic.VAR.quest == 5 and GlobalTime.quests[4].finished and !Dialogic.VAR.isTalking and Dialogic.VAR.Cecilia and Dialogic.VAR.Logo:
		Dialogic.start_timeline("res://dialogo/timeline/novoMundo1.dtl")

	if Dialogic.VAR.quest == 7 and createdStatic:
		createdStatic = false
		npc_name = "Michael Jackson"
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-394, -794)
		instanciate.npc_pos = Vector2(-1, 0)
		add_child(instanciate)

	if Dialogic.VAR.quest == 7 and !createdStatic and Dialogic.VAR.Logo:
		createdStatic = true
		Dialogic.VAR.Logo = false
		npc_name = "Michael Jackson"
		instanciate = static_npc.instantiate()
		instanciate.npc_name = npc_name
		instanciate.position = Vector2(-394, -794)
		instanciate.npc_pos = Vector2(-1, 0)
		add_child(instanciate)

	if Dialogic.VAR.quest == 6 and !Dialogic.VAR.isTalking and Dialogic.VAR.Logo:
		Dialogic.start_timeline("res://dialogo/timeline/questBruno.dtl")

	if Dialogic.VAR.quest == 7 and !Dialogic.VAR.isTalking and Dialogic.VAR.Cecilia:
		Dialogic.start_timeline("res://dialogo/timeline/questBruno.dtl")

	if isPlayer and !isMenu:
		isMenu = true
		instMenu = menu.instantiate()
		add_child(instMenu)

	if !isPlayer and isMenu:
		isMenu = false
		remove_child(instMenu)

	if isPlayer and  Input.is_action_just_pressed("dialog"):
		GlobalTime.player_position = Vector2(GlobalTime.player_position.x, 114)
		if Dialogic.VAR.quest == 5:
			get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem.tscn")
			return
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem_default.tscn")


func _on_quest_body_entered(body: Node2D) -> void:		
	if body.name == "Player":
		if Dialogic.VAR.quest == 3 and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/introducao1.dtl")

func _on_garagem_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = true

func _on_garagem_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = false
