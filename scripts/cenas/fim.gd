extends Node2D


func _ready() -> void:
	$AnimationPlayer.current_animation = "fim"

func _process(_delta: float) -> void:
	if $CanvasLayer/Button.button_pressed:
		get_tree().quit()
