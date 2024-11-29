extends CharacterBody2D

var player 
var direction: Vector2 = Vector2.ZERO
var follow_timer: float = 0.1
var follow_delay: float = 0.1 
var texture

var isNight
var time 

@export var _move_speed: float = 64.0
@export var _friction: float = 0.4
@export var _acceleration: float = 0.4
@export var distance_behind: float = 20.0

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
			distance_behind = 30
		
		"Hanna":	
			texture = load('res://assets/personagens/lana.png')
			distance_behind = 50
		
		"Harry":
			texture = load('res://assets/personagens/harry.png')
			distance_behind = 40
	
		"Cecilia":
			texture = load('res://assets/personagens/cecilia.png')
		
		"Finn": 
			texture = load('res://assets/personagens/brianMay.png')

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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("correr"):
		_move_speed = _move_speed * 1.5
	elif event.is_action_released("correr"):
		_move_speed = _move_speed / 1.5

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
