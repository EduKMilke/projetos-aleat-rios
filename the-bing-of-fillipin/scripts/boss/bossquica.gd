extends CharacterBody2D

var speed = 200
var direction = Vector2(1, 1).normalized()
var vida=40
var vida_a=vida
var player=null
func _physics_process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if global_position.distance_to(player.global_position) < 800:
		if vida!=vida_a:
			speed+=(vida_a-vida)*10
			vida=vida_a
		velocity = direction * speed
		
		# Move o personagem e verifica colisões
		var collision = move_and_collide(velocity * delta)
		
		# Se colidir, calcula o "quique"
		if collision:
			# bounce() inverte a direção com base na normal da superfície
			direction = direction.bounce(collision.get_normal())
			vida-=1
	if vida<=0:
		queue_free()
