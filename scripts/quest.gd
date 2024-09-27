extends Node
var curr_quest = 1
@onready var quests = [
		{"name": "teste", "finished": false, "todo": "go to north path"}, 
		{"name": "teste2", "finished": false, "todo": "go to north path"}
	]
@onready var select_quest = quests[curr_quest - 1]

func _process(_delta: float) -> void:
	if !select_quest.finished:
		$CanvasModulate.visible = true
		$CanvasModulate/Label/Name.text = select_quest.name
		$CanvasModulate/ToDo.text = select_quest.todo
	else:
		print("task finished")
