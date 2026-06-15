
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
	 "resposta": "0"},
	{"texto": "quantas corcovas no total tem 1 camelo + 1 dromedário?",
	 "resposta": "3"},
	{"texto": "Na expressão 48 = 2x + 18, qual o valor de x?",
	 "resposta": "15"},
	{"texto": "Quanto é 10298377192761299461628 elevado na 0?",
	 "resposta": "1"},
	{"texto": "Se Eduardo = 3 e Mathias = 6, quanto vale a expressão 9((Mathias/3) + Eduardo)?",
	"resposta": "45"},
	{"texto": "Se Cristiano Ronaldo = 8 e Ronaldo Cristiano = -8, quanto vale Ronaldo Ronaldo?",
	"resposta": "0"},
	{"texto": "Dada a Equação Linear Geral da Álgebra: a1x1 + a2x2 + a3x3 + anxn = b Quanto vale 5??(Dica: termial n? = n + (n - 1) + (n - 2) ...)",
	"resposta": "15"},
	{"texto": "O que é o que é? Não se come, mas é bom para se comer.(termina com '-lher')",
	"resposta": "talher"},
	{"texto": "O que é, o que é? Nunca volta, embora nunca tenha ido.",
	"resposta": "passado"},
	{"texto": "O que é, o que é? Tem no meio do ovo.",
	"resposta": "v"},
	{"texto": "Qual peixe que caiu do prédio?",
	"resposta": "atum"},
	{"texto": "O que é, o que é? O lugar mais certo do Brasil.",
	"resposta": "sertão"},
	{"texto": "Quanto vale (-3)³ + 7*(-8)",
	"resposta": "-83"},
	{"texto": "Is cereal a soup?",
	"resposta": "no"},
	{"texto": "Dada a sequência: 1, 1, 2, 3, 5, 8... qual é o seu décimo termo?",
	"resposta": "55"},
	{"texto": "O que é, o que é? Atravessa o rio, mas nuca se molha",
	"resposta": "ponte"},
	{"texto": "Analise o fragmento exegético abaixo para responder ao item proposto. A transição da matriz produtiva feudal para o escopo do mercantilismo absolutista não se operou por mera fricção de contingências econômicas, mas sim pela aglutinação simbiótica entre a aristocracia residual e a ascendente burguesia comercial. Sob a égide do Estado-Nação incipiente, a centralização monárquica atuou como o vetor catalisador. Dado o excerto introdutório, Quanto vale 4³?",
	"resposta": "64"},
	{"texto": "Qual pais tem tralhas feitas de ouro?",
	"resposta": "Austrálha"},
	{"texto": "Qual país faria uma padaria?",
	"resposta": "Japão"},
	{"texto": "Pai de Maria tem 5 filhos Nana,Nene,Nini,Nono e ",
	"resposta": "Maria"},
	{"texto": "Segundo nome de Dom Pedro II ?",
	"resposta": "Alcântra"},
	{"texto": "Quantos cavalos de potência (cv ou hp) tem um ser humano médio em um pico de esforço de curta duração aproximadamente?(dica 1,.)",
	"resposta": "1,2"},
	{"texto": "quantos microsievert uma banana emite de radiação",
	"resposta": "0,1"},
	{"texto": "complete a frase: eu sou ....",
	"resposta": "fera"},
	{"texto": "Em uma Igreja tinha 25 velas 2 quebraram e uma derreteu, um ladrão levou 5 outro levou 7 quantas velas sobraram?",
	"resposta": "34"}
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
