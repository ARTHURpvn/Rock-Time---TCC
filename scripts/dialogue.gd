extends Control

signal dialogue_finished

var dialogue = []
var current_dialogue_id = 1
var d_active = false
const JSON_PATH = "res://data/snd_helena.json"
func _ready():
	#$NinePatchRect.visible = false
	pass
	
func start(): 
	if d_active:
		return
		
	d_active = true
	#$NinePatchRect.visible = true
	#dialogue = load_dialogue()
	current_dialogue_id = -1
	
	next_script()
			
func load_json():
	var file = FileAccess.open(JSON_PATH, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	file.close()
	
	return content
	
func _input(event):
	if !d_active:
		return
	
	if event.is_action_pressed('ui_accept'):
		next_script()
	
func next_script():
	current_dialogue_id += 1
	#if current_dialogue_id >= len(dialogue):
		#d_active = false
	# print(dialogue)
		#$NinePatchRect.visible = false
		#emit_signal("dialogue_finished")
		#return
	
	
	#$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	#$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']
