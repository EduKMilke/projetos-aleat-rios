if instance_exists(obj_porta){
if place_meeting(x,y,obj_flecha){
obj_porta.porta=true
instance_destroy(obj_flecha)
}

}
if place_meeting(x,y,obj_volta){

vspeed*=-1
}