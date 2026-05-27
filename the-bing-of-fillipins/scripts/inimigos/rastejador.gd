extends CharacterBody2D

var player = null
var spd = 5000 
var vida = 7
var knockback = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void: 
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	
	if global_position.distance_to(player.global_position) < 800:
		var direction = (player.global_position - global_position).normalized()
		
		
		velocity = direction * spd * delta + knockback
		
		
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
	if vida <= 0:
		queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
	if Global.mola == true:
		var direcao_empurrao = (global_position - body.global_position).normalized()
		knockback = direcao_empurrao * 500
		Global.menos_vida()
