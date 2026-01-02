extends CharacterBody2D

var t_tiro = 1
var tiro = preload("res://obj/player/tiro.tscn")
var p_t = false
var t_c = 0
@onready var spr=$AnimatedSprite2D

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:

	var direction2 := Input.get_axis("t_w", "t_s") 
	var direction := Input.get_axis("t_a", "t_d") 
	var mov := Vector2(direction, direction2)
	var _mov2 = mov.normalized()*delta

	if direction != 0.0 or direction2 != 0.0:
		velocity.x = _mov2.x * Global.plaspd
		velocity.y = _mov2.y * Global.plaspd
	else:
		velocity.x = move_toward(velocity.x, 0, Global.plaspd)
		velocity.y = move_toward(velocity.y, 0, Global.plaspd)

	if not p_t:
		t_c -= delta
		if t_c <= 0.0:
			p_t = true
			t_c = 0.0
	
	_tiro()
	move_and_slide()

func _tiro() -> void:
	if p_t == false:
		return
		
	var direc_t := int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	var direc_t2 := int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))   
	
	if direc_t != 0 or direc_t2 != 0:
		if direc_t != 0 and direc_t2 != 0:
			pass
		else:
			var i_tiro = tiro.instantiate()
			i_tiro.d_x = direc_t
			i_tiro.d_y = direc_t2 

			if direc_t != 0:
				var _loc_t = randi_range(int(global_position.y) + 10, int(global_position.y) - 10)
				i_tiro.global_position.y = _loc_t
				i_tiro.global_position.x = global_position.x
			elif direc_t2 != 0:
				var _loc_t = randi_range(int(global_position.x) + 10, int(global_position.x) - 10)
				i_tiro.global_position.y = global_position.y
				i_tiro.global_position.x = _loc_t
			
			p_t = false
			t_c = Global.tiroc
			get_tree().current_scene.add_child(i_tiro)
	if Global.dano==false:
		spr.play("dano")
		await get_tree().create_timer(Global.t_dano).timeout
		spr.play("default")
		Global.dano=true
