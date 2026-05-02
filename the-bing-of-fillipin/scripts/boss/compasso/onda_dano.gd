extends Area2D
var dano=false
var player=null
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	scale+=Vector2(0.5,0.5)
	if scale.x>1000:
		queue_free()
	if dano==true:
		if player !=null && player.Vector2()!=Vector2.ZERO:
			Global.menos_vida()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dano=true
		player=body

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dano=true
