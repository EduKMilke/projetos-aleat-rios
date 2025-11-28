extends Node2D
class_name DungeonRoom

# Sinal que avisa o Mapa para onde o player quer ir
signal player_entered_door(direction: Vector2)

# --- Referências das Portas (Arraste as cenas das portas aqui) ---
@export_group("Portas (Cenas)")
@export var door_top: Node2D
@export var door_bottom: Node2D
@export var door_left: Node2D
@export var door_right: Node2D

# --- Referências dos Spawns (Arraste os Marker2D aqui) ---
@export_group("Spawns (Marker2D)")
@export var spawn_top: Marker2D
@export var spawn_bottom: Marker2D
@export var spawn_left: Marker2D
@export var spawn_right: Marker2D

func _ready():
	# Conecta os sinais das portas manualmente para garantir segurança
	if door_top and door_top.has_signal("player_entered"):
		door_top.player_entered.connect(func(): _on_door_signal(Vector2.UP))
		
	if door_bottom and door_bottom.has_signal("player_entered"):
		door_bottom.player_entered.connect(func(): _on_door_signal(Vector2.DOWN))
		
	if door_left and door_left.has_signal("player_entered"):
		door_left.player_entered.connect(func(): _on_door_signal(Vector2.LEFT))
		
	if door_right and door_right.has_signal("player_entered"):
		door_right.player_entered.connect(func(): _on_door_signal(Vector2.RIGHT))

# Função central que recebe o aviso da porta e repassa para o Mapa
func _on_door_signal(direction: Vector2):
	print("Sala: Player entrou na porta direção ", direction)
	emit_signal("player_entered_door", direction)

# Configura quais portas ficam visíveis
func configure_doors(active_neighbors: Array):
	# Tenta chamar a função set_active se a porta existir
	if door_top and door_top.has_method("set_active"):
		door_top.set_active(Vector2.UP in active_neighbors)
		
	if door_bottom and door_bottom.has_method("set_active"):
		door_bottom.set_active(Vector2.DOWN in active_neighbors)
		
	if door_left and door_left.has_method("set_active"):
		door_left.set_active(Vector2.LEFT in active_neighbors)
		
	if door_right and door_right.has_method("set_active"):
		door_right.set_active(Vector2.RIGHT in active_neighbors)

# Calcula onde o player deve aparecer
# JEITO CERTO (Obrigatório):
func get_spawn_pos(from_direction: Vector2) -> Vector2:
	# 1. Arredonda o vetor para garantir que (0, -0.999) vire (0, -1)
	var dir = from_direction.normalized()
	var target_marker: Marker2D = null

	# 2. Define qual marker queremos usar
	if dir == Vector2.RIGHT:
		target_marker = spawn_left
	elif dir == Vector2.LEFT:
		target_marker = spawn_right
	elif dir == Vector2.UP:
		target_marker = spawn_bottom
	elif dir == Vector2.DOWN:
		target_marker = spawn_top
	else:
		print("ERRO: Direção inválida!")
		return global_position
	if target_marker != null:
		return target_marker.global_position
	else:
			print("ERRO: Marker não encontrado!")
			return global_position
