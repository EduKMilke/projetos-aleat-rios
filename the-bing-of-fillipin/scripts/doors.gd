extends Node2D
class_name DungeonDoor # Define o tipo globalmente

# Sinal que avisa a sala que o player entrou
signal player_entered

# O nó de colisão TEM que se chamar "Area2D" na cena da porta
@onready var area = $Area2D 

func _ready():
	if area:
		# Conecta o sinal nativo da Godot
		area.body_entered.connect(_on_body_entered)
	else:
		print("ERRO CRÍTICO: Nó 'Area2D' não encontrado na porta: ", name)

func _on_body_entered(body):
	# Verifica o grupo (lembre de adicionar o grupo 'player' no seu personagem)
	if body.is_in_group("player"):
		emit_signal("player_entered")

# Função visual para esconder portas que não levam a lugar nenhum
func set_active(is_active: bool):
	visible = is_active
	if area:
		# Desliga a colisão para o player não entrar numa porta falsa
		area.monitoring = is_active
		area.monitorable = is_active
