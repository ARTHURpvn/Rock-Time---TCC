extends CanvasLayer

func _on_timer_timeout() -> void:
	GlobalTime.hour = 6
	GlobalTime.min = 0
	get_tree().change_scene_to_file("res://scenes/primeira-fase/garagem.tscn")
