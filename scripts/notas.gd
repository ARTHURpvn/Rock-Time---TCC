extends Node2D

@export var _bpm: float
var inside_area = false
var select_key = 0
var fall_speed: float = 0.0
var distance_to_fall: float = 440  # Distância que a nota deve percorrer
var speed_scale: float = 0.3  # Fator de escala para reduzir a velocidade

func _ready():
	# Calcular o intervalo entre batidas em segundos
	var beat_interval = 60 / _bpm
	# Calcular a velocidade de queda ideal e aplicar o fator de escala
	fall_speed = (distance_to_fall / beat_interval) * speed_scale

func _process(_delta):
	# Atualizar a posição do objeto com base na velocidade de queda
	position.y += fall_speed * _delta

	if inside_area:
		if Input.is_key_pressed(select_key):
			print("Acertou")
			queue_free()

func spawn(key: int, pos: Vector2) -> void:
	position = pos
	# Resetar a posição de tempo (se necessário)
	# (Por exemplo, se você precisar resetar a posição do tempo)
	# time_since_spawn = 0.0

	match key:
		1:
			select_key = KEY_LEFT
			rotation_degrees = 0
		2:
			select_key = KEY_RIGHT
			rotation_degrees = 180
		3:
			select_key = KEY_UP
			rotation_degrees = 90

func _on_area_entered(_area):
	inside_area = true

func _on_area_exited(_area):
	inside_area = false
