extends CharacterBody2D

var t_tiro = 1
var tiro = preload("res://obj/player/tiro.tscn")
var p_t = false
var t_c = 0
var morte=false
@onready var spr=$AnimatedSprite2D
@onready var anim=$AnimationPlayer
func _physics_process(delta: float) -> void:
	if morte==false:
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
		# Pega todos os nós do grupo
		if Global.osmose==true:
			var obstaculos = get_tree().get_nodes_in_group("obstaculo")
			
			for obstaculo in obstaculos:
				# Verifica se o nó é um objeto de colisão (StaticBody, CharacterBody, etc)
				if obstaculo is CollisionObject2D or obstaculo is CollisionObject3D:
					# Adiciona uma exceção: este nó (self) ignora o obstáculo
					self.add_collision_exception_with(obstaculo)
		_tiro()
		move_and_slide()

func _processar_animacoes_movimento():
	if Input.is_action_pressed("t_d"): spr.play("direita")
	elif Input.is_action_pressed("t_a"): spr.play("esquerda")
	elif Input.is_action_pressed("t_w"): spr.play("cima")
	elif Input.is_action_pressed("t_s"): spr.play("baixo")
	else: spr.play("default")

func tocar_animacao_dano():
	set_collision_mask_value(1, false)
	spr.play("dano")
	await get_tree().create_timer(Global.t_dano).timeout
	set_collision_mask_value(1, true)
	Global.dano = true
	spr.play("default")

func _tiro() -> void:
	if not p_t: return
		
	var direc_t := int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	var direc_t2 := int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))   
	
	if direc_t != 0 or direc_t2 != 0:
		if direc_t != 0 and direc_t2 != 0: return

		
		if Global.mitose == true:
			
			instanciar_tiro(direc_t, direc_t2, 15) # Desvio de +15 pixels
			instanciar_tiro(direc_t, direc_t2, -15) # Desvio de -15 pixels
		else:
			
			instanciar_tiro(direc_t, direc_t2, 0)

		
		if Global.lapis_duplo:
			
			instanciar_tiro(-direc_t, -direc_t2, 0)
		
		p_t = false
		t_c = Global.tiroc


func instanciar_tiro(dx, dy, offset):

		var i_tiro = tiro.instantiate()
		i_tiro.d_x = dx
		i_tiro.d_y = dy 
		
		
		i_tiro.global_position = global_position
		
		
		if dx != 0: 
			i_tiro.global_position.y += offset
		else: 
			i_tiro.global_position.x += offset
			
		get_tree().current_scene.add_child(i_tiro)
