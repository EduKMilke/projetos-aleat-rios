extends CharacterBody2D

var tiro = preload("res://obj/tiros_dano_player/tiro_quase_segue_eletrico.tscn")
var speed = 200
var direction = Vector2(1, 1).normalized()
var vida = 70
var vida_a = vida
var player = null
var move = true
var a = true
var b = true
var barra_vida = preload("res://obj/boss/barra_vida_boss.tscn")
var _ibar_vida
var _progress_bar

func _ready() -> void:
	_ibar_vida = barra_vida.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida

func _physics_process(delta):
	if a == true:
		a = false
		dano_troca()
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if player != null and global_position.distance_to(player.global_position) < 800:
		if b == true:
			get_tree().current_scene.add_child(_ibar_vida)
			b = false
		
		if vida != vida_a:
			_progress_bar.value = vida
			speed += (vida_a - vida) * 10
			vida_a = vida
			
		if move == true:
			var collision = move_and_collide(direction * speed * delta)
			if collision:
				direction = direction.bounce(collision.get_normal())

	if vida <= 0:
		if is_instance_valid(_ibar_vida):
			_ibar_vida.queue_free()
		queue_free()

func dano_troca():
	await get_tree().create_timer(10).timeout
	if not is_inside_tree():
		return
	move = false
	for i in 5:
		var _i_tiro = tiro.instantiate()
		_i_tiro.speed += 10
		add_child(_i_tiro) 
		await get_tree().create_timer(1).timeout
	if not is_inside_tree():
		return
	move = true
	a = true
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _on_contato_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.vida_v -= 1
