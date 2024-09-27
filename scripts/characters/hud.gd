extends CanvasLayer
func _process(_delta: float) -> void:
	$Time.text = GlobalTime.time
