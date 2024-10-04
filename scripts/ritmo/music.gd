extends Node3D

@onready var player = $AudioStreamPlayer
@onready var anim = $AnimationPlayer

var speed
var started
var pre_start_duration
var start_pos_in_sec

func setup(game) -> void:
	player.stream = game.audio

	speed = game.speed
	started = false
	pre_start_duration = game.bar_length_in_m
	start_pos_in_sec = game.start_pos_in_sec

func start() -> void:
	started = true
	player.play(start_pos_in_sec)
	anim.play("sound_on")

func _process(delta: float) -> void:
	if !started: 
		pre_start_duration -= speed*delta
		if  pre_start_duration <= 0:
			start()
			return
	else:
		if !player.playing:
			if Dialogic.VAR.quest == 1:
				Dialogic.VAR.Cecilia = true
				
			GlobalTime.musicEnded = true

		else:
			GlobalTime.musicEnded = false
