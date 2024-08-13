extends CanvasLayer

var dialogue = []
var current_dialogue_id = 0
var d_active = false
const JSON_PATH = "res://scenes/dialogue/worker_dialogue1.json"

var selected_index = 0
var buttons = []
var choice_ids = {}  # Dicionário para armazenar IDs

func load_dialogue():
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	file.close()
	return content

func _ready():
	$ColorRect.visible = false
	$ChoicesContainer.visible = false 

func start(): 
	if d_active:
		return
	
	d_active = true
	$ColorRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func next_script(choice_id = -1):
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$ColorRect.visible = false
		$ChoicesContainer.visible = false
		return
	
	var current_dialogue = dialogue[current_dialogue_id]
	
	if "escolhas" in current_dialogue:
		show_choices(current_dialogue["escolhas"])
	else:
		hide_choices()
		$ColorRect/Name.text = current_dialogue["name"]
		$ColorRect/Text.text = current_dialogue["text"]

	# Se uma escolha foi feita, mova para o próximo diálogo baseado na escolha
	if choice_id != -1:
		for choice in current_dialogue["escolhas"]:
			if choice["id"] == choice_id:
				current_dialogue_id = choice["id_proximo_dialogo"] 
				break

func show_choices(choices):
	$ChoicesContainer.visible = true
	
	# Remove todos os filhos do ChoicesContainer
	var children = $ChoicesContainer.get_children()
	for child in children:
		child.queue_free()
	
	buttons.clear()
	choice_ids.clear()  # Limpa o dicionário de IDs
	selected_index = 0 
	
	# Adiciona botões de escolha
	for choice in choices:
		var button = Button.new()
		button.text = choice["texto"]
		# Use `button.connect` para conectar o sinal de pressionamento
		button.pressed.connect( self._on_choice_pressed, choice["next_dialogue"])
		$ChoicesContainer.add_child(button)
		buttons.append(button)
		choice_ids[button.text] = choice["next_dialogue"] 

	# Destaca o botão selecionado
	if buttons.size() > 0:
		_navigate(0)  

func hide_choices():
	$ChoicesContainer.visible = false

func _on_choice_pressed(choice_id):
	# choice_id é passado como parâmetro para o método conectado
	print("Choice ID pressed:", choice_id)
	next_script(choice_id)

func _input(event):
	if !d_active:
		return

	if event.is_action_pressed('ui_accept') and $ChoicesContainer.visible:
		if buttons.size() > 0:
			_on_choice_pressed(choice_ids.get(buttons[selected_index].text, -1))
	elif event.is_action_pressed('ui_up'):
		_navigate(-1)
	elif event.is_action_pressed('ui_down'):
		_navigate(1)

func _navigate(direction):
	if buttons.size() == 0:
		return
	
	# Remove a seleção atual
	buttons[selected_index].focus_mode = Control.FOCUS_NONE
	
	# Calcula o novo índice selecionado
	selected_index = (selected_index + direction + buttons.size()) % buttons.size()
	
	# Atualiza o botão selecionado
	buttons[selected_index].focus_mode = Control.FOCUS_ALL
	buttons[selected_index].grab_focus()
