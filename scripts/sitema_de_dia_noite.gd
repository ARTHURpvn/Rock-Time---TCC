extends CanvasModulate

var isDay = false
var isNight = false
var isDaytoNight = false
var isNighttoDay = false
var hour 

@export var sala: String
@export_category("Horas")
@export var anoitecendo = 19
@export var amanhecendo = 5

func _ready() -> void:
	# Certifique-se de que GlobalTime está acessível
	hour = GlobalTime.hour

	if hour:
		if hour < anoitecendo or hour > amanhecendo:
			isDay = true
			isNight = false

		if hour > anoitecendo or hour < amanhecendo:
			isDay = false
			isNight = true

func _process(_delta: float) -> void:
	hour = GlobalTime.hour

	if hour == amanhecendo and !isNighttoDay:
		print("amanhecendo")
		$AnimationPlayer.play("amanhecendo")
		isNighttoDay = true
		GlobalTime.isNight = false

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
		GlobalTime.isNight = false
		isDaytoNight = false

	if(anim_name == "anoitecendo"):
		isDay = false
		GlobalTime.isNight = true
		isNighttoDay = false
