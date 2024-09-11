extends "res://scripts/ritmo/base_note.gd"

func _on_process(delta: float) -> void:
	super._on_process(delta)

	if not collected:
		if is_colliding and picker:
			if picker.is_collecting:
				point.add_points(100)
				collect()
