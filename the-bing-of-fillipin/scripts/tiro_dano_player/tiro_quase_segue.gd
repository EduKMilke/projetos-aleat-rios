extends Area2D

@export var speed: float = 200.0 
var player_target: Node2D = null
const PLAYER_GROUP = "player"

var movement_vector = Vector2.ZERO
var target_acquired = false
var a=true
func _physics_process(delta):
	if not is_instance_valid(player_target):
		var players = get_tree().get_nodes_in_group(PLAYER_GROUP)
		if not players.is_empty():
			player_target = players[0]
		else:
			return 

	if is_instance_valid(player_target) and not target_acquired:
		autodestruicao()
		var direction = (player_target.global_position - global_position).normalized()
		movement_vector = direction * speed
		target_acquired = true
		
	if target_acquired:
		if a==true:
			look_at(player_target.global_position)
			a=false
		global_position += movement_vector * delta
		if global_position.distance_to(player_target.global_position) < 10:
			Global.menos_vida()
			queue_free()
func autodestruicao():
	await  get_tree().create_timer(10).timeout
	queue_free()
