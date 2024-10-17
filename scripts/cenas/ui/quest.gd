extends Node
var curr_quest : int = 0
var select_quest : Dictionary

@onready var quests : Array = GlobalTime.quests

func _process(_delta: float) -> void:
	quests = GlobalTime.quests
	curr_quest = Dialogic.VAR.quest
	select_quest = quests[curr_quest - 1]
	
	if curr_quest != 0:
		if !select_quest.finished:
			$CanvasLayer.visible = true
			$CanvasLayer/ColorRect.visible = true
			$CanvasLayer/ColorRect/VBoxContainer/Name.text = select_quest.name
			$CanvasLayer/ColorRect/VBoxContainer/HBoxContainer/ToDo.text = select_quest.todo
		else:
			$CanvasLayer.visible = false
	else:
		$CanvasLayer/ColorRect.visible = false
