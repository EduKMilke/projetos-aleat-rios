extends CharacterBody2D

var tiro = preload("res://obj/tiros_dano_player/tiro_quase_segue.tscn")
var speed = 200
var direction = Vector2(1, 1).normalized() # Já podemos definir a direção inicial aqui
var vida = 70
var vida_a = vida
var player = null
var move = true
var a = true

func _physics_process(delta):
 if a == true:
  a = false
  dano_troca()
 if player == null:
  player = get_tree().get_first_node_in_group("player")
 if player != null and global_position.distance_to(player.global_position) < 800:
  
  # Lógica de aumentar velocidade ao perder vida
  if vida != vida_a:
   speed += (vida_a - vida) * 10
   vida_a = vida # CORREÇÃO: Atualiza a vida antiga para a vida nova (não cura o inimigo)
   
  velocity = direction * speed
  
 # Movimentação e colisão
 if move == true:
  var collision = move_and_collide(velocity * delta)
  
  # Se colidir, calcula o "quique" e perde vida
  if collision:
   direction = direction.bounce(collision.get_normal())
   vida -= 1
   
 # Morte
 if vida <= 0:
  queue_free()

func dano_troca():
 await get_tree().create_timer(10).timeout
 
 # Previne erro caso o inimigo tenha morrido durante os 10 segundos de espera
 if not is_inside_tree():
  return 
  
 move = false
 
 # Loop de tiros
 for i in 5:
  # CORREÇÃO: Instancia o tiro DENTRO do loop para criar 3 tiros diferentes
  var _i_tiro = tiro.instantiate()
  _i_tiro.speed+=10
  add_child(_i_tiro) 
  
  # DICA: Normalmente é bom definir a posição do tiro aqui. Exemplo:
  # _i_tiro.global_position = self.global_position
  
  await get_tree().create_timer(1).timeout
  
  # Verifica novamente se o inimigo não foi destruído durante a pausa do tiro
  if not is_inside_tree():
   return
   
 move = true
 a = true
 
 # CORREÇÃO: Sorteia novos valores e atualiza o vetor de direção
 var new_d1 = randf_range(-1, 1)
 var new_d2 = randf_range(-1, 1)
 direction = Vector2(new_d1, new_d2).normalized()
