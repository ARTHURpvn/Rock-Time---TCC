extends CharacterBody2D

var player
var direction: Vector2 = Vector2.ZERO
var follow_timer: float = 0.0  # Temporizador para controlar o atraso
var follow_delay: float = 0.5  # Tempo de atraso em segundos

@export var _move_speed: float = 200.0
@export var _friction: float = 0.1
@export var _acceleration: float = 0.1
@export var distance_behind: float = 20.0

@export_category("Objects")
@export var _animation_tree: AnimationTree = null
var _state_machine

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	player = get_node("/root/Jogo/Player")

func _process(delta: float) -> void:
	# Atualizar o temporizador
	if follow_timer > 0:
		follow_timer -= delta
		return  # Não seguir o jogador enquanto o temporizador estiver ativo

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
