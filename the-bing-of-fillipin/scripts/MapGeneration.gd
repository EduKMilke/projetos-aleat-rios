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
	if not Global.salas or Global.salas.is_empty():
		push_error("ERRO: Global.salas vazia!")
		return
	generate_dungeon()

func generate_dungeon():
	randomize()
	for child in get_children(): child.queue_free()
	map_grid.clear()
	
	var rooms_to_create = randi_range(min_rooms, max_rooms)
	var created_positions = [Vector2.ZERO]
	var layout_types = { Vector2.ZERO: "start" }
	
	while created_positions.size() < rooms_to_create:
		var base_pos = created_positions.pick_random()
		var dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
		var new_pos = base_pos + dir
		
		if not layout_types.has(new_pos):
			layout_types[new_pos] = "standard"
			created_positions.append(new_pos)

	# Boss e Item logic
	var candidates = created_positions.duplicate()
	candidates.erase(Vector2.ZERO)
	var dead_ends = []
	for pos in candidates:
		if _count_neighbors(pos, layout_types) == 1: dead_ends.append(pos)
	
	var boss_pos = candidates.back()
	if dead_ends.size() > 0:
		dead_ends.sort_custom(func(a, b): return a.length() > b.length())
		boss_pos = dead_ends[0]
	
	layout_types[boss_pos] = "boss"
	candidates.erase(boss_pos)
	if candidates.size() > 0: layout_types[candidates.pick_random()] = "item"

	# Instanciação
	for pos in layout_types:
		var type = layout_types[pos]
		var room_instance = null
		
		match type:
			"start": room_instance = start_room_scene.instantiate()
			"item": room_instance = item_room_scene.instantiate() if item_room_scene else Global.salas.pick_random().instantiate()
			"standard": room_instance = Global.salas.pick_random().instantiate()
			"boss": room_instance = Global.salaboss.pick_random().instantiate() if Global.salaboss else Global.salas.pick_random().instantiate()
		
		if room_instance:
			add_child(room_instance)
			room_instance.global_position = pos * room_distance
			map_grid[pos] = room_instance
			if room_instance.has_signal("player_entered_door"):
				room_instance.player_entered_door.connect(_on_player_travel)
			if room_instance.has_method("configure_doors"):
				var neighbors = []
				for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
					if layout_types.has(pos + dir): neighbors.append(dir)
				room_instance.configure_doors(neighbors)
			
	_spawn_player_at_start()

func _spawn_player_at_start():
	if player_scene:
		player_instance = player_scene.instantiate() as CharacterBody2D
		add_child(player_instance)
		player_instance.add_to_group("player")
		
		var start_room = map_grid[Vector2.ZERO]
		player_instance.global_position = start_room.global_position
		current_grid_pos = Vector2.ZERO
		
		# NOTA: Agora quem atualiza a câmera é o Area2D da sala, assim que o player nasce lá!
	else:
		push_error("ERRO: Player Scene não atribuída!")

func _on_player_travel(direction: Vector2):
	if not player_instance: return
	var new_grid_pos = current_grid_pos + direction
	
	if map_grid.has(new_grid_pos):
		var next_room = map_grid[new_grid_pos]
		current_grid_pos = new_grid_pos
		var spawn_pos = next_room.get_spawn_pos(direction)
		
		player_instance.global_position = spawn_pos
		player_instance.velocity = Vector2.ZERO
		
		# O Area2D da nova sala vai detectar o player automaticamente
		# e atualizar a câmera. Não precisamos fazer nada aqui.
	else:
		print("ERRO: Sala não encontrada.")

func _count_neighbors(pos: Vector2, layout: Dictionary) -> int:
	var c = 0
	for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		if layout.has(pos + dir): c += 1
	return c
