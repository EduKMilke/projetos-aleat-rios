extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func exibir_item(nome: String, desc: String):
	$NomeItem.text = nome
	$DescricaoItem.text = desc
	visible = true
	
	# Faz o aviso sumir depois de 2 segundos
	await get_tree().create_timer(2.0).timeout
	visible = false
