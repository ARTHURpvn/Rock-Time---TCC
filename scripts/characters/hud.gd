extends CanvasLayer

func time() -> void:
	var timer = get_node("/root/Jogo")
	print(timer.time_day)
	$Time.text = timer.time_day

func _process(_delta: float) -> void:
	time()