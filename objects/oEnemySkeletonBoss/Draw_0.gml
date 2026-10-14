/// @description Draw Event - Render Skeleton Warlord dengan Aura Gelap & HP Bar Mini-Boss

// Aura merah menyala di bawah kaki
draw_set_alpha(0.35 + sin(anim_timer * 2) * 0.15);
draw_set_color(make_color_rgb(180, 20, 20));
draw_circle(x, y + 8, 22, false);
draw_set_alpha(1.0);

// Gambar sprite boss
event_inherited();

// Mini-Boss Health Bar di atas kepala
if (hp < max_hp) {
    var _bw = 54;
    var _bh = 6;
    var _bx = x - _bw / 2;
    var _by = y - 48;
    
    draw_set_color(make_color_rgb(30, 10, 10));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    
    var _fill = max(0, (_bw * (hp / max_hp)));
    draw_set_color(make_color_rgb(220, 40, 40));
    draw_rectangle(_bx, _by, _bx + _fill, _by + _bh, false);
    
    draw_set_color(make_color_rgb(255, 200, 80));
    draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(x, _by - 12, enemy_name);
}
