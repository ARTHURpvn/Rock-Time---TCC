extends CharacterBody2D

var player 
var direction: Vector2 = Vector2.ZERO
var follow_timer: float = 0.2
var follow_delay: float = 0.2 
var texture

var isNight
var time 

@export var _move_speed: float = 60.0
@export var _friction: float = 0.1
@export var _acceleration: float = 0.5
@export var distance_behind: float = 30.0

@export var npc_name: String

@export_category("Objects")
@export var _animation_tree: AnimationTree = null
var _state_machine

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	time = GlobalTime.time
	player = get_node("../Player")
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
			texture = load('res://assets/personagens/finn.png')

	$Sprite2D.texture = texture

func _process(delta: float) -> void:
	if follow_timer > 0:
		follow_timer -= delta
		return  

	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight
	
	var player_pos = player.position
	direction = (player_pos - position).normalized()
	
	var target_pos = player_pos - direction * distance_behind
	
	_animate()
	_move(target_pos)
	move_and_slide() 

func _move(target_pos: Vector2) -> void:
	var move_direction = (target_pos - position).normalized()
	var distance_to_target = (target_pos - position).length()
	
	if distance_to_target > 3:
		_animation_tree["parameters/Idle/blend_position"] = move_direction
		_animation_tree["parameters/Walk/blend_position"] = move_direction
	
		velocity = lerp(velocity, move_direction * _move_speed, _acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, _friction)

func _animate() -> void:
	if velocity.length() > 5:
		_state_machine.travel("Walk")
	else:
		_state_machine.travel("Idle")

func start_following() -> void:
	follow_timer = follow_delay
