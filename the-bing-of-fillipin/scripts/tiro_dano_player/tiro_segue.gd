extends Area2D

@export var speed: float = 200.0 
var player_target: Node2D = null
const PLAYER_GROUP = "player"

func _ready():
	pass 
func _physics_process(delta):
	if not is_instance_valid(player_target):
		var players = get_tree().get_nodes_in_group(PLAYER_GROUP)
		
		if not players.is_empty():
			player_target = players[0]
		else:
			return
	if is_instance_valid(player_target):
		look_at(player_target.global_position)
		if global_position.distance_to(player_target.global_position) < 10:
			Global.menos_vida()
			queue_free()
		var direction_vector = (player_target.global_position - global_position).normalized()
		var movement_vector = direction_vector * speed * delta
		global_position += movement_vector
		autodestruicao()
func autodestruicao():
	await  get_tree().create_timer(10).timeout
	queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
