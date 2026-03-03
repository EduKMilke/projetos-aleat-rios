extends CharacterBody2D


const spd = 300.0

var alvo_atual = null
var direcao 

func _physics_process(_delta):
	if is_instance_valid(alvo_atual):
		direcao= global_position.direction_to(alvo_atual.global_position)
		velocity = direcao * spd
		look_at(alvo_atual.global_position)
	if not is_instance_valid(alvo_atual):
		if Global.ener>0:
			if Input.is_action_just_pressed("ui_up"):
				Global.ener-=1
				direcao.y*=-1
				rotation*=-1
		velocity = direcao * spd
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos"):
		body.queue_free()
		queue_free()
