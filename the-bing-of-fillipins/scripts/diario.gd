extends Area2D


@onready var interface_pagina = $CanvasLayer
@onready var texto_label = $CanvasLayer/Label

var lendo = false

func _ready():
	interface_pagina.hide()
	escolher_poema_aleatorio()

func escolher_poema_aleatorio():
	if Livraria.poemas.size() > 0:
		texto_label.text = Livraria.poemas.pick_random()
	else:
		texto_label.text = "O diário está em branco..."

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not lendo:
		mostrar_pagina()

func mostrar_pagina():
	lendo = true
	interface_pagina.show()
	
	
	get_tree().paused = true
	
	

func _input(event):
	
	if lendo and (event is InputEventKey or event is InputEventMouseButton):
		if event.is_pressed():
			fechar_e_sumir()

func fechar_e_sumir():
	get_tree().paused = false 
	queue_free() 
