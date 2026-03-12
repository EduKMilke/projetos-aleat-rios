extends Node2D

var max_e = 3
var atual_e = 1
var n_item=0 #numero do item
var item = preload("res://icon.svg") #foto do item
var ener = preload("res://icon.svg")
func _process(_delta):
	match n_item:
		0:
			ener=null
			max_e=0
			atual_e=0
	queue_redraw()
func _draw():
	var tama_tela = get_viewport_rect().size.x
	var novo_tamanho = Vector2(46, 46)
	var posicao = Vector2(tama_tela - novo_tamanho.x - 10, 20)
	var area_desenho = Rect2(posicao, novo_tamanho)
	var posicao2 = Vector2(tama_tela - novo_tamanho.x - 50, 20)
	var area_desenho2 = Rect2(posicao2, novo_tamanho)
	if (atual_e==max_e):
		draw_texture_rect(item, area_desenho, false,Color(1,1,1,1))
	else:
		draw_texture_rect(item, area_desenho, false,Color(1,1,1,0.5))
	if atual_e>max_e:
		atual_e=max_e
	for i in max_e:
		if i>atual_e:
			draw_texture_rect(item, area_desenho2, false,Color(0,0,0,1))
		else:
			draw_texture_rect(item, area_desenho2, false,Color(1,1,1,1))
		posicao2.y-=20
		area_desenho2 = Rect2(posicao2, novo_tamanho)
