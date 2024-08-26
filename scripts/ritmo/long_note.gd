extends "res://scripts/ritmo/base_note.gd"

var curr_length_in_m

var hold_started = false
var hold_canceled = false

var capture = false

func _on_ready() -> void:
	super._on_ready()
	curr_length_in_m = max(100, length - 100)*length_scale
	$Beam.scale = Vector3(1, 1, curr_length_in_m)
	$Beam.set_material(line)


func _on_process(delta: float) -> void:
	super._on_process(delta)

	if !collected:
		if is_colliding and picker and !hold_canceled:
			if picker.is_collecting:
				hold_started = true
			elif hold_started:
				hold_canceled = true

		if hold_started and !hold_canceled:
			if !capture:
				var diff = picker.global_transform.origin.z - global_transform.origin.z
				if abs(diff) <= 0.1:
					capture = true
					translate(Vector3(0,0,diff))
			else:
				curr_length_in_m -= speed.z * delta
				if curr_length_in_m <= 0:
					collect()

				else:
					$Beam.scale = Vector3(1, 1, curr_length_in_m)
					translate(-speed * delta)
