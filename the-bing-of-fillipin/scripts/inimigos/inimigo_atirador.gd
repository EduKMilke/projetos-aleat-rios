extends CharacterBody2D

@export var bala_scene: PackedScene = preload("res://obj/tiros_dano_player/tiro_quase_segue.tscn")
@onready var marker = $Marker2D
@onready var ray = $RayCast2D

var player = null

func _ready():
	
	player = get_tree().get_first_node_in_group("player")

func _on_timer_timeout():
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	
	
	if player and pode_ver_player():
		if global_position.distance_to(player.global_position) < 800:
			atirar()
func pode_ver_player() -> bool:
	
	ray.target_position = to_local(player.global_position)
	ray.force_raycast_update()
	
	
	return not ray.is_colliding() or ray.get_collider().is_in_group("player")

func atirar():
	var nova_bala = bala_scene.instantiate()
	nova_bala.global_position = marker.global_position
	
	get_tree().current_scene.add_child(nova_bala)
