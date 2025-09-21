if place_meeting(x,y,obj_flecha){

if global.dano_p=true{
global.dano_p=false
global.vida--
alarm[0]=room_speed*1.5
instance_destroy(obj_flecha)
}}
