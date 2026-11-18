/// @description Draw Event oNPC_Sister_Bed (Adik Sestrina Terbaring di Ranjang Blacksmith Workshop)

var _head_x = 340;
var _head_y = 240;
var _breath = sin(current_time * 0.003) * 1.5;
var _mana_t = current_time * 0.005;
var _pulse = sin(_mana_t);

// =========================================================================
// 1. FIGUR ADIK SESTRINA TERBARING DI BANTAL (White Hair Anime Sleeping Sprite)
// =========================================================================
// Bayangan Kepala di Bantal
draw_set_alpha(0.25);
draw_set_color(make_color_rgb(25, 20, 25));
draw_ellipse(_head_x - 12, _head_y + 4, _head_x + 12, _head_y + 14, false);

// Rambut Putih Mengembang di Atas Bantal (Elena's White Hair)
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(240, 245, 255));
draw_ellipse(_head_x - 13, _head_y - 6 + _breath, _head_x + 13, _head_y + 10 + _breath, false);
draw_set_color(make_color_rgb(220, 228, 245));
draw_circle(_head_x - 10, _head_y + 2 + _breath, 5, false);
draw_circle(_head_x + 10, _head_y + 2 + _breath, 5, false);

// Wajah Mungil Sestrina
draw_set_color(make_color_rgb(255, 228, 218));
draw_ellipse(_head_x - 9, _head_y - 3 + _breath, _head_x + 9, _head_y + 8 + _breath, false);

// Pipi Merah Merona (Sweet Pink Blush)
draw_set_color(make_color_rgb(255, 170, 185));
draw_circle(_head_x - 5, _head_y + 3 + _breath, 2, false);
draw_circle(_head_x + 5, _head_y + 3 + _breath, 2, false);

// Mata Tertidur Rileks (- _ -)
draw_set_color(make_color_rgb(70, 50, 65));
draw_line_width(_head_x - 6, _head_y + 1 + _breath, _head_x - 2, _head_y + 2 + _breath, 1.5);
draw_line_width(_head_x + 2, _head_y + 2 + _breath, _head_x + 6, _head_y + 1 + _breath, 1.5);

// Senyum Tenang Tidur
draw_set_color(make_color_rgb(180, 85, 95));
draw_line(_head_x - 2, _head_y + 5 + _breath, _head_x + 2, _head_y + 5 + _breath);

// Kerah Baju Tidur Putih & Tangan Mungil
draw_set_color(make_color_rgb(250, 250, 255));
draw_rectangle(_head_x - 8, _head_y + 9 + _breath, _head_x + 8, _head_y + 13 + _breath, false);
draw_set_color(make_color_rgb(255, 228, 218));
draw_circle(_head_x - 6, _head_y + 13 + _breath, 2, false);
draw_circle(_head_x + 6, _head_y + 13 + _breath, 2, false);

// =========================================================================
// 2. KEBOCORAN MANA AURA (Overclock Mana Leak - Instabilitas Cyan/Purple)
// =========================================================================
var _chest_x = _head_x;
var _chest_y = _head_y + 14;

draw_set_alpha(0.30 + 0.12 * sin(_mana_t * 1.5));
draw_set_color(make_color_rgb(90, 225, 255));
draw_circle(_chest_x, _chest_y + _breath, 12 + _pulse * 2.5, false);

draw_set_alpha(0.35 + 0.15 * cos(_mana_t * 2.0));
draw_set_color(make_color_rgb(200, 130, 255));
draw_circle(_chest_x, _chest_y + _breath, 7 + cos(_mana_t * 1.2) * 1.5, false);

// Partikel Kristal Mana Melayang Naik dari Dada
for (var i = 0; i < 3; i++) {
    var _poff_x = sin(_mana_t * 2.0 + i * 2.0) * 10;
    var _poff_y = -((current_time * 0.03 + i * 14) mod 32);
    var _p_alpha = max(0, 1.0 - abs(_poff_y) / 32.0);
    draw_set_alpha(_p_alpha * 0.7);
    draw_set_color((i mod 2 == 0) ? make_color_rgb(120, 245, 255) : make_color_rgb(225, 160, 255));
    draw_circle(_chest_x + _poff_x, _chest_y + _poff_y, 1.8, false);
}

// =========================================================================
// 3. GLOWING INTERACT RING [O] DI SEKITAR RANJANG
// =========================================================================
draw_set_alpha(0.40 + 0.20 * _pulse);
draw_set_color(make_color_rgb(255, 235, 140));
draw_ellipse(_head_x - 22, _head_y + 15 + _breath, _head_x + 22, _head_y + 45 + _breath, true);

// =========================================================================
// 4. STORY BUBBLE INDICATOR DI ATAS RANJANG
// =========================================================================
if (global.quest_stage == 0 || global.player_has_remedy) {
    var _sb_y = _head_y - 42 + sin(current_time * 0.005) * 3;
    draw_set_alpha(0.95);
    draw_set_color(c_white);
    draw_roundrect_ext(_head_x - 22, _sb_y - 10, _head_x + 22, _sb_y + 4, 8, 8, false);
    draw_set_color(make_color_rgb(70, 110, 190));
    draw_roundrect_ext(_head_x - 22, _sb_y - 10, _head_x + 22, _sb_y + 4, 8, 8, true);
    
    // Bubble pointer
    draw_set_color(c_white);
    draw_triangle(_head_x - 3, _sb_y + 4, _head_x + 3, _sb_y + 4, _head_x, _sb_y + 8, false);
    
    draw_set_color(make_color_rgb(30, 45, 90));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_head_x, _sb_y - 3, "Story");
}

// =========================================================================
// 5. PARTIKEL NAFAS LELAP (z Z Z)
// =========================================================================
var _zz_alpha = 0.55 + 0.35 * sin(prompt_anim * 2.2);
draw_set_alpha(_zz_alpha);
draw_set_color(make_color_rgb(180, 220, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_head_x + 14, _head_y - 14, "z");
draw_set_color(make_color_rgb(220, 240, 255));
draw_text(_head_x + 20, _head_y - 21, "Z");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 6. Floating prompt [E]
event_inherited();
