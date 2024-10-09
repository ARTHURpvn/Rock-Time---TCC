extends Node2D
var follow_npc = preload("res://scenes/player/perso_banda.tscn")
var created : bool = false
var instanciate
var shader_material : ShaderMaterial
var teste : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/cenas/mapa/jogo.tscn")


func _process(_delta: float) -> void:
	if Dialogic.VAR.follow:
		if !created:
			created = true
			instanciate = follow_npc.instantiate()
			instanciate.npc_name = "Cecilia"
			instanciate.position = Vector2(231, 184)
			add_child(instanciate)

	if Dialogic.VAR.quest == 5 and Dialogic.VAR.Logo and !teste:
		teste = true
		$AnimationTree/AnimationPlayer.active = true
		$AnimationTree/AnimationPlayer.current_animation = "amplificador"

	if teste and !$AnimationTree/AnimationPlayer.active:
		pass


	if Dialogic.VAR.Cecilia:
		get_tree().change_scene_to_file("res://scenes/cenas/outro_dia.tscn")
