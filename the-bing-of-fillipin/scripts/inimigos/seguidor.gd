extends Area2D
var player=null
var spd=200
var vida=5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if global_position.distance_to(player.global_position) < 800:
		var direction_vector = (player.global_position - global_position).normalized()
		var movement_vector = direction_vector * spd * delta
		global_position += movement_vector
	if vida <= 0:
		queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
