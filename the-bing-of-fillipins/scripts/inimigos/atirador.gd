extends Area2D



var velocidade = 400
var direcao = Vector2.ZERO

func _process(delta):
	position += direcao * velocidade * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.menos_vida() 
		queue_free()
	if body is TileMap:
		queue_free()
