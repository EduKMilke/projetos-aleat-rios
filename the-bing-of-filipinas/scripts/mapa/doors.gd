extends Node2D
class_name DungeonDoor

signal player_entered
@onready var spr= $Area2D/AnimatedSprite2D
@onready var area = $Area2D 

# --- VARIÁVEL DA ARENA ---
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
	# 1. NOVA REGRA: Se a porta estiver trancada, o player não pode passar
	if esta_trancada:
		return 
		
	# 2. Regra antiga mantida
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
	# EFEITO VISUAL (Opcional, mas recomendado para o jogador entender)
	# Exemplo 1: Deixar a porta vermelha
	modulate = Color(1, 0.5, 0.5) 
	
	# Exemplo 2: Trocar a animação
	# $AnimatedSprite2D.play("fechada")
	
	# BLOQUEIO FÍSICO (Para o player não atravessar a imagem da porta)
	# Se você criar um StaticBody2D com CollisionShape2D dentro da porta, ative-o aqui:
	# $ParedeFisica/CollisionShape2D.set_deferred("disabled", false)

func destrancar():
	esta_trancada = false
	Global.ener_ite+=1
	spr.frame=1
	modulate = Color(1, 1, 1) # Volta a cor normal
