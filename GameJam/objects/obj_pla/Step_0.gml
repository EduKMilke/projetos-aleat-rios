movex=keyboard_check(ord("D"))-keyboard_check(ord("A"))
movey=keyboard_check(ord("S"))-keyboard_check(ord("W"))
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

spdx=spd*movex
spdy=spd*movey
if (place_meeting(x+sign(spdx)*1,y,obj_pare)){
spdx=0
}
if (place_meeting(x,y+sign(spdy)*spd,obj_pare)){
spdy=0
}

y+=spdy
x+=spdx