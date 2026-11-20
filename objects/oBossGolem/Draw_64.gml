/// @description Draw GUI Event - Epic Dark Crystal Overlord Health Bar

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _bar_w = 560;
var _bar_h = 16;
var _bar_x = (_gw - _bar_w) / 2;
var _bar_y = 38;

var _is_s2 = (variable_instance_exists(id, "boss_stage") && boss_stage == 2);
var _anim_t = variable_instance_exists(id, "anim_timer") ? anim_timer : 0;

// 1. Boss Name Card Header
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(16, 12, 24));
draw_roundrect_ext(_bar_x + 110, _bar_y - 25, _bar_x + _bar_w - 110, _bar_y - 3, 6, 6, false);

// Glow Border Header
draw_set_alpha(0.95);
if (_is_s2) {
    draw_set_color(make_color_rgb(255, 60, 140));
} else if (variable_instance_exists(id, "runic_barrier") && runic_barrier) {
    draw_set_color(make_color_rgb(180, 110, 255));
} else {
    draw_set_color(make_color_rgb(255, 215, 80));
}
draw_roundrect_ext(_bar_x + 110, _bar_y - 25, _bar_x + _bar_w - 110, _bar_y - 3, 6, 6, true);

// Header Text
draw_set_alpha(1.0);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 235, 255));

if (_is_s2) {
    draw_text(_gw / 2, _bar_y - 14, "⚡ " + enemy_name + " [ WUJUD SEJATI ] ⚡");
} else {
    draw_text(_gw / 2, _bar_y - 14, "☠ DARK CRYSTAL OVERLORD ☠");
}

// 2. HP Bar Background & Frame
draw_set_color(make_color_rgb(8, 6, 12));
draw_roundrect_ext(_bar_x - 4, _bar_y - 4, _bar_x + _bar_w + 4, _bar_y + _bar_h + 4, 6, 6, false);

// Frame Border
if (_is_s2) {
    draw_set_color(make_color_rgb(220, 40, 130));
} else {
    draw_set_color(make_color_rgb(180, 120, 240));
}
draw_roundrect_ext(_bar_x - 4, _bar_y - 4, _bar_x + _bar_w + 4, _bar_y + _bar_h + 4, 6, 6, true);

// HP Track Background
draw_set_color(make_color_rgb(30, 14, 40));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);

// 3. HP Fill Gradient
var _hp_pct = clamp(hp / max_hp, 0, 1);
var _fill_w = _bar_w * _hp_pct;

if (_fill_w > 0) {
    if (_is_s2) {
        draw_set_color(make_color_rgb(210, 30, 90));
        draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + _bar_h, false);
        draw_set_color(make_color_rgb(255, 120, 160));
        draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + 4, false);
    } else {
        draw_set_color(make_color_rgb(190, 45, 130));
        draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + _bar_h, false);
        draw_set_color(make_color_rgb(255, 130, 200));
        draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + 4, false);
    }
}

// 4. Subtitle Tag di Bawah Bar
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(200, 180, 220));

if (_is_s2) {
    draw_text(_gw / 2, _bar_y + _bar_h + 6, "[ PLOT TWIST: ROH TERKUTUK SUAKA PURBA ]");
} else {
    if (variable_instance_exists(id, "runic_barrier") && runic_barrier) {
        draw_set_color(make_color_rgb(170, 210, 255));
        draw_text(_gw / 2, _bar_y + _bar_h + 6, "[ RUNIC BARRIER AKTIF: TEBAS MELEE UNTUK MEMECAHKAN PERISAI ]");
    } else {
        draw_set_color(make_color_rgb(255, 230, 120));
        draw_text(_gw / 2, _bar_y + _bar_h + 6, "[ BARRIER PECAH: CRITICAL DAMAGE 1.5x! ]");
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
