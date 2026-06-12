extends Area2D
@onready var area = $Onda
@onready var colisão = $Onda/CollisionShape2D
@onready var sprite = $Onda/AnimatedSprite2D
var vida = 10
var alcance = 109
var atacando = false
var velocidade = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colisão.shape.radius = 0.0
	colisão.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if vida <=0:
		queue_free()
	if atacando:
		colisão.shape.radius += velocidade * delta
		if colisão.shape.radius >= alcance:
			encerrar_ataque()


func _on_ataque_timeout() -> void:
	atacar()
func atacar():
	$AnimatedSprite2D.play("Atacando")
	sprite.visible = true
	atacando = true
	colisão.shape.radius=0.0
	colisão.disabled=false
	sprite.play("default")

func encerrar_ataque():
	$AnimatedSprite2D.play("default")
	sprite.visible = false
	atacando = false
	colisão.shape.radius=0.0
	colisão.disabled=true
func _on_onda_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
