extends Area2D
var dano=false
var player=null
var seguro = false


func _ready() -> void:
	pass
func _process(delta: float) -> void:
	scale+=Vector2(0.5,0.5)
	if scale.x>150:
		queue_free()
	if dano==true and seguro == false:
		if player !=null && player.velocity != Vector2.ZERO:
			Global.menos_vida()

#Areá externa Eduardo burro, se reclamar do meu código que se dane
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dano=true
		player=body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		dano = false


#Area interna
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		seguro = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	seguro = false
	
