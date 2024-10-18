extends Node

var hour: int = 12
var minu: int = 0
var isNight: bool = false
var time: String = str(hour)+":"+str(minu)
var musicEnded : bool = false
var player_position : Vector2 = Vector2(-1060, 114)
var year : int = 1990

var isPlaying : bool = false
var isEnd : bool = false

var harryPosition : Vector2 = Vector2(-67, -6)
var hannaPosition : Vector2
var lanaPosition : Vector2 = Vector2(-127, -11)
var keithPosition : Vector2 = Vector2(-128, 69)
var castPosition : Vector2 = Vector2(-63, 20)


var life : int = 100
var points : int = 0
var special : bool = false
var tiles : int = 0
var acertos: float = 0
var combo: float = 1

var life_adv : int = 100
var points_adv : int = 0
var special_adv : bool = false
var tiles_adv : int = 0
var acertos_adv: float = 0
var combo_adv: float = 1
var amplificador : bool = false

var quests = [
	{ "name": "Buscar Irma do Harry", "finished": false, "todo": "Caminhe ate a Escola e Busque a Cecilia"},
	{ "name": "Buscar Irma do Harry", "finished": false, "todo": "Volte para a Garagem e Encontre Harry"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Va para o Estacionamento"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Converse Com o Cara Misterioso"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Volte para Casa com os Amplificadores"},
	{ "name": "Explore o Mapa", "finished": false, "todo": "Explore ao seu redor e ache o musico!"},
	{ "name": "Procure pelo oponente", "finished": false, "todo": "Explore a cidade em busca de Informacoes para encontrar o oponente"},
]
var quest : int = 0

func add_points(point):
	if special:
		points += (point * combo) * 1.3
	
	points += (point * combo)

	if acertos <= 0.5 and !special:
		tiles += 1
		acertos += 0.01

func timer():
	if Dialogic.VAR.quest >= 1:
		if minu == 59:
			if hour == 23:
				hour = 0

			else:
				hour += 1
				
			minu = 0
		else:
			minu += 1
		
		if hour < 10:
			if minu > 9 :
				time = '0' + str(hour) + ':' + str(minu)
			else:
				time = '0' + str(hour) + ':' + '0' + str(minu)
		else:
			time = str(hour) + ':' + str(minu)
			if minu > 9 :
				time = str(hour) + ':' + str(minu)
			else:
				time = str(hour) + ':' + '0' + str(minu)
			
		if hour >= 19 or hour <= 4:
			isNight = true

		else:
			isNight = false

		$Timer.wait_time = 1
		$Timer.start()

func _on_timer_timeout() -> void:
	timer()

func _process(_delta: float) -> void:
	if Dialogic.VAR.end and !isEnd:
		isEnd = true
		get_tree().change_scene_to_file("res://scenes/cenas/fim.tscn")

	if Dialogic.VAR.Ritmo.playing and !isPlaying:
		isPlaying = true
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")
