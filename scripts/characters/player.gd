extends CharacterBody2D
class_name Player
var _state_machine
var isNight
var time

@export_category("Variables")
@export var _move_speed: float = 64.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	time = GlobalTime.time

func _physics_process(_delta: float) -> void:
	if !Dialogic.VAR.isTalking:
		_move()
		move_and_slide()
	_animate()
	
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("correr"):
		_move_speed = _move_speed * 1.5
	elif event.is_action_released("correr"):
		_move_speed = _move_speed / 1.5

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

func _animate() -> void:
	if Dialogic.VAR.isTalking:
		_state_machine.travel("Idle")
		return

	if velocity.length() > 5:
		_state_machine.travel("Walk")
		return
		
	_state_machine.travel("Idle")
