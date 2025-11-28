extends Node2D

@export_group("Configurações")
@export var min_rooms: int = 8
@export var max_rooms: int = 16
@export var room_distance: int = 5000 # Distância física entre as salas

@export_group("Cenas Específicas")
@export var start_room_scene: PackedScene      # Arraste StartRoom.tscn
@export var boss_room_scene: PackedScene       # Arraste SalaBoss.tscn (Especial 1)
@export var item_room_scene: PackedScene       # Arraste SalaItem.tscn (Especial 2)
@export var player_scene: PackedScene          # Arraste Player.tscn

# O Mapa Lógico e a Posição Atual
var map_grid = {} 
var current_grid_pos = Vector2.ZERO
var player_instance: Node2D

func _ready():
	# Verifica se o Global tem salas
	if not Global.salas or Global.salas.is_empty():
		push_error("ERRO: Global.salas está vazio! Adicione cenas no script Global.")
		return
	
	generate_dungeon()

func generate_dungeon():
	randomize()
	
	# 1. GERAÇÃO LÓGICA (O Desenho do Mapa)
	var rooms_to_create = randi_range(min_rooms, max_rooms)
	var created_positions = [Vector2.ZERO]
	var layout_types = {} 
	
	# A sala (0,0) é sempre Start
	layout_types[Vector2.ZERO] = "start"
	
	# Loop para criar o formato do mapa
	while created_positions.size() < rooms_to_create:
		var base_pos = created_positions.pick_random()
		var dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
		var new_pos = base_pos + dir
		
		if not layout_types.has(new_pos):
			layout_types[new_pos] = "standard"
			created_positions.append(new_pos)

	# 2. DEFINIR SALAS ESPECIAIS (Boss na ponta)
	var candidates = created_positions.duplicate()
	candidates.erase(Vector2.ZERO)
	
	# Acha pontas (salas com 1 vizinho)
	var dead_ends = []
	for pos in candidates:
		if _count_neighbors_logical(pos, layout_types) == 1:
			dead_ends.append(pos)
	
	# Pega a ponta mais distante para o Boss
	var boss_pos = Vector2.ZERO
	if dead_ends.size() > 0:
		dead_ends.sort_custom(func(a, b): return a.length() > b.length())
		boss_pos = dead_ends[0]
	else:
		boss_pos = candidates.back()
		
	layout_types[boss_pos] = "boss"
	candidates.erase(boss_pos)
	
	# Define a segunda sala especial aleatória
	if candidates.size() > 0:
		var item_pos = candidates.pick_random()
		layout_types[item_pos] = "item"

	# 3. INSTANCIAÇÃO (Colocar as salas no jogo)
	for pos in layout_types:
		var type = layout_types[pos]
		var room_instance = null
		
		match type:
			"start": room_instance = start_room_scene.instantiate()
			"boss": room_instance = boss_room_scene.instantiate()
			"item": room_instance = item_room_scene.instantiate()
			"standard": room_instance = Global.salas.pick_random().instantiate()
		
		if room_instance:
			add_child(room_instance)
			
			# Posiciona longe fisicamente baseado no Grid
			room_instance.global_position = pos * room_distance
			map_grid[pos] = room_instance
			
			# Conecta o sinal da sala para viajar
			if room_instance.has_signal("player_entered_door"):
				room_instance.player_entered_door.connect(_on_player_travel)

	# 4. CONFIGURAR PORTAS (Abrir/Fechar)
	for pos in map_grid:
		var room = map_grid[pos]
		var neighbors = []
		for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
			if map_grid.has(pos + dir):
				neighbors.append(dir)
		
		if room.has_method("configure_doors"):
			room.configure_doors(neighbors)
			
	# 5. CRIAR O PLAYER
	_spawn_player_at_start()

# --- LÓGICA DE MOVIMENTO ---

func _spawn_player_at_start():
	if player_scene:
		player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.add_to_group("player")

		current_grid_pos = Vector2.ZERO

func _on_player_travel(direction: Vector2):
	var new_grid_pos = current_grid_pos + direction
	
	if map_grid.has(new_grid_pos):
		print("Gerador: Viajando para ", new_grid_pos)
		
		var next_room = map_grid[new_grid_pos]
		current_grid_pos = new_grid_pos
		
		# Pega a posição do Marker2D correto
		var spawn_pos = next_room.get_spawn_pos(direction)
		
		# Teleporta o Player
		player_instance.global_position = spawn_pos
	else:
		print("Gerador: Erro, sala não encontrada.")

func _count_neighbors_logical(pos: Vector2, layout: Dictionary) -> int:
	var c = 0
	for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		if layout.has(pos + dir):
			c += 1
	return c
