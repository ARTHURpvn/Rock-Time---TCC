extends CanvasLayer

@export var text : StringName = "Teste"
@export var tecla : StringName = "F"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/HBoxContainer/ColorRect/Label.text = tecla
	$VBoxContainer/HBoxContainer/Label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
