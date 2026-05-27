extends Node2D

@export_group("Configurações do Mapa")
@export var min_rooms: int = 8
@export var max_rooms: int = 16
@export var room_distance: int = 5000

@export_group("Cenas")
@export var player_scene: PackedScene
@export var start_room_scene: PackedScene
@export var item_room_scene: PackedScene

var player_instance: CharacterBody2D 
var map_grid = {} 
var current_grid_pos = Vector2.ZERO

func _ready():
	get_tree().root.content_scale_factor = 0.80
	
	# Alerta caso o Autoload esteja vazio no executável
	if not Global.salas or Global.salas.is_empty():
		print_rich("[color=red]ERRO: Global.salas está vazio ou não foi carregado corretamente![/color]")
		return
		
	generate_dungeon()

func generate_dungeon():
	randomize()
	
	# Limpa salas antigas com segurança
	for child in get_children():
		if player_instance and child == player_instance:
			continue
		child.queue_free()
	
	map_grid.clear()
	var created_positions = [Vector2.ZERO]
	var layout_types = { Vector2.ZERO: "start" }
	
	# Lógica de criação de caminhos
	var target_rooms = randi_range(min_rooms, max_rooms)
	while created_positions.size() < target_rooms:
		var base_pos = created_positions.pick_random()
		var dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
		var new_pos = base_pos + dir
		if not layout_types.has(new_pos):
			layout_types[new_pos] = "standard"
			created_positions.append(new_pos)

	# Define Boss e Item com segurança para evitar crash silencioso (.back() em array vazio)
	var candidates = created_positions.duplicate()
	candidates.erase(Vector2.ZERO)
	
	if not candidates.is_empty():
		var boss_pos = candidates.back() 
		layout_types[boss_pos] = "boss"
	else:
		# Fail-safe: Se o mapa falhar e só gerar 1 sala, ela vira a do boss para não crashar
		layout_types[Vector2.ZERO] = "boss"
	
	# Instancia as salas
	for pos in layout_types:
		var type = layout_types[pos]
		var room_instance = _get_room_by_type(type)
		
		if room_instance:
			add_child(room_instance)
			room_instance.global_position = pos * room_distance
			map_grid[pos] = room_instance
			
			if room_instance.has_signal("player_entered_door"):
				room_instance.player_entered_door.connect(_on_player_travel)
			if room_instance.has_method("configure_doors"):
				room_instance.configure_doors(_get_neighbors(pos, layout_types))
			
	_spawn_player_at_start()

func _get_room_by_type(type):
	match type:
		"start": 
			return start_room_scene.instantiate() if start_room_scene else null
		"item": 
			if item_room_scene:
				return item_room_scene.instantiate()
			elif Global.salas and not Global.salas.is_empty():
				return Global.salas.pick_random().instantiate()
		"boss": 
			if Global.salaboss and not Global.salaboss.is_empty():
				return Global.salaboss.pick_random().instantiate()
		"standard": 
			if Global.salas and not Global.salas.is_empty():
				return Global.salas.pick_random().instantiate()
	return null

func _get_neighbors(pos, layout):
	var n = []
	for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		if layout.has(pos + dir): n.append(dir)
	return n

func _spawn_player_at_start():
	if player_scene and map_grid.has(Vector2.ZERO):
		player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.add_to_group("player")
		player_instance.global_position = map_grid[Vector2.ZERO].global_position

func _on_player_travel(direction: Vector2):
	var new_grid_pos = current_grid_pos + direction
	if map_grid.has(new_grid_pos):
		current_grid_pos = new_grid_pos
		var next_room = map_grid[new_grid_pos]
		if next_room.has_method("get_spawn_pos"):
			player_instance.global_position = next_room.get_spawn_pos(direction)
