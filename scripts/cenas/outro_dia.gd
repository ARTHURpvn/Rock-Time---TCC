extends CanvasLayer

func _on_timer_timeout() -> void:
	GlobalTime.hour = 20
	GlobalTime.minu = 0
	get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem.tscn")