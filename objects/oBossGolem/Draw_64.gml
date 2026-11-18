/// @description Draw GUI Event - Cinematic Boss Health Bar & Dual-Stage Status

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _bw = 560;
var _bh = 22;
var _bx = (_gw - _bw) / 2;
var _by = _gh - 58;

var _is_s2 = (variable_instance_exists(id, "boss_stage") && boss_stage == 2);
var _anim_t = variable_instance_exists(id, "anim_timer") ? anim_timer : 0;

// 1. Boss Background Plate
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(18, 14, 26));
draw_roundrect_ext(_bx - 12, _by - 32, _bx + _bw + 12, _by + _bh + 10, 14, 14, false);

// Glow Border (Ungu-Merah pada Tahap 2, Emas/Cyan pada Tahap 1)
draw_set_alpha(0.95);
if (_is_s2) {
    draw_set_color(make_color_rgb(220, 40, 140));
} else if (variable_instance_exists(id, "runic_barrier") && runic_barrier) {
    draw_set_color(make_color_rgb(80, 180, 255));
} else {
    draw_set_color(make_color_rgb(240, 190, 70));
}
draw_roundrect_ext(_bx - 12, _by - 32, _bx + _bw + 12, _by + _bh + 10, 14, 14, true);

// 2. Boss Title & Status
draw_set_alpha(1.0);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if (_is_s2) {
    draw_set_color(make_color_rgb(255, 90, 140));
    draw_text(_gw / 2, _by - 28, "⚡ " + enemy_name + " - [ PLOT TWIST: WUJUD SEJATI ] ⚡");
} else {
    if (variable_instance_exists(id, "runic_barrier") && runic_barrier) {
        draw_set_color(make_color_rgb(130, 220, 255));
        draw_text(_gw / 2, _by - 28, "🛡️ " + enemy_name + " [ BARRIER RUNIC KEBAL SIHIR ] 🛡️");
    } else {
        draw_set_color(make_color_rgb(255, 230, 120));
        draw_text(_gw / 2, _by - 28, "⚔ " + enemy_name + " [ BARRIER PECAH: TERHUYUNG! ] ⚔");
    }
}

// 3. HP Bar Track Background
draw_set_color(make_color_rgb(38, 14, 24));
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);

// 4. HP Fill
var _fill_w = max(0, (_bw * (hp / max_hp)));
if (_is_s2) {
    draw_set_color(make_color_rgb(180, 30, 120));
} else {
    draw_set_color(make_color_rgb(220, 45, 55));
}
draw_rectangle(_bx, _by, _bx + _fill_w, _by + _bh, false);

// HP Highlight
draw_set_color(_is_s2 ? make_color_rgb(255, 120, 200) : make_color_rgb(255, 140, 120));
draw_rectangle(_bx, _by, _bx + _fill_w, _by + 4, false);

// HP Outline
draw_set_color(make_color_rgb(240, 200, 90));
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);

// 5. HP Numeric Text
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_gw / 2, _by + _bh / 2, string(hp) + " / " + string(max_hp));

draw_set_halign(fa_left);
draw_set_valign(fa_top);
