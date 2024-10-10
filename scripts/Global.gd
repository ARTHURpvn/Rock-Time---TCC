extends Node

var hour: int = 12
var minu: int = 0
var isNight: bool = false
var time: String = str(hour)+":"+str(minu)
var points : int
var musicEnded : bool = false
var player_position : Vector2 = Vector2(-1060, 114)
var year : int = 2010

var quests = [
	{ "name": "Buscar Irmã do Harry", "finished": false, "todo": "Caminhe até a Escola e Busque a Cecilia"},
	{ "name": "Buscar Irmã do Harry", "finished": false, "todo": "Volte para a Garagem e Encontre Harry"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Vá para o Estacionamento"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Converse Com o Cara Misterioso"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Volte para Casa com os Amplificadores"},
]

var quest : int = 0

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
	quest = Dialogic.VAR.quest
	GlobalTime.hour = hour
	GlobalTime.minu = minu
	GlobalTime.time = time
