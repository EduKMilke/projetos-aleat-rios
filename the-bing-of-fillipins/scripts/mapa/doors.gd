extends Node2D
class_name DungeonDoor

signal player_entered
@onready var spr= $Area2D/AnimatedSprite2D
@onready var area = $Area2D 


# Diz se a porta está bloqueada pelos inimigos
var esta_trancada: bool = false 

func _ready():
	if area:
		if not area.body_entered.is_connected(_on_body_entered):
			area.body_entered.connect(_on_body_entered)
	else:
		print("ERRO CRÍTICO NA PORTA: Nó 'Area2D' não encontrado na cena: ", name)
	spr.frame=1
func _on_body_entered(body):
	
	if esta_trancada:
		return 
		
	
	if body.is_in_group("player"):
		if visible:
			emit_signal("player_entered")

func set_active(is_active: bool):
	visible = is_active
	if area:
		area.monitoring = is_active
		area.monitorable = is_active

# --- FUNÇÕES CHAMADAS PELA SALA QUANDO TEM INIMIGOS ---
func trancar():
	esta_trancada = true
	spr.frame=0
	
	
	modulate = Color(1, 0.5, 0.5) 
	
	# Trocar a animação
	# $AnimatedSprite2D.play("fechada")
	
	# BLOQUEIO FÍSICO 
	

func destrancar():
	esta_trancada = false
	Global.ener_ite+=1
	spr.frame=1
	modulate = Color(1, 1, 1) 
