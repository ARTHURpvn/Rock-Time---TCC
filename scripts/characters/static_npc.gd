extends CharacterBody2D

@export var _animation_tree: AnimationTree = null
@export var npc_name: String
@export var npc_pos: Vector2

var _state_machine
var texture 
var isNight
var time

func _ready():
	time = GlobalTime.time
	_state_machine = _animation_tree["parameters/playback"]
	_state_machine.travel("Idle")

	match npc_name:
		"Lana":
			texture = load('res://assets/personagens/lana.png')
			$Sprite2D.texture = texture
			
		"Keith":
			texture = load('res://assets/personagens/lana.png')
			$Sprite2D.texture = texture
		
		"Hanna":	
			texture = load('res://assets/personagens/lana.png')
			$Sprite2D.texture = texture
		
		"Harry":
			texture = load('res://assets/personagens/harry.png')
			$Sprite2D.texture = texture
	
	_animation_tree["parameters/Idle/blend_position"] = npc_pos
func _process(_delta):
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight
