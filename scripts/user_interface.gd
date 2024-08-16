extends CanvasLayer

const JSON_PATH = "res://scenes/dialogue/dialogue.json"

var dialogue_data = []
var current_dialogue_id = 1 
var d_active = false
var selected_index = 0

func _ready():
	$ColorRect.visible = false
	$ChoicesContainer.visible = false 

func load_dialogue():
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	if file:
		var content = JSON.parse_string(file.get_as_text())
		file.close()
		return content

func start_dialogue(): 
	if d_active:
		return

	var data = load_dialogue()
	if not data or not data.has("npcs"):
		print("No NPCs found in dialogue JSON.")
		return
	
	dialogue_data = data["npcs"][0]["dialogue"]
	d_active = true
	$ColorRect.visible = true
	current_dialogue_id = 1
	advance_dialogue()

func advance_dialogue(choice_id = -1):
	if not d_active:
		return
	
	if choice_id != -1:
		current_dialogue_id = choice_id
	
	if current_dialogue_id == 0:
		end_dialogue()
		return
	
	var current_dialogue = get_dialogue_by_id(current_dialogue_id)
	if not current_dialogue:
		end_dialogue()
		return
	
	$ColorRect/Name.text = current_dialogue.get("name", "Unknown")
	$ColorRect/Text.text = current_dialogue.get("text", "")
	
	if current_dialogue.has("options"):
		display_choices(current_dialogue["options"])
	else:
		hide_choices()

func get_dialogue_by_id(dialogue_id):
	for dialogue_item in dialogue_data:
		if dialogue_item["id"] == dialogue_id:
			return dialogue_item
	return null

func display_choices(choices):
	$ChoicesContainer.visible = true
	# Remove all children from the container
	for child in $ChoicesContainer.get_children():
		child.queue_free()
	selected_index = 0

	for choice in choices:
		var button = Button.new()
		button.text = str(choice["text"])
		button.pressed.connect(func(): on_choice_selected(choice))
		$ChoicesContainer.add_child(button)
	
	# Focus the first button by default
	select_button(0)

func hide_choices():
	$ChoicesContainer.visible = false

func end_dialogue():
	d_active = false
	$ColorRect.visible = false
	$ChoicesContainer.visible = false
	# Notify the character script that dialogue has ended
	get_parent().call_deferred("_on_dialogue_ended")

func return_is_dialogue():
	return d_active

func _input(event):
	if not d_active:
		return

	if event.is_action_pressed('ui_accept') and $ChoicesContainer.visible:
		if selected_index >= 0 and selected_index < $ChoicesContainer.get_child_count():
			var button = $ChoicesContainer.get_child(selected_index)
			button.emit_signal("pressed")
	elif event.is_action_pressed('ui_up'):
		navigate(-1)
	elif event.is_action_pressed('ui_down'):
		navigate(1)

func navigate(direction):
	var button_count = $ChoicesContainer.get_child_count()
	if button_count == 0:
		return
		
	selected_index += direction
	
	if selected_index < 0:
		selected_index -= 1
	elif selected_index >= button_count:
		selected_index += 1

	select_button(selected_index)

func select_button(index):
	if index >= 0 and index < $ChoicesContainer.get_child_count():
		var button = $ChoicesContainer.get_child(index)
		button.grab_focus()

func on_choice_selected(choice):
	if choice.has("quest"):
		handle_quest(choice["quest"])
	if choice.has("next"):
		advance_dialogue(choice["next"])
	else:
		end_dialogue()

func handle_quest(quest):
	var quest_name = Label.new()
	var quest_dsc = Label.new()

	quest_name.uppercase = true
	quest_dsc.text = quest.description
	quest_name.text = quest.title

	$Quests.add_child(quest_name)
	$Quests.add_child(quest_dsc)
