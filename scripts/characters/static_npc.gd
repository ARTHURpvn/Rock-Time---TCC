extends CharacterBody2D

@export var _animation_tree: AnimationTree = null
@export var npc_name: String
@export var npc_pos: Vector2

var _state_machine
var texture : CompressedTexture2D
var isNight : bool
var time : String
var inArea : bool = false
var isPlaying : bool = false
var menu = preload("res://scenes/cenas/ui/menu.tscn")
var isMenu : bool
var instMenu

func _ready() -> void:
	time = GlobalTime.time
	_state_machine = _animation_tree["parameters/playback"]
	_state_machine.travel("Idle")

	match npc_name:
		"Lana":
			texture = load('res://assets/personagens/lana.png')
			
		"Keith":
			texture = load('res://assets/personagens/keith.png')
		
		"Hanna":	
			texture = load('res://assets/personagens/lana.png')
		
		"Harry":
			texture = load('res://assets/personagens/harry.png')
	
		"Cecilia":
			texture = load('res://assets/personagens/cecilia.png')

		"Finn":
			texture = load('res://assets/personagens/Finn.png')

		"Bruno Mars":
			texture = load('res://assets/personagens/brunoMars.png')

		"Michael Jackson":
			texture = load('res://assets/personagens/michaelJackson.png')
			
	$Sprite2D.texture = texture
	_animation_tree["parameters/Idle/blend_position"] = npc_pos


func _process(_delta: float) -> void:
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight

	if Dialogic.VAR.Ritmo.playing and !isPlaying:
		isPlaying = true
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")

	if inArea and Input.is_action_just_pressed("dialog"):
		Dialogic.VAR.name = npc_name
		if Dialogic.VAR.quest == 1 and npc_name == "Cecilia" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/introducao2.dtl")
		
		if  Dialogic.VAR.quest == 2 and npc_name == "Harry" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/fimQuestCeci.dtl")

		if Dialogic.VAR.quest == 4 and npc_name == "Finn" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/introducao1.dtl")


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		inArea = true
		
		if !isMenu:
			isMenu = true
			instMenu = menu.instantiate()
			
			instMenu.texto = "Conversar"
			add_child(instMenu)
		
		if Dialogic.VAR.quest == 6 and npc_name == "Bruno Mars" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/questBruno.dtl")

		if Dialogic.VAR.quest == 7 and npc_name == "Michael Jackson" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/questMichael.dtl")

func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		inArea = false

		if isMenu:
			isMenu = false
			remove_child(instMenu)
