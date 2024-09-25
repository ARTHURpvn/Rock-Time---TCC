extends CharacterBody2D

@export var _animation_tree: AnimationTree = null
var _state_machine

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
				
				
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	position += dir * speed * delta

		
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
