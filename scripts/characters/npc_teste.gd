extends CharacterBody2D

@export var _animation_tree: AnimationTree = null
@export var npc_name : String
var _state_machine
var inArea : bool = false
var menu = preload("res://scenes/cenas/ui/menu.tscn")
var isPlayer : bool
var isMenu : bool
var instMenu
var isChatting : bool = false

const speed = 30
var current_state = IDLE

var isNight
var time

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true

enum {
	IDLE, 
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	time = GlobalTime.time
	start_pos = position
	_state_machine = _animation_tree["parameters/playback"]

func _process(delta):
	isNight = GlobalTime.isNight
	$PointLight2D.visible = isNight
	if current_state == 0 or current_state == 1:
		_state_machine.travel("Idle")
		
	elif current_state == 2:
		if dir != Vector2.ZERO:
			_animation_tree["parameters/Idle/blend_position"] = dir
			_animation_tree["parameters/Walk/blend_position"] = dir
		_state_machine.travel("Walk")
			
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
				
	if inArea and Input.is_action_just_pressed("dialog"):
		if !Dialogic.VAR.isTalking and Dialogic.VAR.quest == 5 and npc_name == "Finn":
			isChatting = true
			Dialogic.start_timeline("res://dialogo/timeline/novoMundo1.dtl")

	if Dialogic.VAR.isTalking and isChatting:
		current_state = IDLE

func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	position += dir * speed * delta
		
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		inArea = true

		if !isMenu:
			isMenu = true
			instMenu = menu.instantiate()
			
			instMenu.texto = "Conversar"
			add_child(instMenu)

func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		inArea = true
		isChatting = false

		if isMenu:
			isMenu = false
			remove_child(instMenu)
