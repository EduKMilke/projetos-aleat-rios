extends Node2D

var d_x = 0    
var d_y = 0    
@onready var spr = $Area2D/Sprite2D
@onready var som = $Atirando

func _ready() -> void:
	if som:
		som.play()
	
	
	get_tree().create_timer(Global.tiroext).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	
	var direction_vector = Vector2(d_x, d_y).normalized()
	position += direction_vector * Global.tirospd * delta


func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("inimigo"):
		
		body.vida -= Global.dano_ti
		processar_morte_inimigo(body)
		queue_free()
	
	if body.is_in_group("obstaculo"):
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigo"):
		
		area.vida -= Global.dano_ti
		processar_morte_inimigo(area)
		queue_free()


func processar_morte_inimigo(alvo):
	if alvo.vida <= 0:
		_tentar_curar()
		Global.total_kills += 1
		
		if alvo.has_method("queue_free"):
			alvo.queue_free()
	
	if has_node("Recebendo"):
		$Recebendo.play()

func _tentar_curar():
	if Global.canudo == true and randf() <= Global.chance_cura:
		Global.vida_v += 1
