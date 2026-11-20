/// @description Draw Event - Crystal Sorcerer dengan Sigil & Peluru Sihir

// 1. Bayangan Kaki
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(10, 8, 20));
draw_ellipse(x - 14, y - 4, x + 14, y + 4, false);
draw_set_alpha(1.0);

// 2. Sigil Kristal Berputar Saat Merapal
if (state == "attack") {
    var _sig_r = 18 + sin(anim_timer * 6) * 3;
    draw_set_alpha(0.6);
    draw_set_color(make_color_rgb(220, 60, 255));
    draw_ellipse(x - _sig_r, y - 6, x + _sig_r, y + 6, true);
    draw_ellipse(x - _sig_r * 0.6, y - 4, x + _sig_r * 0.6, y + 4, true);
    draw_set_alpha(1.0);
}

// 3. Render Sprite Utama (Flash saat terkena serangan)
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// 4. Render Peluru Sihir Kristal
for (var _p = 0; _p < array_length(spells); _p++) {
    var _sp = spells[_p];
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(230, 80, 255));
    draw_circle(_sp.xx, _sp.yy, _sp.radius, false);
    draw_set_color(make_color_rgb(255, 230, 255));
    draw_circle(_sp.xx, _sp.yy, _sp.radius * 0.5, false);
    draw_set_alpha(1.0);
}

// 5. HP Bar Mini di Atas Kepala
if (hp < max_hp && hp > 0) {
    var _bw = 32;
    var _bh = 4;
    var _bx = x - _bw / 2;
    var _by = y - 60;
    
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(15, 18, 30));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    
    var _pct = clamp(hp / max_hp, 0, 1.0);
    draw_set_color(make_color_rgb(140, 60, 255));
    draw_rectangle(_bx, _by, _bx + (_bw * _pct), _by + _bh, false);
    
    draw_set_color(make_color_rgb(200, 150, 255));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
    draw_set_alpha(1.0);
}
