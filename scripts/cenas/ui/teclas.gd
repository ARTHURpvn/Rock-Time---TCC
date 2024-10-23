extends CanvasLayer


func _ready() -> void:
	visible = false 

func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("ui_cancel"):
			visible = false
			get_tree().paused = false
