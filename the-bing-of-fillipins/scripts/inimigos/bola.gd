extends CharacterBody2D
var direction = Vector2(1, 1).normalized()
var player=null
var speed = 200
var vida=5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if player != null and global_position.distance_to(player.global_position) < 800:
			var collision = move_and_collide(direction * speed * delta)
			if collision:
				direction = direction.bounce(collision.get_normal())

	if vida <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
