/// @description Draw GUI Event - Boss HP Bar

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _bw = 500;
var _bh = 22;
var _bx = (_gw - _bw) / 2;
var _by = _gh - 54;

// Boss Frame
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(25, 20, 30));
draw_roundrect_ext(_bx - 8, _by - 26, _bx + _bw + 8, _by + _bh + 8, 12, 12, false);
draw_set_color(make_color_rgb(220, 175, 60));
draw_roundrect_ext(_bx - 8, _by - 26, _bx + _bw + 8, _by + _bh + 8, 12, 12, true);

// Boss Name
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(255, 220, 120));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_gw / 2, _by - 22, "⚔ " + enemy_name + " - Penjaga Bunga Abadi ⚔");

// HP Background
draw_set_color(make_color_rgb(50, 15, 25));
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);

// HP Fill
var _fill_w = max(0, (_bw * (hp / max_hp)));
draw_set_color(make_color_rgb(220, 40, 50));
draw_rectangle(_bx, _by, _bx + _fill_w, _by + _bh, false);

// HP Highlight
draw_set_color(make_color_rgb(255, 120, 130));
draw_rectangle(_bx, _by, _bx + _fill_w, _by + 4, false);

// HP Outline
draw_set_color(make_color_rgb(240, 200, 90));
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
