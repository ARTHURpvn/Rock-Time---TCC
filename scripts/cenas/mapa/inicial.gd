extends CanvasLayer


func _ready() -> void:
	pass 
	
func _process(_delta: float) -> void:
	if $VBoxContainer/Iniciar.button_pressed:
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/tutorial.tscn")

	if $VBoxContainer/Sair.button_pressed:
		get_tree().quit()
