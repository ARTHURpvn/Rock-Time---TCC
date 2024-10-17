extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var menu = preload("res://scenes/cenas/ui/menu.tscn")
var created : bool = false
var instanciate
var shader_material : ShaderMaterial
var teste : bool = false
var isPlayer : bool
var isMenu : bool
var instMenu

func _process(_delta: float) -> void:
	if Dialogic.VAR.follow:
		if !created:
			created = true
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = "Cecilia"
			instanciate.position = Vector2(231, 184)
			add_child(instanciate)

	if Dialogic.VAR.Cecilia:
		get_tree().change_scene_to_file("res://scenes/cenas/outro_dia.tscn")

	if isPlayer and Input.is_action_just_pressed("dialog"):
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = true

		if !isMenu:
			isMenu = true
			instMenu = menu.instantiate()
			instMenu.tecla = "F"
			instMenu.texto = "Sair"
			add_child(instMenu)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayer = true

		if isMenu:
			isMenu = false
			remove_child(instMenu)
