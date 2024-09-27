extends Node2D


func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	if $CanvasGroup/Iniciar.button_pressed:
		get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
