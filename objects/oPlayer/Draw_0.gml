/// @description Draw Event - Render Karakter Pemain & Bayangan

// 1. Gambar Ghost Trail saat Dodge Roll
for (var _i = 0; _i < array_length(ghost_trail); _i++) {
    var _g = ghost_trail[_i];
    draw_set_alpha(_g.alpha * 0.5);
    gpu_set_fog(true, make_color_rgb(130, 220, 255), 0, 0);
    draw_sprite_ext(_g.spr, _g.sub, _g.xx, _g.yy, _g.xsc, _g.ysc, 0, c_white, _g.alpha * 0.5);
    gpu_set_fog(false, c_white, 0, 0);
}

// 2. Bayangan Kaki Pemain (Grounded Drop Shadow di Origin Kaki)
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y - 4, x + 12, y + 4, false);
draw_set_alpha(1.0);

// 3. Efek Aura Visual Aksi Khusus
// A. Aura Kilau Ramuan Pemulih Hijau-Emas saat Minum [C]
if (is_drinking > 0) {
    var _drink_prog = 1.0 - (is_drinking / 24);
    var _aura_rad = 14 + sin(_drink_prog * pi) * 10;
    
    draw_set_alpha(0.35 * sin(_drink_prog * pi));
    draw_set_color(make_color_rgb(90, 240, 120));
    draw_circle(x, y - 20, _aura_rad, false);
    
    draw_set_color(make_color_rgb(255, 240, 130));
    draw_circle(x, y - 20, _aura_rad * 0.65, true);
    
    // Partikel kilau naik ke atas
    for (var _p = 0; _p < 3; _p++) {
        var _px = x + sin(current_time * 0.01 + _p * 2) * 12;
        var _py = y - 10 - ((_drink_prog * 30 + _p * 8) mod 32);
        draw_set_color(c_white);
        draw_circle(_px, _py, 1.8, false);
    }
    draw_set_alpha(1.0);
}

// B. Aura Sihir Elemen saat Merapal Mantra [X]
if (is_casting > 0) {
    var _cast_prog = 1.0 - (is_casting / 20);
    var _pulse = sin(_cast_prog * pi);
    
    draw_set_alpha(0.4 * _pulse);
    if (cast_type == 1) {
        // Aura Api Membara
        draw_set_color(make_color_rgb(255, 110, 40));
        draw_circle(x, y - 22, 16 + _pulse * 8, false);
        draw_set_color(make_color_rgb(255, 235, 100));
        draw_circle(x, y - 22, 10 + _pulse * 5, true);
    } else {
        // Aura Es Runic
        draw_set_color(make_color_rgb(90, 200, 255));
        draw_circle(x, y - 22, 16 + _pulse * 8, false);
        draw_set_color(make_color_rgb(220, 245, 255));
        draw_circle(x, y - 22, 10 + _pulse * 5, true);
    }
    draw_set_alpha(1.0);
}

// 4. Efek Shimmer / I-Frames saat Menghindar atau Terkena Serangan
if (invincible_timer > 0 && (invincible_timer mod 4 < 2)) {
    draw_set_alpha(0.65);
} else {
    draw_set_alpha(1.0);
}

// 5. Gambar Karakter Utama (Animasi Resolusi Tinggi dari Sestrina Pack)
draw_self();

draw_set_alpha(1.0);
draw_set_color(c_white);

