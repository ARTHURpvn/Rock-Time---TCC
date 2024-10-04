extends Node

var hour: int = 18
var min: int = 50
var isNight: bool = false
var time: String = str(hour)+":"+str(min)
var points : int
var musicEnded : bool = false
var player_position : Vector2 = Vector2(-1060, -146)

var quests = [
	{ "name": "Buscar Irmã do Harry", "finished": false, "todo": "Caminhe ate a Escola e Busque a Cecilia"},
	{ "name": "Buscar Irmã do Harry", "finished": false, "todo": "Volte para a Garagem e Encontre Harry"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Vá para o Estacionamento"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Converse Com o Cara Misterioso"},
	{ "name": "Pegar os Amplificadores", "finished": false, "todo": "Volte para Casa com os Amplificadores"},
]

var quest : int = 0

func timer():
	if min == 59:
		if hour == 23:
			hour = 0

		else:
			hour += 1
			
		min = 0
	else:
		min += 1
	
	if hour < 10:
		if min > 9 :
			time = '0' + str(hour) + ':' + str(min)
		else:
			time = '0' + str(hour) + ':' + '0' + str(min)
	else:
		time = str(hour) + ':' + str(min)
		if min > 9 :
			time = str(hour) + ':' + str(min)
		else:
			time = str(hour) + ':' + '0' + str(min)
		
	if hour >= 19 and hour <= 4:
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
	GlobalTime.min = min
	GlobalTime.time = time
