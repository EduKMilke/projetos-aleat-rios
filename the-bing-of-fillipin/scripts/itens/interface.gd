extends CanvasLayer

@onready var label_nome = %Nome
@onready var label_desc = %Desc
@onready var fundo = %Fundo

func _ready():
	
	fundo.modulate.a = 0
	label_nome.modulate.a = 0
	label_desc.modulate.a = 0

func exibir_item(nome_do_item: String, descricao: String):
	label_nome.text = nome_do_item
	label_desc.text = descricao
	
	
	var tween = create_tween().set_parallel(true) 
	tween.tween_property(fundo, "modulate:a", 1.0, 0.5)
	tween.tween_property(label_nome, "modulate:a", 1.0, 0.5)
	tween.tween_property(label_desc, "modulate:a", 1.0, 0.5)
	
	await get_tree().create_timer(2.0).timeout
	
	
	var tween_out = create_tween().set_parallel(true)
	tween_out.tween_property(fundo, "modulate:a", 0.0, 0.5)
	tween_out.tween_property(label_nome, "modulate:a", 0.0, 0.5)
	tween_out.tween_property(label_desc, "modulate:a", 0.0, 0.5)
