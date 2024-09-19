extends Node2D

var time_day_hour = 18
var time_day_min = 50
var time_day = "00:00"

func timer():
		if time_day_min == 59:
			if time_day_hour == 23:
				time_day_hour = 0
			else:
				time_day_hour += 1
			time_day_min = 0
		else:
			time_day_min += 1
		
		if time_day_hour < 10:
			if time_day_min > 9 :
				time_day = '0' + str(time_day_hour) + ':' + str(time_day_min)
			else:
				time_day = '0' + str(time_day_hour) + ':' + '0' + str(time_day_min)
		else:
			time_day = str(time_day_hour) + ':' + str(time_day_min)
			if time_day_min > 9 :
				time_day = str(time_day_hour) + ':' + str(time_day_min)
			else:
				time_day = str(time_day_hour) + ':' + '0' + str(time_day_min)
			

		$Timer.wait_time = 1
		$Timer.start()


func return_time():
	return time_day

func return_hour():
	return time_day_hour

func _on_timer_timeout() -> void:
	timer()
