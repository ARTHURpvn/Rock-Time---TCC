extends Node
var curr_quest : int = 0
var todo : bool = false
var isEnd : bool = false
var select_quest : Dictionary

@onready var quests = [
		{"name": "Caixa de Som", "finished": false, "todo": "Pegue as caixas de som"}, 
		{"name": "Garagem", "finished": false, "todo": "Volte para a garagem e fale com o Harry"},
		{"name": "Buscar irmã do Harry ", "finished": false, "todo": "Busque a irmã do Harry na escola ao norte"}
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
		else:
			$".".visible = false

	if todo:
		select_quest.finished = true
		GlobalTime.questEnded = false
		todo = false
		if curr_quest == 1:
			Dialogic.VAR.quest = 2
