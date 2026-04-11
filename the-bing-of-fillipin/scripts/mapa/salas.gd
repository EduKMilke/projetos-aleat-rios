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
var player_dentro: bool = false # Nova flag para controle

func _ready():
	# Conecta portas (Seu código original)
	_conectar_sinais_portas()
	
	if room_camera: room_camera.enabled = false
	if camera_zone: camera_zone.body_entered.connect(_on_camera_zone_entered)

# --- LOOP DE VERIFICAÇÃO ---
func _process(_delta):
	# Se o player está na sala e a sala ainda não foi limpa
	if player_dentro and not sala_concluida:
		_verificar_status_inimigos()

func _verificar_status_inimigos():
	var todos_inimigos = get_tree().get_nodes_in_group("inimigo")
	var count = 0
	
	for inimigo in todos_inimigos:
		if is_ancestor_of(inimigo):
			count += 1
	
	inimigos_vivos = count
	
	# Lógica de trancar/destrancar baseada no scan atual
	if inimigos_vivos > 0:
		_trancar_portas()
	else:
		_finalizar_sala()

func _finalizar_sala():
	sala_concluida = true
	_destrancar_portas()
	set_process(false) # Para de rodar o _process economizando performance

# --- QUANDO O PLAYER ENTRA NA SALA ---
func _on_camera_zone_entered(body):
	if body.is_in_group("player"):
		player_dentro = true
		if room_camera:
			room_camera.enabled = true
			room_camera.make_current()

# --- LÓGICA DE PORTAS ---
func _trancar_portas():
	# Só tranca se as portas já não estiverem trancadas (evita spam de animação)
	for door in [door_top, door_bottom, door_left, door_right]:
		if door and door.visible and door.has_method("trancar"):
			door.trancar()

func _destrancar_portas():
	for door in [door_top, door_bottom, door_left, door_right]:
		if door and door.has_method("destrancar"):
			door.destrancar()

# --- MÉTODOS AUXILIARES ---
func _conectar_sinais_portas():
	if door_top and door_top.has_signal("player_entered"):
		door_top.player_entered.connect(func(): _on_door_signal(Vector2.UP))
	if door_bottom and door_bottom.has_signal("player_entered"):
		door_bottom.player_entered.connect(func(): _on_door_signal(Vector2.DOWN))
	if door_left and door_left.has_signal("player_entered"):
		door_left.player_entered.connect(func(): _on_door_signal(Vector2.LEFT))
	if door_right and door_right.has_signal("player_entered"):
		door_right.player_entered.connect(func(): _on_door_signal(Vector2.RIGHT))

func _on_door_signal(direction: Vector2):
	emit_signal("player_entered_door", direction)

func configure_doors(active_neighbors: Array):
	if door_top: door_top.set_active(Vector2.UP in active_neighbors)
	if door_bottom: door_bottom.set_active(Vector2.DOWN in active_neighbors)
	if door_left: door_left.set_active(Vector2.LEFT in active_neighbors)
	if door_right: door_right.set_active(Vector2.RIGHT in active_neighbors)

func get_spawn_pos(from_direction: Vector2) -> Vector2:
	var dir = from_direction.round()
	if dir == Vector2.UP: return spawn_bottom.global_position if spawn_bottom else global_position
	if dir == Vector2.DOWN: return spawn_top.global_position if spawn_top else global_position
	if dir == Vector2.LEFT: return spawn_right.global_position if spawn_right else global_position
	if dir == Vector2.RIGHT: return spawn_left.global_position if spawn_left else global_position
	return global_position
