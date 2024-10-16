extends Node2D
var isDialog : bool = false
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var static_npc = preload("res://scenes/player/static_npc.tscn")

var cutscene : bool = false
var names = ["Harry", "Keith", "Lana"]
var positions = [Vector2(-4, 79), Vector2(97, 68), Vector2(41, 39)]
var createdStatic : bool = false

func _ready() -> void:
	if Dialogic.VAR.quest == 0:
		Dialogic.start_timeline("res://dialogo/timeline/introducao2.dtl")

	if Dialogic.VAR.quest == 5 and Dialogic.VAR.Logo:
		Dialogic.VAR.Logo = false

func _process(_delta: float) -> void:
	if Dialogic.VAR.quest == 1:
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem_default.tscn")

	if !Dialogic.VAR.follow and !createdStatic and Dialogic.VAR.quest == 2:
		createdStatic = true
		for i in range(3):
			var instantiate = follow_npc.instantiate()
			instantiate.set_name(names[i - 1])
			instantiate.npc_name = names[i - 1]
			instantiate.position = positions[i - 1]
			add_child(instantiate)

	if Dialogic.VAR.quest == 2 and !Dialogic.VAR.isTalking:
		Dialogic.start_timeline("res://dialogo/timeline/introducao1.dtl")
	
	if Dialogic.VAR.quest == 5 and !Dialogic.VAR.isTalking and !Dialogic.VAR.Logo and !GlobalTime.quests[4].finished:
		Dialogic.start_timeline("res://dialogo/timeline/introducao1.dtl")

	if Dialogic.VAR.isCutscene and !cutscene:
		cutscene = true
		$AnimationPlayer.current_animation = Dialogic.VAR.cutscene

	if cutscene and $AnimationPlayer.current_animation != Dialogic.VAR.cutscene:
		GlobalTime.quests[4].finished = true
		Dialogic.VAR.isCutscene = false
		cutscene = false
	
	if Dialogic.VAR.quest == 5 and GlobalTime.quests[4].finished and Dialogic.VAR.Logo and !cutscene and !Dialogic.VAR.isCutscene:
		GlobalTime.player_position = Vector2(362, -286)
		GlobalTime.year = 1990
		Dialogic.VAR.follow = true
		GlobalTime.hour = 13
		GlobalTime.minu = 0
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")

func remove_existing_npcs():
	var npcs = get_children()
	for npc in npcs:
		if npc is StaticBody2D:  
			remove_child(npc)
			npc.queue_free()
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")
