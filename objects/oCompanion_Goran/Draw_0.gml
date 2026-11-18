/// @description Draw Event - Render Goran Companion, Shadow & Status Plate

// 1. Bayangan Karakter
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 14, y + 10, x + 14, y + 18, false);
draw_set_alpha(1.0);

// 2. Gambar Sprite Tempur Goran
draw_self();

// 3. Mini Health Bar di Ruangan Tempur
var _in_combat_room = (room == rm_outskirts || room == rm_catacombs || room == rm_boss_chamber);
if (_in_combat_room) {
    var _bar_w = 44;
    var _bar_h = 5;
    var _bar_x = x - _bar_w / 2;
    var _bar_y = y - 55;
    
    // Background bar
    draw_set_color(make_color_rgb(30, 30, 40));
    draw_rectangle(_bar_x - 1, _bar_y - 1, _bar_x + _bar_w + 1, _bar_y + _bar_h + 1, false);
    
    // Fill bar
    var _pct = clamp(hp / max_hp, 0.0, 1.0);
    draw_set_color(_pct > 0.4 ? make_color_rgb(80, 220, 120) : make_color_rgb(240, 80, 70));
    draw_rectangle(_bar_x, _bar_y, _bar_x + (_bar_w * _pct), _bar_y + _bar_h, false);
    
    // Label teks
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(220, 230, 245));
    draw_text(x, _bar_y - 3, "Goran [Party]");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// 4. Prompt Interaksi [E]
if (is_player_near) {
    var _py = y - 48 + sin(prompt_anim) * 3;
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(20, 25, 38));
    draw_roundrect_ext(x - 48, _py - 10, x + 48, _py + 8, 8, 8, false);
    draw_set_color(make_color_rgb(180, 140, 70));
    draw_roundrect_ext(x - 48, _py - 10, x + 48, _py + 8, 8, 8, true);
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, _py - 1, "[E] Bicara dgn Goran");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_color(c_white);
draw_set_alpha(1.0);

