extends CharacterBody2D
const bolhas = [
	"res://assets/bolha/bolha1.png",
	"res://assets/bolha/bolha2.png",
	"res://assets/bolha/bolha3.png",
	"res://assets/bolha/bolha4.png"
]
var spr_b=null
var a=0
@onready var spr=$Sprite2D
var vel_b=0
var lat_b=0
var dis_b=0
func _ready() -> void:
	randomize()
	var _num_b=bolhas[int(randf_range(0,3))]
	spr_b=load(_num_b)
	spr.texture =spr_b
	vel_b=randf_range(0.3,1.5)
	lat_b=randf_range(0.2,0.8)
	dis_b=randf_range(0.01,0.08)

func _physics_process(_delta: float) -> void:
	
	position.y-=vel_b
	position.x= position.x+sin(a*dis_b)*lat_b
	a-=1
	if position.y<-4:
		queue_free()
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		Global.din+=1
		queue_free()
