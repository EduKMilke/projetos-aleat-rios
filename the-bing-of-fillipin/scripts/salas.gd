extends Node2D
class_name DungeonRoom

# Sinal que avisa o Gerador para trocar de sala
signal player_entered_door(direction: Vector2)

# --- REFERÊNCIAS (ARRASTE NO INSPECTOR) ---
@export_group("Portas (Cenas)")
@export var door_top: Node2D
@export var door_bottom: Node2D
@export var door_left: Node2D
@export var door_right: Node2D

@export_group("Spawns (Marker2D)")
@export var spawn_top: Marker2D
@export var spawn_bottom: Marker2D
@export var spawn_left: Marker2D
@export var spawn_right: Marker2D

func _ready():
	# Conecta os sinais das portas manualmente e com segurança
	
	if door_top and door_top.has_signal("player_entered"):
		door_top.player_entered.connect(func(): _on_door_signal(Vector2.UP))
	
	if door_bottom and door_bottom.has_signal("player_entered"):
		door_bottom.player_entered.connect(func(): _on_door_signal(Vector2.DOWN))
	
	if door_left and door_left.has_signal("player_entered"):
		door_left.player_entered.connect(func(): _on_door_signal(Vector2.LEFT))
	
	if door_right and door_right.has_signal("player_entered"):
		door_right.player_entered.connect(func(): _on_door_signal(Vector2.RIGHT))

# Função central que recebe o aviso da porta e repassa para o Gerador
func _on_door_signal(direction: Vector2):
	print("SALA: Player entrou na porta direção ", direction)
	emit_signal("player_entered_door", direction)

# Configura quais portas ficam visíveis baseadas nos vizinhos
func configure_doors(active_neighbors: Array):
	if door_top and door_top.has_method("set_active"):
		door_top.set_active(Vector2.UP in active_neighbors)
		
	if door_bottom and door_bottom.has_method("set_active"):
		door_bottom.set_active(Vector2.DOWN in active_neighbors)
		
	if door_left and door_left.has_method("set_active"):
		door_left.set_active(Vector2.LEFT in active_neighbors)
		
	if door_right and door_right.has_method("set_active"):
		door_right.set_active(Vector2.RIGHT in active_neighbors)

# Calcula onde o player deve aparecer na NOVA sala
func get_spawn_pos(from_direction: Vector2) -> Vector2:
	var dir = from_direction.round() # Evita erros de arredondamento
	
	# Lógica Cruzada:
	# Se entrei na porta de CIMA (UP), tenho que sair na parte de BAIXO (BOTTOM)
	
	if dir == Vector2.UP:
		if spawn_bottom: return spawn_bottom.global_position
		
	elif dir == Vector2.DOWN:
		if spawn_top: return spawn_top.global_position
		
	elif dir == Vector2.LEFT:
		if spawn_right: return spawn_right.global_position
		
	elif dir == Vector2.RIGHT:
		if spawn_left: return spawn_left.global_position
	
	# Se chegou aqui, é porque o Marker não foi atribuído no Inspector
	print("ERRO NA SALA: Marker de Spawn não encontrado para a direção ", dir)
	return global_position # Retorna o centro da sala como segurança
