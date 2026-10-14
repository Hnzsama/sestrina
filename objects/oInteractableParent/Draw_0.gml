/// @description Draw Event oInteractableParent

if (sprite_exists(sprite_index)) {
    draw_self();
}

// Gambar floating prompt icon jika player sedang dekat
if (is_player_near && !global.dialogue_active && prompt_text != "") {
    var _float_y = y + prompt_y_offset + sin(prompt_anim) * 3;
    var _w = string_width(prompt_text) + 16;
    var _h = 18;
    var _x1 = x - _w / 2;
    var _y1 = _float_y - _h / 2;
    var _x2 = x + _w / 2;
    var _y2 = _float_y + _h / 2;
    
    // Background bubble
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(20, 24, 34));
    draw_roundrect_ext(_x1, _y1, _x2, _y2, 6, 6, false);
    
    // Border bubble
    draw_set_color(make_color_rgb(255, 215, 0));
    draw_roundrect_ext(_x1, _y1, _x2, _y2, 6, 6, true);
    
    // Text prompt
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, _float_y, prompt_text);
    
    // Reset draw properties
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
