/// @description Draw Event - Crystal Aegis Knight dengan Bayangan & HP Bar

// 1. Bayangan Kaki Elips Transparan
draw_set_alpha(0.4);
draw_set_color(make_color_rgb(10, 8, 20));
draw_ellipse(x - 16, y - 4, x + 16, y + 4, false);
draw_set_alpha(1.0);

// 2. Aura Kristal Ungu Halus
draw_set_alpha(0.18 + sin(anim_timer * 3) * 0.08);
draw_set_color(make_color_rgb(170, 75, 255));
draw_ellipse(x - 20, y - 35, x + 20, y, false);
draw_set_alpha(1.0);

// 3. Render Sprite Utama (Flash saat terkena pukulan)
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// 4. Efek Sinar Pedang Menjelang Tebasan
if (state == "attack" && image_index < 1.5) {
    var _sw_dir = (image_xscale < 0) ? -1 : 1;
    draw_set_alpha(0.7);
    draw_set_color(make_color_rgb(255, 140, 255));
    draw_line_width(x + _sw_dir * 10, y - 40, x + _sw_dir * 38, y - 10, 2.5);
    draw_set_alpha(1.0);
}

// 5. HP Bar Mini di Atas Kepala
if (hp < max_hp && hp > 0) {
    var _bw = 36;
    var _bh = 4;
    var _bx = x - _bw / 2;
    var _by = y - 65;
    
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(15, 18, 30));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    
    var _pct = clamp(hp / max_hp, 0, 1.0);
    draw_set_color(make_color_rgb(180, 50, 240));
    draw_rectangle(_bx, _by, _bx + (_bw * _pct), _by + _bh, false);
    
    draw_set_color(make_color_rgb(220, 150, 255));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
    draw_set_alpha(1.0);
}
