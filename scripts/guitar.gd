extends Node2D

var positions: Array = []
var current_note: int = 0
@export var tiles: PackedScene
@export var bpm: float

var notes_info: Array = []
var elapsed_time: float = 0.0

var distance_to_fall: float = 400  # Distância que a nota percorre
var speed_scale: float = 0.3  # Fator de escala para a velocidade

func _ready():
	# Definindo as posições das notas
	positions.append($Baixo/ondeApertar.global_position.x)
	positions.append($Baixo/ondeApertar2.global_position.x)
	positions.append($Baixo/ondeApertar3.global_position.x)
	positions.append($Baixo/ondeApertar4.global_position.x)
	
	# Carregando as informações das notas
	notes_info = $JSON.load_json()
	

func _process(delta: float):
	elapsed_time += delta

	# Checando se já é o momento de spawnar a próxima nota
	while current_note < notes_info.size() and notes_info[current_note]["position"] <= elapsed_time:
		_spawn(notes_info[current_note]["value"])
		current_note += 1

func _spawn(note_value: int):
	var tiles_instance = tiles.instantiate()
	var pos = $Marker2D.position

	# Configurar a posição para o spawn
	pos.x = positions[note_value - 1]  
	pos.y = $Marker2D.position.y + notes_info[note_value]["position"]
	tiles_instance.position = pos
	tiles_instance.spawn(note_value, pos)
	add_child(tiles_instance)
