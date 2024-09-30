extends CharacterBody2D

@export var _animation_tree: AnimationTree = null
@export var npc_name: String
@export var npc_pos: Vector2
@export var quest: int

var _state_machine
var texture : CompressedTexture2D
var isNight : bool
var time : String
var inArea : bool = false

func _ready() -> void:
	time = GlobalTime.time
	_state_machine = _animation_tree["parameters/playback"]
	_state_machine.travel("Idle")

	if quest:
		Dialogic.VAR.quest = quest

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
			
	$Sprite2D.texture = texture
	_animation_tree["parameters/Idle/blend_position"] = npc_pos


func _process(_delta: float) -> void:
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight

	if inArea and Input.is_action_just_pressed("dialog"):
		Dialogic.VAR.name = npc_name
		if Dialogic.VAR.quest == 1:
			Dialogic.start("res://dialogo/timeline/timelineIntroducao21.dtl").register_character(load("res://dialogo/caracter"+npc_name+"/character"+npc_name+".dch"), $".")
			
		elif Dialogic.VAR.quest == 2 and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao2.dtl")

		elif Dialogic.VAR.quest == 3 and npc_name == "Cecilia" and !Dialogic.VAR.isTalking:
			Dialogic.start_timeline("res://dialogo/timeline/timelineIntroducao2.dtl")


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		inArea = true

func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		inArea = false
