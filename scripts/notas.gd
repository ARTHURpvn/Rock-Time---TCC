extends Node2D

@export var _bpm: float
var inside_area = false
var select_key = 0
var fall_speed: float = 0.0
var distance_to_fall: float = 400 
var speed_scale: float = 0.3  

func _ready():
	# Calcular o intervalo entre batidas em segundos
	var beat_interval = 60 / _bpm
	# Calcular a velocidade de queda ideal e aplicar o fator de escala
	fall_speed = (distance_to_fall / beat_interval) * speed_scale

func _process(delta: float):
	# Atualizar a posição do objeto com base na velocidade de queda
	position.y += fall_speed * delta

	if inside_area:
		if Input.is_key_pressed(select_key):
			print("Acertou")
			queue_free()

func spawn(key: int, pos: Vector2) -> void:
	position = pos

	match key:
		1:
			select_key = KEY_LEFT
		2:
			select_key = KEY_RIGHT
		3:
			select_key = KEY_UP
		4:
			select_key = KEY_DOWN
			
	

func _on_area_entered(_area):
	inside_area = true

func _on_area_exited(_area):
	inside_area = false
