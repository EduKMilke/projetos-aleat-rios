#region mendigo
draw_set_font(fonte)
if instance_exists(obj_mendigo) and obj_mendigo.dialogo=true{
if _dialo_mend=true{
global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>7{
instance_create_layer(850,78,"Instances",obj_mendigo2)
_dialo_mend=false
n_dialogo=0
global.anda_p=true
}
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_mend[n_dialogo])
}
}

if instance_exists(obj_mendigo2) and obj_mendigo2.dialogo=true{
	if _dialo_mend2=true{
global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}

if n_dialogo>8{
if global.vida<3{
dialogo_mend2=["","Deve estar se perguntado 'você não ficaria para trás?'","A resposta é sim no entanto eu já estou aqui a muito tempo e já vi muitas pessoas perdendo a vida","Eu queria te testar, se você não passase desse desafio fácil nem adianta nada", "E quem sera que colocou as tochas?","EU","Enfim...","Apartir daqui não explorei e não vou, não tenho poção para isso nem jovialidade","Agora esta por conta própia","Na verdade espere","Eu não tenho nada a perder e acredito que você consiga chegar no final","Então tome minha única poção e minha vida junto"]
if n_dialogo>11{
global.vida++
_dialo_mend2=false
n_dialogo=0
morte_m=true

}
	}else{
_dialo_mend2=false
n_dialogo=0
global.anda_p=true
	}
}

draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_mend2[n_dialogo])

}}
#endregion
if instance_exists(obj_placa_a) and obj_placa_a.dialogo=true{

global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>2{
n_dialogo=0
global.anda_p=true
obj_placa_a.dialogo=false
}
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_placa[n_dialogo])

}
if instance_exists(obj_placa_b) and obj_placa_b.dialogo=true{

global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>2{
n_dialogo=0
global.anda_p=true
obj_placa_b.dialogo=false
}
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_placa2[n_dialogo])

}
if instance_exists(obj_placa_c) and obj_placa_c.dialogo=true{

global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>3{
n_dialogo=0
global.anda_p=true
obj_placa_c.dialogo=false
}
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_placa3[n_dialogo])

}
	if instance_exists(obj_bau) and obj_bau.dialogo=true{

global.anda_p=false
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>2{
obj_bau.sprite_index=Sprite36_1
}
if n_dialogo>5{
alarm[0]=room_speed*1
obj_bau.dialogo=false
layer_sequence_create("luz",room_width/2,room_height/2,"seq_1")
n_dialogo=0

}
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_bau[n_dialogo])

}
if room=r_6{
if keyboard_check_pressed(vk_enter){
n_dialogo++
}
if n_dialogo>3{
alarm[1]=room_speed*1
a=false
layer_sequence_create("luz",room_width/2,room_height/2,"seq_1")
n_dialogo=0

}else{
	if a=true{
draw_sprite(spr_caixad,0,0,670)
draw_text(30,650,dialogo_fim[n_dialogo])
	}
}
}
