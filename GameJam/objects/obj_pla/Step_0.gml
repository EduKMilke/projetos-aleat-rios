if global.vida<=0{
{
	if b=1{
global.oito=false
sprite_index=spr_pla_M
alarm[3]=room_speed*1.9
	b=0
	}
}
}
if global.vida>0{
if global.anda_p=true{
movex=keyboard_check(ord("D"))-keyboard_check(ord("A"))
movey=keyboard_check(ord("S"))-keyboard_check(ord("W"))
spdx=spd*movex
spdy=spd*movey
#region move spr
if movex!=0{
image_xscale=movex*-1
sprite_index=spr_plaL
}
if movey<0{

sprite_index=spr_plaC
}
if movey>0{

sprite_index=spr_plaF_A
}
if a==1{
if movey==0 and movex==0{
alarm[0]=room_speed*0.2
a=0
}}
if global.dano_p=false{
if movex!=0{
image_xscale=movex*-1
sprite_index=spr_plaL_1
}
if movey<0{

sprite_index=spr_plaC_1
}
if movey>0{

sprite_index=spr_plaF_A_1
}
}
#endregion

if (place_meeting(x+spdx,y,obj_pare)){
while !place_meeting(x+sign(spdx),y,obj_pare){
x+=sign(spdx)
}
spdx=0
}
if (place_meeting(x,y+spdy,obj_pare)){
while !place_meeting(x,y+sign(spdy),obj_pare){
y+=sign(spdy)
}
spdy=0
}
if (place_meeting(x+spdx,y,obj_cerca)){
while !place_meeting(x+sign(spdx),y,obj_cerca){
x+=sign(spdx)
}
spdx=0
}
if (place_meeting(x,y+spdy,obj_cerca)){
while !place_meeting(x,y+sign(spdy),obj_cerca){
y+=sign(spdy)
}
spdy=0
}
if (place_meeting(x+spdx,y,obj_porta)) and obj_porta.porta=false{
while !place_meeting(x+sign(spdx),y,obj_porta){
x+=sign(spdx)
}
spdx=0
}
if (place_meeting(x,y+spdy,obj_porta)) and obj_porta.porta=false{
while !place_meeting(x,y+sign(spdy),obj_porta){
y+=sign(spdy)
}
spdy=0
}

y+=spdy
x+=spdx

}


if place_meeting(x,y,obj_tdano) or place_meeting(x,y,obj_flecha_b){
if global.dano_p=true{
global.dano_p=false
global.vida--
alarm[1]=room_speed*1.5}}

if global.atira=true and keyboard_check(vk_space){
if tiro=true{
tiro=false
alarm[4]=room_speed*1.5
instance_create_layer(x,y,"Instances",obj_flecha)
}

}
}

