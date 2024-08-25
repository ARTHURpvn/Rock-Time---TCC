extends CanvasModulate

var isDay = false
var isNight = false
var isDaytoNight = false
var isNighttoDay = false

var timer 
var hour

@export_category("Dia e Noite")
@export var anoitecendo = 19
@export var amanhecendo = 5

func _ready() -> void:
	timer = get_node("/root/Jogo")
	hour = timer.return_hour()

	if hour:
		if hour < anoitecendo or hour > amanhecendo:
			isDay = true
			isNight = false

		if hour > anoitecendo or hour < amanhecendo:
			isDay = false
			isNight = true

func _process(_delta: float) -> void:
	hour = timer.return_hour()

	if hour == amanhecendo and !isNighttoDay:
		print("amanhecendo")
		$AnimationPlayer.play("amanhecendo")
		isNighttoDay = true
		isNight = false

	if hour == anoitecendo and !isDaytoNight:
		print("anoitecendo")
		$AnimationPlayer.play("anoitecendo")
		isDaytoNight = true
		isDay = false

	if isDay:
		$AnimationPlayer.play("dia")

	if isNight:
		$AnimationPlayer.play("noite")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "amanhecendo"):
		isDay = true
		isNight = false
		isDaytoNight = false

	if(anim_name == "anoitecendo"):
		isDay = false
		isNight = true
		isNighttoDay = false

func return_night():
	return isNight
