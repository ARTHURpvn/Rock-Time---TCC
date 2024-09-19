extends Node3D

func define_text(text):
	$Label3D.text = text
	
	if text == "X":
		$Label3D.modulate = "ff0000"
