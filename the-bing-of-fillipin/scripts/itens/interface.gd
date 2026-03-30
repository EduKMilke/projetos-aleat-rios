extends CanvasLayer

@onready var label_nome = %Nome
@onready var label_desc = %Desc
@onready var fundo = %Fundo

# Ajuste esse valor para subir mais ou menos (ex: 100 sobe um pouco, 200 sobe muito)
var offset_superior: float = 250.0

func _ready():
	fundo.modulate.a = 0
	label_nome.modulate.a = 0
	label_desc.modulate.a = 0
	
	get_tree().root.size_changed.connect(centralizar_tudo)
	centralizar_tudo()

func centralizar_tudo():
	var viewport_size = get_viewport().get_visible_rect().size
	
	# CALCULO DA POSIÇÃO:
	# X: Meio exato (Largura da tela / 2) - (Metade do fundo)
	# Y: Meio da tela - (Metade do fundo) - (O quanto você quer subir)
	var pos_x = (viewport_size.x / 2.0) - (fundo.size.x / 2.0)
	var pos_y = (viewport_size.y / 2.0) - (fundo.size.y / 2.0) - offset_superior
	
	fundo.position = Vector2(pos_x, pos_y)
	
	# Centraliza os textos horizontalmente dentro do fundo
	label_nome.position.x = (fundo.size.x / 2.0) - (label_nome.size.x / 2.0)
	label_desc.position.x = (fundo.size.x / 2.0) - (label_desc.size.x / 2.0)

func exibir_item(nome_do_item: String, descricao: String):
	label_nome.text = nome_do_item
	label_desc.text = descricao
	
	centralizar_tudo()
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(fundo, "modulate:a", 1.0, 0.4)
	tween.tween_property(label_nome, "modulate:a", 1.0, 0.4)
	tween.tween_property(label_desc, "modulate:a", 1.0, 0.4)
	
	await get_tree().create_timer(2.5).timeout
	
	var tween_out = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(fundo, "modulate:a", 0.0, 0.4)
	tween_out.tween_property(label_nome, "modulate:a", 0.0, 0.4)
	tween_out.tween_property(label_desc, "modulate:a", 0.0, 0.4)
