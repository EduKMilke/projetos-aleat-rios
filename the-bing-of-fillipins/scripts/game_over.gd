extends Control


var cont=0
func _ready() -> void:
	get_tree().root.content_scale_factor = 1

func _process(delta: float) -> void:

	if Input.is_action_just_pressed("ui_up"):
		cont+=1
	if Input.is_action_just_pressed("ui_down"):
		cont-=1
	if cont>1:
		cont=0
	if cont<0:
		cont=1
	match cont:
		0:
			$Tentar.frame = 1
			$Sair.frame = 0
			if Input.is_action_just_pressed("ui_accept"):
				Global.vida_v = 3
				Global.vida_maxv = 3
				Global.mitose = false
				Global.luckyton = false
				Global.escala_tiro = 1.0
				Global.lapis_duplo = false
				Global.cachecol = false 
				Global.canudo = false
				Global.mola = false
				Global.inteligencia = 1
				Global.mdano=1 #multiplicador do dano
				Global.mtiroc=1 #multiplicador do cooldown do tiro
				Global.plaspd=250 #veloc do player
				Global.tiroc=0.5 * Global.mtiroc #coldown do tiro
				Global.vida_c=1#vida cinza lá
				Global.vida_g=Global.vida_v+Global.vida_c #soma das duas vidads
				Global.dano=true
				Global.t_dano=1 #tempo que player fica imortal dps de tomar dano
				Global.ener_ite=0
				Global.espinho=true #dano de espinho ativado
				
				get_tree().change_scene_to_file("res://obj/world.tscn")

		1:
			$Tentar.frame = 0
			$Sair.frame = 1
			if Input.is_action_just_pressed("ui_accept"):
				get_tree().quit()
			
		
