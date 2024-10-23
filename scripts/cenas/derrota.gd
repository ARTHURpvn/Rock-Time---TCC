extends CanvasLayer
func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if $VBoxContainer/try.button_pressed:
		GlobalTime.points = 0
		GlobalTime.life = 100
		get_tree().change_scene_to_file("res://scenes/ritmo/game.tscn")
	
	if $VBoxContainer/exit.button_pressed:
		get_tree().quit
		#get_tree().change_scene_to_file("res://scenes/cenas/mapa/inicial.tscn")
