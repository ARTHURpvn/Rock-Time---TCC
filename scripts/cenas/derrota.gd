extends CanvasLayer
func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if $VBoxContainer/try.button_pressed:
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/garagem_default.tscn")
	
	if $VBoxContainer/exit.button_pressed:
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/inicial.tscn")
