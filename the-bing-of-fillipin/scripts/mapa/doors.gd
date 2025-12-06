extends Node2D
class_name DungeonDoor # Isso permite que o script da Sala reconheça o tipo "DungeonDoor"

# Sinal que avisa a Sala que o player tocou na porta
signal player_entered

# Pega a referência automática do nó Area2D
# Se o seu nó tiver outro nome, mude "$Area2D" para "$NomeDoSeuNo"
@onready var area = $Area2D 

func _ready():
	if area:
		# Conecta o sinal de colisão nativo da Godot
		if not area.body_entered.is_connected(_on_body_entered):
			area.body_entered.connect(_on_body_entered)
	else:
		print("ERRO CRÍTICO NA PORTA: Nó 'Area2D' não encontrado na cena: ", name)

func _on_body_entered(body):
	# Verifica se quem entrou foi o Player
	# IMPORTANTE: Seu Player precisa estar no grupo "player" (minúsculo)
	if body.is_in_group("player"):
		# Só emite o sinal se a porta estiver visível/ativa
		if visible:
			emit_signal("player_entered")

# Função usada pela Sala para esconder/desativar esta porta
func set_active(is_active: bool):
	visible = is_active
	if area:
		# Desliga a física para o player não entrar numa porta invisível
		area.monitoring = is_active
		area.monitorable = is_active
