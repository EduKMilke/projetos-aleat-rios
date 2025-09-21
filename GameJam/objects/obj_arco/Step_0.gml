
y=y+sin(a*0.05)*0.5
a++
if place_meeting(x,y,obj_pla){
global.atira=true
instance_destroy(self)
}