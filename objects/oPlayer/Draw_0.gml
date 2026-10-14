/// @description Draw Event - Render Karakter Pemain & Bayangan

// 1. Gambar Ghost Trail saat Dodge Roll
for (var _i = 0; _i < array_length(ghost_trail); _i++) {
    var _g = ghost_trail[_i];
    draw_set_alpha(_g.alpha * 0.5);
    gpu_set_fog(true, make_color_rgb(130, 220, 255), 0, 0);
    draw_sprite_ext(_g.spr, _g.sub, _g.xx, _g.yy, _g.xsc, _g.ysc, 0, c_white, _g.alpha * 0.5);
    gpu_set_fog(false, c_white, 0, 0);
}

// 2. Bayangan Kaki Pemain (Grounded Drop Shadow)
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 10, y + 10, x + 10, y + 18, false);
draw_set_alpha(1.0);

// 3. Efek Shimmer / I-Frames saat Menghindar
if (invincible_timer > 0 && (invincible_timer mod 4 < 2)) {
    draw_set_alpha(0.65);
} else {
    draw_set_alpha(1.0);
}

// Gambar Sprite Utama Pemain (Skala 2.3x)
draw_self();
draw_set_alpha(1.0);

// Sarung Pedang Baja di Pinggang jika Memiliki Pedang
if (variable_global_exists("player_has_sword") && global.player_has_sword) {
    var _sword_x = (image_xscale < 0) ? x + 8 : x - 8;
    var _sword_y = y + 2;
    
    draw_set_color(make_color_rgb(110, 60, 30)); // Sarung kulit
    draw_line_width(_sword_x, _sword_y, _sword_x - sign(image_xscale) * 4, _sword_y + 12, 3);
    draw_set_color(make_color_rgb(220, 185, 75)); // Gagang emas
    draw_circle(_sword_x, _sword_y - 2, 2, false);
}

draw_set_color(c_white);

