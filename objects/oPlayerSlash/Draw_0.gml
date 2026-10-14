/// @description Draw Event - Efek Visual Arc Tebasan Pedang Kombo

var _progress = (max_life - life_timer) / max_life;
var _alpha = 1.0 - _progress;

draw_set_alpha(_alpha * 0.95);

if (combo_index == 1) {
    // KOMBO 1: Tebasan Cepat Perak-Biru Langit (Quick Silver Slash)
    var _arc_start = slash_dir - 50 + (_progress * 25);
    var _arc_end   = slash_dir + 50 + (_progress * 25);
    var _radius    = 34 + (_progress * 14);

    draw_set_color(make_color_rgb(180, 230, 255));
    for (var _a = _arc_start; _a <= _arc_end; _a += 6) {
        var _r1 = degtorad(_a);
        var _r2 = degtorad(_a + 6);
        draw_line_width(x + cos(_r1) * (_radius - 6), y - sin(_r1) * (_radius - 6), x + cos(_r2) * _radius, y - sin(_r2) * _radius, 4);
    }
    draw_set_color(c_white);
    for (var _a = _arc_start; _a <= _arc_end; _a += 12) {
        var _r = degtorad(_a);
        draw_circle(x + cos(_r) * _radius, y - sin(_r) * _radius, 2.5, false);
    }
} else if (combo_index == 2) {
    // KOMBO 2: Tebasan Berat Emas Berbara (Golden Amber Cleave)
    var _arc_start = slash_dir - 65 + (_progress * 30);
    var _arc_end   = slash_dir + 65 + (_progress * 30);
    var _radius    = 42 + (_progress * 16);

    draw_set_color(make_color_rgb(255, 175, 40));
    for (var _a = _arc_start; _a <= _arc_end; _a += 5) {
        var _r1 = degtorad(_a);
        var _r2 = degtorad(_a + 5);
        draw_line_width(x + cos(_r1) * (_radius - 10), y - sin(_r1) * (_radius - 10), x + cos(_r2) * _radius, y - sin(_r2) * _radius, 6);
    }
    draw_set_color(make_color_rgb(255, 240, 150));
    for (var _a = _arc_start; _a <= _arc_end; _a += 8) {
        var _r = degtorad(_a);
        draw_circle(x + cos(_r) * _radius, y - sin(_r) * _radius, 3, false);
    }
} else {
    // KOMBO 3: Putaran 360 Derajat Badai Runic (Celestial 360 Spin Finisher)
    var _spin_rad = 48 + (_progress * 22);
    
    // Gelombang Kejut 360 Derajat Luar
    draw_set_color(make_color_rgb(130, 240, 255));
    draw_circle(x, y, _spin_rad, true);
    draw_circle(x, y, _spin_rad - 4, true);
    
    // Sinar Pedang Runic Memutar
    for (var _s = 0; _s < 8; _s++) {
        var _srad = degtorad(_s * 45 + _progress * 180);
        draw_set_color(make_color_rgb(255, 235, 120));
        draw_line_width(x, y, x + cos(_srad) * _spin_rad, y - sin(_srad) * _spin_rad, 3);
        draw_set_color(c_white);
        draw_circle(x + cos(_srad) * _spin_rad, y - sin(_srad) * _spin_rad, 3.5, false);
    }
}

// Render Sprite Tebasan Pedang Mana Seed
var _sub = clamp(floor(_progress * 4), 0, 3);
var _col_slash = (combo_index == 1) ? make_color_rgb(180, 230, 255) : ((combo_index == 2) ? make_color_rgb(255, 190, 70) : make_color_rgb(130, 240, 255));
draw_sprite_ext(sPlayerSlash, _sub, x, y, 1.25, 1.25, slash_dir - 90, _col_slash, _alpha);

draw_set_alpha(1.0);
draw_set_color(c_white);

