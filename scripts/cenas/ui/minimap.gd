extends MarginContainer
class_name Minimap

@export var player: Player
@export var zoom = 1.5

@onready var grid = $MarginContainer/Grid
@onready var player_marker = $MarginContainer/Grid/PlayerMarker

var grid_scale
var markers = {}


func _process(_delta: float) -> void:
	if !player:
		return
		
	# var img = $"../../Player/SubViewport".get_texture().get_image()
	# var tex = ImageTexture.create_from_image(img)
	# $MarginContainer/Grid.texture = tex
	
	player_marker.rotation = player.velocity.angle() + PI / 2
	for item in markers:
		var obj_position = (item.global_position - player.position) * grid_scale + grid.size / 2
		if grid.get_rect().has_point(obj_position + grid.position):
			markers[item].scale = Vector2(1, 1)
		else:
			markers[item].scale = Vector2(0.75, 0.75)
			
		obj_position = obj_position.clamp(Vector2.ZERO, grid.size)
		markers[item].position = obj_position

func check_icons() -> void:
	await get_tree().process_frame
	player_marker.position = grid.size / 2
	grid_scale = grid.size / (get_viewport_rect().size * zoom) 
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = item.duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker

func _on_timer_timeout() -> void:
	check_icons()
