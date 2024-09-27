extends CharacterBody2D

var player
var direction: Vector2 = Vector2.ZERO
var follow_timer: float = 0.5
var follow_delay: float = 0.5 

var isNight
var time 

@export var _move_speed: float = 60.0
@export var _friction: float = 0.1
@export var _acceleration: float = 0.5
@export var distance_behind: float = 20.0

@export_category("Objects")
@export var _animation_tree: AnimationTree = null
var _state_machine

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	player = get_node("../Player")
	time = GlobalTime.time

func _process(delta: float) -> void:
	# Atualizar o temporizador
	if follow_timer > 0:
		follow_timer -= delta
		return  # Não seguir o jogador enquanto o temporizador estiver ativo
	
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight
	
	var player_pos = player.position
	direction = (player_pos - position).normalized()
	
	# Calcular a posição alvo com base na distância desejada atrás do jogador
	var target_pos = player_pos - direction * distance_behind
	
	# Atualizar animações
	_animate()
	
	# Mover o personagem em direção à posição alvo
	_move(target_pos)
	move_and_slide() 

func _move(target_pos: Vector2) -> void:
	# Calcular a direção e a distância para o alvo
	var move_direction = (target_pos - position).normalized()
	var distance_to_target = (target_pos - position).length()
	
	if distance_to_target > 3:  # Tolerância para evitar o tremor
		_animation_tree["parameters/Idle/blend_position"] = move_direction
		_animation_tree["parameters/Walk/blend_position"] = move_direction
		
		# Aceleração
		velocity = lerp(velocity, move_direction * _move_speed, _acceleration)
	else:
		# Aplicar fricção se não houver direção
		velocity = lerp(velocity, Vector2.ZERO, _friction)

func _animate() -> void:
	if velocity.length() > 5:
		_state_machine.travel("Walk")
	else:
		_state_machine.travel("Idle")

# Função para iniciar o seguimento com um atraso
func start_following() -> void:
	follow_timer = follow_delay
