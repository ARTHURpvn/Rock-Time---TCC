extends Node

var hour: int = 18
var min: int = 50
var isNight: bool = false
var time: String = str(hour)+":"+str(min)
var points : int


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
		
	$Timer.wait_time = 1
	$Timer.start()

func _on_timer_timeout() -> void:
	timer()

func _process(_delta: float) -> void:
	GlobalTime.hour = hour
	GlobalTime.min = min
	GlobalTime.time = time
