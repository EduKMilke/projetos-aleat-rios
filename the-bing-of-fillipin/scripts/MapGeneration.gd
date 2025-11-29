extends Node2D

@export_group("Configurações do Mapa")
@export var min_rooms: int = 8
@export var max_rooms: int = 16
@export var room_distance: int = 5000
@export var window_width: int = 1280
@export var window_height: int = 720

@export_group("Cenas")
@export var player_scene: PackedScene          # Arraste o Player.tscn aqui
@export var start_room_scene: PackedScene      # Arraste StartRoom.tscn
@export var item_room_scene: PackedScene       # Arraste SalaItem.tscn

# Variáveis Internas
# Definimos como CharacterBody2D para evitar erro de 'velocity'
var player_instance: CharacterBody2D 
var map_grid = {} 
var current_grid_pos = Vector2.ZERO

func _ready():
	print("--- MAP GENERATOR INICIADO (Modo Direto) ---")
	
	if not Global.salas or Global.salas.is_empty():
		push_error("ERRO: Global.salas vazia! Configure o Autoload.")
		return
	
	if not player_scene:
		push_error("ERRO CRÍTICO: Arraste o Player.tscn para o Inspector!")
		return
		
	generate_dungeon()

func generate_dungeon():
	randomize()
	
	# 1. Limpeza
	for child in get_children():
		child.queue_free()
	map_grid.clear()
	
	# 2. Geração Lógica (Algoritmo Blob)
	var rooms_to_create = randi_range(min_rooms, max_rooms)
	var created_positions = [Vector2.ZERO]
	var layout_types = {} 
	
	layout_types[Vector2.ZERO] = "start"
	
	while created_positions.size() < rooms_to_create:
		var base_pos = created_positions.pick_random()
		var dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
		var new_pos = base_pos + dir
		
		if not layout_types.has(new_pos):
			layout_types[new_pos] = "standard"
			created_positions.append(new_pos)

	# 3. Salas Especiais (Boss e Item)
	var candidates = created_positions.duplicate()
	candidates.erase(Vector2.ZERO)
	
	var dead_ends = []
	for pos in candidates:
		if _count_neighbors(pos, layout_types) == 1:
			dead_ends.append(pos)
	
	var boss_pos = Vector2.ZERO
	if dead_ends.size() > 0:
		dead_ends.sort_custom(func(a, b): return a.length() > b.length())
		boss_pos = dead_ends[0]
	else:
		boss_pos = candidates.back()
	
	layout_types[boss_pos] = "boss"
	candidates.erase(boss_pos)
	
	if candidates.size() > 0:
		var item_pos = candidates.pick_random()
		layout_types[item_pos] = "item"

	# 4. Instanciação Física das Salas
	for pos in layout_types:
		var type = layout_types[pos]
		var room_instance = null
		
		match type:
			"start": room_instance = start_room_scene.instantiate()
			"item": room_instance = item_room_scene.instantiate()
			"standard": room_instance = Global.salas.pick_random().instantiate()
			"boss": 
				if Global.salaboss.size() > 0:
					room_instance = Global.salaboss.pick_random().instantiate()
		
		if room_instance:
			add_child(room_instance)
			room_instance.global_position = pos * room_distance
			map_grid[pos] = room_instance
			
			# Conecta sinal de viagem
			if room_instance.has_signal("player_entered_door"):
				room_instance.player_entered_door.connect(_on_player_travel)

	# 5. Configurar Portas
	for pos in map_grid:
		var room = map_grid[pos]
		var neighbors = []
		for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
			if map_grid.has(pos + dir):
				neighbors.append(dir)
		if room.has_method("configure_doors"):
			room.configure_doors(neighbors)
			
	# 6. Spawnar Player (Diretamente)
	_spawn_player_at_start()

func _spawn_player_at_start():
	print("--- SPAWNANDO PLAYER ---")
	if player_scene:
		# Cria o player diretamente aqui
		# O "as CharacterBody2D" garante que o Godot entenda o tipo
		player_instance = player_scene.instantiate() as CharacterBody2D
		
		if player_instance:
			add_child(player_instance)
			player_instance.add_to_group("player")
			
			var start_room = map_grid[Vector2.ZERO]
			
			# Posiciona no centro da sala inicial
			player_instance.global_position = start_room.global_position
			current_grid_pos = Vector2.ZERO
			
			# Configura Câmera
		else:
			print("ERRO: A cena do Player não é um CharacterBody2D!")
	else:
		print("ERRO: Player Scene não atribuída no Inspector!")

func _on_player_travel(direction: Vector2):
	print("--- VIAJANDO: Direção ", direction, " ---")
	
	if not player_instance:
		print("ERRO CRÍTICO: Player não existe.")
		return

	var new_grid_pos = current_grid_pos + direction
	
	if map_grid.has(new_grid_pos):
		var next_room = map_grid[new_grid_pos]
		current_grid_pos = new_grid_pos
		
		var spawn_pos = next_room.get_spawn_pos(direction)
		print("Destino: ", new_grid_pos, " | Spawn Global: ", spawn_pos)
		
		# Debug Visual Vermelho (Onde o jogo quer spawnar)
		var debug = ColorRect.new(); debug.size = Vector2(20,20); debug.color = Color.RED
		debug.global_position = spawn_pos; add_child(debug)
		
		# Teleporta
		player_instance.global_position = spawn_pos
		player_instance.velocity = Vector2.ZERO # Zera a inércia
		

	else:
		print("ERRO: Sala não encontrada na direção ", direction)


func _count_neighbors(pos: Vector2, layout: Dictionary) -> int:
	var c = 0
	for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		if layout.has(pos + dir): c += 1
	return c
