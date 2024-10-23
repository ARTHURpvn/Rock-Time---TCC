extends CanvasLayer

@export var texto : String

func _ready() -> void:
	$HBoxContainer/acao.text = texto
