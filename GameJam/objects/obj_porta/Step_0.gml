if room=r_1{
	sprite_index=spr_porta
if place_meeting(x,y,obj_pla){
if a=1{
layer_sequence_create("luz",room_width/2,room_height/2,"seq_1")
alarm[0]=room_speed*1.2
a=0
}
obj_pla.x=x
}}
if room=r_2{
	sprite_index=spr_porta2
	if porta=true{	sprite_index=spr_porta}
if place_meeting(x,y,obj_pla){
	
if porta=true{

if a=1{
layer_sequence_create("luz",room_width/2,room_height/2,"seq_1")
alarm[1]=room_speed*1.2
a=0
}
obj_pla.x=x
	}
}}
if room=r_3{
	sprite_index=spr_porta2
	if porta=true{	sprite_index=spr_porta}
if place_meeting(x,y,obj_pla){
	
if porta=true{

if a=1{
layer_sequence_create("luz",room_width/2,room_height/2,"seq_1")
alarm[2]=room_speed*1.2
a=0
}
obj_pla.x=x
	}
}}