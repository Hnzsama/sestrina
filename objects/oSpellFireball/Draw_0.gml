/// @description Draw Event - Render Efek Visual Bola Api & Detonasi Ledakan Spektakuler

if (!is_exploded) {
    // =========================================================================
    // 1. FASE TERBANG: PARTIKEL JEJAK & INTI BOLA API
    // =========================================================================
    // Gambar partikel jejak ekor api yang memudar
    for (var _i = 0; _i < array_length(trail_sparks); _i++) {
        var _sp = trail_sparks[_i];
        draw_set_alpha(_sp.alpha);
        draw_set_color(_sp.col);
        draw_circle(_sp.xx, _sp.yy, _sp.radius, false);
    }
    
    // Pendaran Cahaya Api Hangat (Outer Ambient Glow)
    var _pulse = sin(current_time * 0.02) * 2.0;
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(255, 90, 20));
    draw_circle(x, y, 16 + _pulse, false);
    
    // Bentuk Ekor Peluru Api (Tear-drop flame)
    var _tail_x = x - lengthdir_x(12, fire_dir);
    var _tail_y = y - lengthdir_y(12, fire_dir);
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(255, 60, 20));
    draw_circle(_tail_x, _tail_y, 6.5, false);
    
    // Lapisan Api Sedang (Fiery Orange Core)
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(255, 140, 30));
    draw_circle(x, y, 8.5, false);
    
    // Inti Plasma Panas Putih-Kuning (Bright White-Hot Plasma Center)
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 245, 150));
    draw_circle(x, y, 5.0, false);
    draw_set_color(c_white);
    draw_circle(x, y, 2.5, false);

} else {
    // =========================================================================
    // 2. FASE DETONASI LEDAKAN: SHOCKWAVE, BOLA API MEMBUNCAH & SERPIHAN EMBER
    // =========================================================================
    var _prog = (explode_max_timer - explode_timer) / explode_max_timer; // 0.0 -> 1.0
    var _current_r = explode_radius * power(_prog, 0.7); // Ekspansi cepat di awal
    
    // Gelombang Kejut Luar (Shockwave Blast Wave)
    draw_set_alpha((1.0 - _prog) * 0.75);
    draw_set_color(make_color_rgb(255, 180, 60));
    draw_circle(x, y, _current_r, true);
    draw_set_color(make_color_rgb(255, 90, 20));
    draw_circle(x, y, max(1, _current_r - 2), true);
    
    // Bola Api Ledakan Membuncah (Expanding Fireball Sphere)
    draw_set_alpha((1.0 - _prog) * 0.65);
    draw_set_color(make_color_rgb(255, 70, 20));
    draw_circle(x, y, _current_r * 0.85, false);
    
    draw_set_alpha((1.0 - _prog) * 0.85);
    draw_set_color(make_color_rgb(255, 160, 35));
    draw_circle(x, y, _current_r * 0.6, false);
    
    // Kilatan Inti Putih Terang pada Awal Detonasi
    if (_prog < 0.35) {
        var _flash_alpha = (1.0 - (_prog / 0.35));
        draw_set_alpha(_flash_alpha);
        draw_set_color(c_white);
        draw_circle(x, y, _current_r * 0.4, false);
    }
    
    // Serpihan Api & Percikan Ledakan Membuncah (Burst Sparks)
    for (var _b = 0; _b < array_length(burst_sparks); _b++) {
        var _bs = burst_sparks[_b];
        draw_set_alpha(_bs.alpha);
        draw_set_color(_bs.col);
        draw_circle(_bs.xx, _bs.yy, _bs.radius, false);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);
