extends CharacterBody2D

var player = null
var spd = 9000 
var vida = 7
var bala_scene: PackedScene = preload("res://obj/tiros_dano_player/tiro_quase_segue.tscn")
var pode_atirar=true
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void: 
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	
	if global_position.distance_to(player.global_position) < 300:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * -spd * delta
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	if global_position.distance_to(player.global_position) < 800:
		if pode_atirar:
			pode_atirar = false 
			atirar()
			await get_tree().create_timer(1.0).timeout
			pode_atirar = true
		
	if vida <= 0:
		queue_free()
func _on_area_dano_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
func atirar():
	var nova_bala = bala_scene.instantiate()
	var sprite = nova_bala.get_node("Sprite2D") 
	
	sprite.texture = load("res://assets/Inimigos/Água.png")
	nova_bala.global_position = global_position
	get_tree().current_scene.add_child(nova_bala)
