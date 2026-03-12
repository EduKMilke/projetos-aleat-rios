extends Node2D
class_name DungeonRoom

signal player_entered_door(direction: Vector2)

# --- REFERÊNCIAS ---
@export_group("Portas")
@export var door_top: Node2D
@export var door_bottom: Node2D
@export var door_left: Node2D
@export var door_right: Node2D

@export_group("Spawns")
@export var spawn_top: Marker2D
@export var spawn_bottom: Marker2D
@export var spawn_left: Marker2D
@export var spawn_right: Marker2D

@onready var room_camera: Camera2D = $Camera2D
@onready var camera_zone: Area2D = $CameraZone

# --- VARIÁVEIS DA ARENA ---
var sala_concluida: bool = false
var inimigos_vivos: int = 0

func _ready():
	# Conecta portas
	if door_top and door_top.has_signal("player_entered"):
		door_top.player_entered.connect(func(): _on_door_signal(Vector2.UP))
	if door_bottom and door_bottom.has_signal("player_entered"):
		door_bottom.player_entered.connect(func(): _on_door_signal(Vector2.DOWN))
	if door_left and door_left.has_signal("player_entered"):
		door_left.player_entered.connect(func(): _on_door_signal(Vector2.LEFT))
	if door_right and door_right.has_signal("player_entered"):
		door_right.player_entered.connect(func(): _on_door_signal(Vector2.RIGHT))

	# Configura a Câmera
	if room_camera: room_camera.enabled = false
	if camera_zone: camera_zone.body_entered.connect(_on_camera_zone_entered)

# --- QUANDO O PLAYER ENTRA NA SALA ---
func _on_camera_zone_entered(body):
	if body.is_in_group("player"):
		# 1. Liga a Câmera
		if room_camera:
			room_camera.enabled = true
			room_camera.make_current()
			
		# 2. Verifica se precisa trancar a sala
		if not sala_concluida:
			_verificar_e_trancar_sala()

# --- LÓGICA DE INIMIGOS E PORTAS ---
func _verificar_e_trancar_sala():
	# Pega TODOS os inimigos do jogo
	var todos_inimigos = get_tree().get_nodes_in_group("inimigo")
	var inimigos_desta_sala = []
	
	# Filtra apenas os inimigos que estão DENTRO desta sala
	for inimigo in todos_inimigos:
		if is_ancestor_of(inimigo): # Se o inimigo for filho/descendente desta sala
			inimigos_desta_sala.append(inimigo)
	
	inimigos_vivos = inimigos_desta_sala.size()
	
	if inimigos_vivos > 0:
		_trancar_portas()
		# Conecta um sinal para saber quando cada inimigo morre (é deletado)
		for inimigo in inimigos_desta_sala:
			if not inimigo.tree_exited.is_connected(_on_inimigo_morreu):
				inimigo.tree_exited.connect(_on_inimigo_morreu)
	else:
		sala_concluida = true # Se não tem inimigos, a sala já está livre

func _on_inimigo_morreu():
	inimigos_vivos -= 1
	if inimigos_vivos <= 0:
		sala_concluida = true
		_destrancar_portas()

func _trancar_portas():
	# Chama a função de trancar dentro de cada porta (se a porta estiver ativa/visível)
	if door_top and door_top.visible and door_top.has_method("trancar"): door_top.trancar()
	if door_bottom and door_bottom.visible and door_bottom.has_method("trancar"): door_bottom.trancar()
	if door_left and door_left.visible and door_left.has_method("trancar"): door_left.trancar()
	if door_right and door_right.visible and door_right.has_method("trancar"): door_right.trancar()

func _destrancar_portas():
	# Chama a função de destrancar dentro de cada porta
	if door_top and door_top.has_method("destrancar"): door_top.destrancar()
	if door_bottom and door_bottom.has_method("destrancar"): door_bottom.destrancar()
	if door_left and door_left.has_method("destrancar"): door_left.destrancar()
	if door_right and door_right.has_method("destrancar"): door_right.destrancar()

# --- MÉTODOS ANTIGOS MANTIDOS ---
func _on_door_signal(direction: Vector2):
	emit_signal("player_entered_door", direction)

func configure_doors(active_neighbors: Array):
	if door_top: door_top.set_active(Vector2.UP in active_neighbors)
	if door_bottom: door_bottom.set_active(Vector2.DOWN in active_neighbors)
	if door_left: door_left.set_active(Vector2.LEFT in active_neighbors)
	if door_right: door_right.set_active(Vector2.RIGHT in active_neighbors)

func get_spawn_pos(from_direction: Vector2) -> Vector2:
	var dir = from_direction.round()
	if dir == Vector2.UP:
		if spawn_bottom: return spawn_bottom.global_position
	elif dir == Vector2.DOWN:
		if spawn_top: return spawn_top.global_position
	elif dir == Vector2.LEFT:
		if spawn_right: return spawn_right.global_position
	elif dir == Vector2.RIGHT:
		if spawn_left: return spawn_left.global_position
	return global_position
