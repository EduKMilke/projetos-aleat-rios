if (!surface_exists(surf)){
surf=surface_create(room_width,room_height)
}else{
surface_set_target(surf)
draw_clear_alpha(c_black,0.5)
gpu_set_blendmode(bm_subtract)
with (obj_tocha) {
    var _rluz = random_range(-0.05, 0.05); // tremulação leve
    draw_sprite_ext(spr_ltocha, 0, x, y, 2.5 + _rluz, 2.5 + _rluz, 0, c_white, 1);
}

// (Opcional) luzes de outras fontes
with (obj_ltocha) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}

gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface(surf,0,0)
}