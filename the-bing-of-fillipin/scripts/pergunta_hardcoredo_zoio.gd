
extends Control
var perguntas = [
	{"texto": "Quanto é 23 x 4 -19?",
	 "resposta": "73"},
	{"texto": "Qual a raiz quadrada de 169?",
	 "resposta": "13"},
	{"texto": "Se um trêm viaja a uma velocidade de 770km/h e percorre uma distância de 88880 kilometrôs durante 3 dias, ignorando a resistência do ar e o número de curvas tomadas durante o percurso, quanto é 23 X 3?",
	 "resposta": "69"},
	{"texto": "Quantos 9 existem entre 1 e 100?",
	 "resposta": "11"},
	{"texto": "Se João comprou 7 maçãs e Bruna roubou um valor igual a hipotenusa de um triângulo retângulo de lados iguais a 4 e 3, com quantas maçãs João ficou?",
	 "resposta": "2"},
	{"texto": "Na expressão X²+3X-4 = 0   Qual o maior valor de X?",
	 "resposta": "1"},
	{"texto": "Quanto é 49 x 5 x 78 x 98 x 99 x 867 x 490 x 18 x 0?",
	 "resposta": "0"}
	
]
var pergunta_atual = {}

@onready var timer = $QuizTimer
@onready var label_cronometro = $Cronometro
@onready var label_pergunta = $Pergunta
@onready var resposta = $LineEdit

func _ready() -> void:
	sortear_pergunta()

func sortear_pergunta():
	var aleatorio = randi() % perguntas.size()
	pergunta_atual = perguntas[aleatorio]
	label_pergunta.text = pergunta_atual["texto"]

func _process(_delta: float) -> void:
	
	var tempo_restante = ceil(timer.time_left)
	label_cronometro.text = str(tempo_restante)
	if tempo_restante <= 5:
		label_cronometro.add_theme_color_override("font_color", Color.RED)
	else:
		label_cronometro.add_theme_color_override("font_color", Color.WHITE)
func _on_quiz_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://salas/GameOver.tscn")
	
	
	

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.to_lower() == pergunta_atual["resposta"].to_lower():
		get_tree().change_scene_to_file("res://obj/world.tscn")
	else:
		get_tree().change_scene_to_file("res://salas/GameOver.tscn")
