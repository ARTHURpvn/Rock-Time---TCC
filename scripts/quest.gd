extends Node
var curr_quest : int = 0
var todoSize : int = 0
var todo : bool = false
var select_quest : Dictionary

@onready var quests = [
		{ "name": "Caixa de Som", "finished": false, "todo": 
			[
				{
					"objective" : "Encontre a caixa de som na garagem",
					"finished" : false,
				},
				{
					"objective" : "Volte para a garagem",
					"finished" : false,
				},
				{
					"objective" : "Fale com o Harry",
					"finished" : false,
				}
			]
		}, 
		{"name": "Buscar irmã do Harry ", "finished": false, "todo": "Busque a irmã do Harry na escola ao norte"},
	]

func _process(_delta: float) -> void:
	curr_quest = Dialogic.VAR.quest
	todo = GlobalTime.questEnded
	select_quest = quests[curr_quest - 1]
	
	if curr_quest != 0:
		if !select_quest.finished:
			$".".visible = true
			$Name.text = select_quest.name
			$ToDo.text = select_quest.todo
			while select_quest.todo.size() < todoSize:
				if !select_quest.todo[todoSize].finished and todo:
					select_quest.todo[todoSize].finished = true
					GlobalTime.questEnded = false
					todoSize += 1

			if todoSize == select_quest.todo.size():
				select_quest.finished = true
		else:
			$".".visible = false