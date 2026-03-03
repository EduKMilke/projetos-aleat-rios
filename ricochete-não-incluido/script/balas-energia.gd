extends Control

var balas = preload("res://icon.svg")
var energia = preload("res://icon.svg")
func _process(_delta: float) -> void:
	queue_redraw()
func _draw() -> void:
	var tama = get_viewport_rect().size
	var tama_icone= Vector2(32, 32)
	var p_bala = Vector2(20, 20) 
	var p_ener = Vector2(tama.x - tama_icone.x - 20, 20)
	for i in Global.balas:
		draw_texture_rect(balas, Rect2(p_bala, tama_icone), false)
		p_bala.x+=20
	for i in Global.ener:
		draw_texture_rect(energia, Rect2(p_ener, tama_icone), false)
