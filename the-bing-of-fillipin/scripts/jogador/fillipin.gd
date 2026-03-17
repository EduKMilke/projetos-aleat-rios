extends CharacterBody2D

var t_tiro = 1
var tiro = preload("res://obj/player/tiro.tscn")
var p_t = false
var t_c = 0
@onready var spr=$AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if Global.dano: 
		_processar_animacoes_movimento()
	else:
		if spr.animation != "dano":
			tocar_animacao_dano()

	var direction2 := Input.get_axis("t_w", "t_s") 
	var direction := Input.get_axis("t_a", "t_d") 
	var mov := Vector2(direction, direction2)
	
	if mov != Vector2.ZERO:
		velocity = mov.normalized() * Global.plaspd
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Global.plaspd)

	if not p_t:
		t_c -= delta
		if t_c <= 0.0:
			p_t = true

	_tiro()
	move_and_slide()

func _processar_animacoes_movimento():
	if Input.is_action_pressed("t_d"): spr.play("default")
	elif Input.is_action_pressed("t_a"): spr.play("esquerda")
	elif Input.is_action_pressed("t_w"): spr.play("cima")
	elif Input.is_action_pressed("t_s"): spr.play("baixo")

func tocar_animacao_dano():
	spr.play("dano")
	await get_tree().create_timer(Global.t_dano).timeout
	Global.dano = true
	spr.play("default")

func _tiro() -> void:
	if not p_t: return
		
	var direc_t := int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	var direc_t2 := int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))   
	
	if direc_t != 0 or direc_t2 != 0:
		if direc_t != 0 and direc_t2 != 0: return

		var i_tiro = tiro.instantiate()
		i_tiro.d_x = direc_t
		i_tiro.d_y = direc_t2 
		
		i_tiro.global_position = global_position
		if direc_t != 0:
			i_tiro.global_position.y += randi_range(-10, 10)
		else:
			i_tiro.global_position.x += randi_range(-10, 10)
		
		get_tree().current_scene.add_child(i_tiro)
		p_t = false
		t_c = Global.tiroc
