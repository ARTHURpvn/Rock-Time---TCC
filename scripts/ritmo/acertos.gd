extends Node3D
@onready var point = get_node("/root/Game/Points")


func _process(_delta: float) -> void:
	var acertos = point.tiles 

	if acertos < 10:
		$teclasAcertadas.text = "1x"
		point.combo = 1

	elif acertos >= 10 and acertos < 15:
		$teclasAcertadas.text = "1.5x"
		point.combo = 1.5

	elif acertos >= 15 and acertos < 20:
		$teclasAcertadas.text = "2x"
		point.combo = 2
	
	elif acertos >=20 and acertos < 30:
		$teclasAcertadas.text = "3x"
		point.combo = 3

	elif acertos >=30 and acertos < 45:
		$teclasAcertadas.text = "4x"
		point.combo = 4
	
	elif acertos >= 45:
		$teclasAcertadas.text = "5x"
		point.combo = 5
