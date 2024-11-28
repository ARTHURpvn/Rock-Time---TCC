extends CanvasLayer
var scene : bool = false

func _ready() -> void:
	visible = false 

func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if scene:
			visible = false
			get_tree().paused = false


func _on_timer_timeout() -> void:
	scene = true
