if (instance_exists(obj_pla)){

alvo=obj_pla

}
x=lerp(x,alvo.x,0.1)
y=lerp(y,alvo.y,0.1)
var _l_cam=camera_get_view_width(view_camera[0])
var _al_cam=camera_get_view_width(view_camera[0])
var _cam_x =x -_l_cam/2
var _cam_y =y- _al_cam/3
camera_set_view_pos(view_camera[0],_cam_x,_cam_y)