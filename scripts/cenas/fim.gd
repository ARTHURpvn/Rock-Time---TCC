extends Node2D

func _process(_delta: float) -> void:
	if $Fim/Button.button_pressed:
		get_tree().quit()
