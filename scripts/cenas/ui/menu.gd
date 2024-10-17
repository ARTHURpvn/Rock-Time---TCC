extends CanvasLayer

@export var texto : String
@export var tecla : String

func _ready() -> void:
	$VBoxContainer/HBoxContainer/tecla.text = tecla
	$VBoxContainer/HBoxContainer/acao.text = texto
