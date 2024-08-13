extends CharacterBody2D

var _state_machine
var d_active = false
var dialogue = []

@export_category("Variables")
@export var _move_speed: float = 64.0

@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _animation_tree: AnimationTree = null


var player
var player_in_chat_zone = false

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]


func _physics_process(_delta: float) -> void:
	if player_in_chat_zone and Input.is_action_just_pressed("dialog"):
		$"User Interface".start()
	_move()
	_animate()
	move_and_slide()


func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("mv_esquerda", "mv_direito"),
		Input.get_axis("mv_cima", "mv_baixo")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/Idle/blend_position"] = _direction
		_animation_tree["parameters/Walk/blend_position"] = _direction
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
		

func _on_chat_detection_area_body_entered(body):
	if !body.has_method("npc_teste"):
		player = body
		player_in_chat_zone = true 

func _on_chat_detection_area_body_exited(body):
	if body.has_method("npc_teste"):
		player_in_chat_zone = false 


func enter_dialogue():
	if player_in_chat_zone:
		dialogue = $"User Interface".load_dialogue()

func _animate() -> void:
	if velocity.length() > 5:
		_state_machine.travel("Walk")
		return
		
	_state_machine.travel("Idle")
