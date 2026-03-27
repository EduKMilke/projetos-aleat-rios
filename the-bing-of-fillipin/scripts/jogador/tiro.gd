extends Node2D

var d_x = 0    
var d_y = 0    
@onready var spr=$Area2D/Sprite2D
@onready var som =$Atirando

func _ready() -> void:
	if som:
		som.play()
func _physics_process(delta: float) -> void:
	var direction_vector = Vector2(d_x, d_y).normalized()
	position += direction_vector * Global.tirospd * delta
	await get_tree().create_timer(Global.tiroext).timeout
	queue_free()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigo"):
		area.vida-=Global.dano_ti
		$Recebendo.play()
		queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("inimigo"):
		body.vida-=Global.dano_ti
		$Recebendo.play()
		queue_free()
	if body.is_in_group("obs"):
		$Recebendo.play()
		queue_free()
