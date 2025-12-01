extends Node2D
class_name DungeonRoom

signal player_entered_door(direction: Vector2)

# --- REFERÊNCIAS DO INSPECTOR ---
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

# --- REFERÊNCIAS INTERNAS (Automáticas) ---
# A sala precisa ter um nó chamado "Camera2D" e um "CameraZone"
@onready var room_camera: Camera2D = $Camera2D
@onready var camera_zone: Area2D = $CameraZone

func _ready():
	# 1. Conecta as portas (Manteve igual)
	if door_top and door_top.has_signal("player_entered"):
		door_top.player_entered.connect(func(): _on_door_signal(Vector2.UP))
	if door_bottom and door_bottom.has_signal("player_entered"):
		door_bottom.player_entered.connect(func(): _on_door_signal(Vector2.DOWN))
	if door_left and door_left.has_signal("player_entered"):
		door_left.player_entered.connect(func(): _on_door_signal(Vector2.LEFT))
	if door_right and door_right.has_signal("player_entered"):
		door_right.player_entered.connect(func(): _on_door_signal(Vector2.RIGHT))

	# 2. Configura a Lógica da Câmera Própria
	if room_camera:
		room_camera.enabled = false # Começa desligada
	else:
		print("ERRO: Sala ", name, " não tem um nó 'Camera2D' dentro dela!")

	if camera_zone:
		# Conecta o sinal para detectar quando o player entra na sala
		if not camera_zone.body_entered.is_connected(_on_camera_zone_entered):
			camera_zone.body_entered.connect(_on_camera_zone_entered)
	else:
		print("ERRO: Sala ", name, " não tem um nó 'CameraZone' (Area2D)!")

# --- QUANDO O PLAYER ENTRA NA ZONA DA SALA ---
func _on_camera_zone_entered(body):
	if body.is_in_group("player"):
		# Ativa a câmera desta sala
		# No Godot, ao ativar uma câmera, a anterior é desativada automaticamente
		if room_camera:
			room_camera.enabled = true
			room_camera.make_current() # Garante que ela assuma o controle

# --- RESTO DO CÓDIGO (Portas e Spawns) ---
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
