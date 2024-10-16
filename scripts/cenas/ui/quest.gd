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
			$".".visible = true
			$ColorRect.visible = true
			$Name.text = select_quest.name
			$ToDo.text = select_quest.todo
		else:
			$".".visible = false
	else:
		$ColorRect.visible = false
