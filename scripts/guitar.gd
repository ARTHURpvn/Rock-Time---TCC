extends Node2D

var positions: Array = []
var current_note = 0
@export var tiles: PackedScene
@export var bpm: float  # Exporte o BPM para que possa ser ajustado na interface do Godot
var notes_info = []
var timer_interval: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	positions.append($Baixo/ondeApertar.global_position.x)
	positions.append($Baixo/ondeApertar2.global_position.x)
	positions.append($Baixo/ondeApertar3.global_position.x)
	
	# Carregar os dados do JSON e configurar o timer
	notes_info = $JSON.get_notes_info()
	if notes_info.size() > 0:
		calculate_timer_interval()
		start_timer()

func calculate_timer_interval():
	# Calcular o intervalo entre batidas com base no BPM
	timer_interval = 60 / bpm

func start_timer():
	$Timer.wait_time = timer_interval
	$Timer.start()

func _spawn():
	if current_note >= len(notes_info):
		return  # Se não há mais notas para processar, sair
	
	var tiles_instance = tiles.instantiate()
	var pos = $Marker2D.position

	# Configurar a posição para o spawn
	pos.x = positions[notes_info[current_note]["value"] - 1]
	tiles_instance.spawn(notes_info[current_note]["value"], pos)
	add_child(tiles_instance)

func _on_timer_timeout():
	_spawn()
	current_note += 1

	# Verificar se ainda há notas e ajustar o timer para o próximo spawn
	if current_note < len(notes_info):
		$Timer.wait_time = notes_info[current_note]["position"] / 1000.0  # Converta milissegundos para segundos se necessário
