if (!surface_exists(surf)){
surf=surface_create(room_width,room_height)
}else{
surface_set_target(surf)
draw_clear_alpha(c_black,0.5)
gpu_set_blendmode(bm_subtract)
with (obj_tocha) {
    var _rluz = random_range(-0.05, 0.01);
    draw_sprite_ext(spr_tdano, 0, x, y, 1 + _rluz, 1 + _rluz, 0, c_white, 1);
}

with (obj_ltocha) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}
with (obj_pla_m) {
    var _rluz = random_range(-0.05, 0.01);
    draw_sprite_ext(spr_tdano, 0, x, y, 0.5 + _rluz, 0.5 + _rluz, 0, c_aqua, 1);
}

with (obj_pla_m) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface(surf,0,0)
}