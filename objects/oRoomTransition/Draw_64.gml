/// @description Draw GUI Event - JRPG Deep Indigo Glass HUD, Day/Night Badge, Quest Tracker & Menus (Reference UI)

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// =========================================================================
// 0. DAY / NIGHT HUD BADGE (Pojok Kiri Atas - Reference: importantNPCdialog.png & night outdoor bar.png)
// =========================================================================
var _dn_x = 24;
var _dn_y = 12;
var _dn_w = 210;
var _dn_h = 34;

var _day_num = variable_global_exists("day_count") ? global.day_count : 1;
var _time_str = variable_global_exists("time_of_day") ? global.time_of_day : "Daytime";
var _is_day = (_time_str == "Daytime");

// Background Hexagonal/Pill Badge Translucent Indigo
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(22, 34, 65));
draw_roundrect_ext(_dn_x, _dn_y, _dn_x + _dn_w, _dn_y + _dn_h, 16, 16, false);

// Double Glowing Lavender / Cyan Border
draw_set_alpha(0.95);
draw_set_color(_is_day ? make_color_rgb(90, 170, 255) : make_color_rgb(150, 130, 240));
draw_roundrect_ext(_dn_x, _dn_y, _dn_x + _dn_w, _dn_y + _dn_h, 16, 16, true);
draw_set_color(make_color_rgb(45, 65, 120));
draw_roundrect_ext(_dn_x + 2, _dn_y + 2, _dn_x + _dn_w - 2, _dn_y + _dn_h - 2, 14, 14, true);

// Teks Waktu (Day X - Daytime / Nighttime)
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_dn_x + 14, _dn_y + _dn_h / 2, "Day " + string(_day_num) + " - " + _time_str);

// Ikon Matahari (Daytime) atau Bulan Sabit (Nighttime) di Kanan Badge
var _icon_x = _dn_x + _dn_w - 22;
var _icon_y = _dn_y + _dn_h / 2;

if (_is_day) {
    // Matahari Oranye Bersinar
    draw_set_color(make_color_rgb(255, 140, 40));
    draw_circle(_icon_x, _icon_y, 7, false);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_circle(_icon_x, _icon_y, 4.5, false);
    // Sinar Matahari
    for (var _ray = 0; _ray < 8; _ray++) {
        var _rad = degtorad(_ray * 45);
        draw_line_width(_icon_x + cos(_rad) * 9, _icon_y + sin(_rad) * 9, _icon_x + cos(_rad) * 12, _icon_y + sin(_rad) * 12, 1.5);
    }
} else {
    // Bulan Sabit Emas Glowing
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_circle(_icon_x, _icon_y, 8, false);
    draw_set_color(make_color_rgb(22, 34, 65));
    draw_circle(_icon_x - 3.5, _icon_y - 2, 6.5, false);
}

// =========================================================================
// 0.5. QUICK SAVE, LOAD & JENDELA SLOTS BADGE (Pojok Kiri Atas - Sebelah Waktu)
// =========================================================================
var _sv_x = _dn_x + _dn_w + 12;
var _sv_y = _dn_y;
var _sv_h = _dn_h;

var _gmx = device_mouse_x_to_gui(0);
var _gmy = device_mouse_y_to_gui(0);

var _hov_save  = (_gmx >= _sv_x && _gmx < _sv_x + 92 && _gmy >= _sv_y && _gmy <= _sv_y + _sv_h);
var _hov_load  = (_gmx >= _sv_x + 96 && _gmx < _sv_x + 192 && _gmy >= _sv_y && _gmy <= _sv_y + _sv_h);
var _hov_slots = (_gmx >= _sv_x + 196 && _gmx <= _sv_x + 300 && _gmy >= _sv_y && _gmy <= _sv_y + _sv_h);

// 1. Tombol: [F5] Save
draw_set_alpha(0.92);
draw_set_color(_hov_save ? make_color_rgb(38, 55, 95) : make_color_rgb(22, 34, 65));
draw_roundrect_ext(_sv_x, _sv_y, _sv_x + 92, _sv_y + _sv_h, 12, 12, false);
draw_set_color(_hov_save ? make_color_rgb(120, 220, 160) : make_color_rgb(75, 120, 195));
draw_roundrect_ext(_sv_x, _sv_y, _sv_x + 92, _sv_y + _sv_h, 12, 12, true);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_sv_x + 46, _sv_y + _sv_h / 2, "💾 [F5]");

// 2. Tombol: [F6] Load
draw_set_alpha(0.92);
draw_set_color(_hov_load ? make_color_rgb(38, 55, 95) : make_color_rgb(22, 34, 65));
draw_roundrect_ext(_sv_x + 96, _sv_y, _sv_x + 192, _sv_y + _sv_h, 12, 12, false);
draw_set_color(_hov_load ? make_color_rgb(255, 210, 100) : make_color_rgb(75, 120, 195));
draw_roundrect_ext(_sv_x + 96, _sv_y, _sv_x + 192, _sv_y + _sv_h, 12, 12, true);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_text(_sv_x + 96 + 48, _sv_y + _sv_h / 2, "📂 [F6]");

// 3. Tombol: [F7] Slots
var _is_slots_open = (variable_global_exists("save_menu_open") && global.save_menu_open);
draw_set_alpha(0.92);
draw_set_color(_is_slots_open ? make_color_rgb(50, 80, 145) : (_hov_slots ? make_color_rgb(38, 55, 95) : make_color_rgb(22, 34, 65)));
draw_roundrect_ext(_sv_x + 196, _sv_y, _sv_x + 300, _sv_y + _sv_h, 12, 12, false);
draw_set_color(_is_slots_open ? make_color_rgb(255, 220, 120) : (_hov_slots ? make_color_rgb(170, 200, 255) : make_color_rgb(75, 120, 195)));
draw_roundrect_ext(_sv_x + 196, _sv_y, _sv_x + 300, _sv_y + _sv_h, 12, 12, true);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_text(_sv_x + 196 + 52, _sv_y + _sv_h / 2, "🗂️ [F7] Slots");

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// =========================================================================
// 1. JRPG CHARACTER STATUS PLATE (Deep Indigo Glass - Clean HUD 420x120)
// =========================================================================
var _hud_x = 24;
var _hud_y = 52;
var _hud_w = 448;
var _hud_h = 120;

// Background Plate Deep Translucent Indigo
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(20, 26, 46));
draw_roundrect_ext(_hud_x, _hud_y, _hud_x + _hud_w, _hud_y + _hud_h, 14, 14, false);

// Double Neon Lavender Glow Border & Diamond Corners
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(135, 160, 245));
draw_roundrect_ext(_hud_x, _hud_y, _hud_x + _hud_w, _hud_y + _hud_h, 14, 14, true);
draw_set_color(make_color_rgb(55, 75, 135));
draw_roundrect_ext(_hud_x + 2, _hud_y + 2, _hud_x + _hud_w - 2, _hud_y + _hud_h - 2, 12, 12, true);

// Diamond Corner Accents
var _draw_corner_diamond = function(_dx, _dy) {
    draw_set_color(make_color_rgb(180, 210, 255));
    draw_triangle(_dx - 3, _dy, _dx, _dy - 3, _dx + 3, _dy, false);
    draw_triangle(_dx - 3, _dy, _dx, _dy + 3, _dx + 3, _dy, false);
};
_draw_corner_diamond(_hud_x + 6, _hud_y + 6);
_draw_corner_diamond(_hud_x + _hud_w - 6, _hud_y + 6);
_draw_corner_diamond(_hud_x + 6, _hud_y + _hud_h - 6);
_draw_corner_diamond(_hud_x + _hud_w - 6, _hud_y + _hud_h - 6);

// --- Row 1: Level Badge, Gold Badge, Status Menu [P] Button ---
var _r1_y = _hud_y + 14;

// Level Badge Pill
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(34, 44, 78));
draw_roundrect_ext(_hud_x + 10, _r1_y - 6, _hud_x + 102, _r1_y + 11, 6, 6, false);
draw_set_color(make_color_rgb(140, 175, 255));
draw_roundrect_ext(_hud_x + 10, _r1_y - 6, _hud_x + 102, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
draw_sprite_ext(sUiIcons, 8, _hud_x + 14, _r1_y - 8, 0.5, 0.5, 0, c_white, 1.0);
draw_set_color(make_color_rgb(220, 235, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_hud_x + 62, _r1_y + 2, "Lv " + string(global.player_level));

// Gold Badge Pill
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(48, 40, 22));
draw_roundrect_ext(_hud_x + 110, _r1_y - 6, _hud_x + 225, _r1_y + 11, 6, 6, false);
draw_set_color(make_color_rgb(240, 190, 65));
draw_roundrect_ext(_hud_x + 110, _r1_y - 6, _hud_x + 225, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
draw_sprite_ext(sUiIcons, 6, _hud_x + 116, _r1_y - 8, 0.5, 0.5, 0, c_white, 1.0);
draw_set_color(make_color_rgb(255, 220, 85));
draw_set_halign(fa_center);
draw_text(_hud_x + 172, _r1_y + 2, string(global.gold) + " G");

// Status Menu [P] Badge Button (Interactive Shield Icon & Points Alert)
draw_set_alpha(0.9);
var _pts = variable_global_exists("stat_points") ? global.stat_points : 0;
var _gui_mx = device_mouse_x_to_gui(0);
var _gui_my = device_mouse_y_to_gui(0);
var _p_btn_x1 = _hud_x + _hud_w - 145;
var _p_btn_x2 = _hud_x + _hud_w - 10;
var _p_hover = (_gui_mx >= _p_btn_x1 && _gui_mx <= _p_btn_x2 && _gui_my >= _r1_y - 6 && _gui_my <= _r1_y + 11);

var _pcol = (_pts > 0) ? make_color_rgb(180, 50, 40) : (_p_hover ? make_color_rgb(42, 60, 105) : make_color_rgb(28, 42, 75));
draw_set_color(_pcol);
draw_roundrect_ext(_p_btn_x1, _r1_y - 6, _p_btn_x2, _r1_y + 11, 6, 6, false);
draw_set_color((_pts > 0) ? make_color_rgb(255, 160, 100) : (_p_hover ? make_color_rgb(180, 215, 255) : make_color_rgb(110, 160, 255)));
draw_roundrect_ext(_p_btn_x1, _r1_y - 6, _p_btn_x2, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
// Gunakan ikon Crest/Shield (index 5) jika tidak ada poin, atau sparkle (index 9) jika ada poin
draw_sprite_ext(sUiIcons, (_pts > 0 ? 9 : 5), _p_btn_x1 + 8, _r1_y - 8, 0.5, 0.5, 0, c_white, 1.0);
draw_set_color((_pts > 0) ? make_color_rgb(255, 240, 180) : make_color_rgb(205, 230, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_p_btn_x1 + 75, _r1_y + 2, (_pts > 0) ? "[P] +" + string(_pts) + " Poin!" : "[P] Status");

// --- Parameter Bar Setup (Harmonious Width to eliminate floating void) ---
var _bar_x = _hud_x + 32;
var _bar_w = 328;
var _bar_h = 8;
var _text_x = _hud_x + _hud_w - 12;

// --- Row 2: Health Bar (HP) dengan Icon Hati Pixel Asli ---
var _r2_y = _hud_y + 32;
draw_sprite_ext(sUiIcons, 0, _hud_x + 10, _r2_y - 4, 0.5, 0.5, 0, c_white, 1.0);

draw_set_color(make_color_rgb(42, 18, 22));
draw_rectangle(_bar_x, _r2_y, _bar_x + _bar_w, _r2_y + _bar_h, false);

var _fill_hp = max(0, (_bar_w * (global.player_hp / global.player_max_hp)));
draw_set_color(make_color_rgb(235, 65, 65));
draw_rectangle(_bar_x, _r2_y, _bar_x + _fill_hp, _r2_y + _bar_h, false);
draw_set_color(make_color_rgb(255, 160, 150));
draw_rectangle(_bar_x, _r2_y, _bar_x + _fill_hp, _r2_y + 2, false);

draw_set_color(make_color_rgb(180, 75, 75));
draw_rectangle(_bar_x, _r2_y, _bar_x + _bar_w, _r2_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(_text_x, _r2_y + _bar_h / 2, string(round(global.player_hp)) + "/" + string(round(global.player_max_hp)));

// --- Row 3: Mana Bar (MP) dengan Icon Kristal Mana Asli ---
var _r3_y = _hud_y + 46;
draw_sprite_ext(sUiIcons, 1, _hud_x + 10, _r3_y - 4, 0.5, 0.5, 0, c_white, 1.0);

draw_set_color(make_color_rgb(15, 30, 55));
draw_rectangle(_bar_x, _r3_y, _bar_x + _bar_w, _r3_y + _bar_h, false);

var _fill_mp = max(0, (_bar_w * (global.player_mp / global.player_max_mp)));
draw_set_color(make_color_rgb(50, 175, 255));
draw_rectangle(_bar_x, _r3_y, _bar_x + _fill_mp, _r3_y + _bar_h, false);
draw_set_color(make_color_rgb(140, 225, 255));
draw_rectangle(_bar_x, _r3_y, _bar_x + _fill_mp, _r3_y + 2, false);

draw_set_color(make_color_rgb(120, 190, 255));
draw_rectangle(_bar_x, _r3_y, _bar_x + _bar_w, _r3_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(_text_x, _r3_y + _bar_h / 2, string(round(global.player_mp)) + "/" + string(round(global.player_max_mp)));

// --- Row 4: Stamina / TP Bar (SP) dengan Icon Sepatu Sayap Asli ---
var _r4_y = _hud_y + 60;
draw_sprite_ext(sUiIcons, 4, _hud_x + 10, _r4_y - 4, 0.5, 0.5, 0, c_white, 1.0);

draw_set_color(make_color_rgb(15, 40, 28));
draw_rectangle(_bar_x, _r4_y, _bar_x + _bar_w, _r4_y + _bar_h, false);

var _cur_sp = variable_global_exists("player_stamina") ? global.player_stamina : 100;
var _max_sp = variable_global_exists("player_max_stamina") ? global.player_max_stamina : 100;
var _fill_sp = max(0, (_bar_w * (_cur_sp / _max_sp)));
draw_set_color(make_color_rgb(45, 205, 120));
draw_rectangle(_bar_x, _r4_y, _bar_x + _fill_sp, _r4_y + _bar_h, false);
draw_set_color(make_color_rgb(150, 255, 195));
draw_rectangle(_bar_x, _r4_y, _bar_x + _fill_sp, _r4_y + 2, false);

draw_set_color(make_color_rgb(120, 220, 160));
draw_rectangle(_bar_x, _r4_y, _bar_x + _bar_w, _r4_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(_text_x, _r4_y + _bar_h / 2, string(round(_cur_sp)) + "/" + string(round(_max_sp)));

// --- Row 5: Experience Bar (XP) dengan Icon Bintang Asli ---
var _r5_y = _hud_y + 74;
draw_sprite_ext(sUiIcons, 8, _hud_x + 10, _r5_y - 4, 0.5, 0.5, 0, c_white, 1.0);

draw_set_color(make_color_rgb(32, 22, 50));
draw_rectangle(_bar_x, _r5_y, _bar_x + _bar_w, _r5_y + 6, false);

var _fill_exp = max(0, (_bar_w * (global.player_exp / global.player_max_exp)));
draw_set_color(make_color_rgb(165, 110, 245));
draw_rectangle(_bar_x, _r5_y, _bar_x + _fill_exp, _r5_y + 6, false);
draw_set_color(make_color_rgb(210, 180, 255));
draw_rectangle(_bar_x, _r5_y, _bar_x + _bar_w, _r5_y + 6, true);

draw_set_color(make_color_rgb(220, 210, 240));
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(_text_x, _r5_y + 3, string(round(global.player_exp)) + "/" + string(round(global.player_max_exp)));

// --- Row 6: 4 Quick-Action Slots (Ringkas, Proporsional, Anti-Overflow) ---
var _r6_y = _hud_y + 88;
var _chip_w = 101;
var _chip_h = 24;
var _chip_gap = 8;

// Chip 1: Ramuan [C]
var _c1_x = _hud_x + 10;
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(20, 42, 35));
draw_roundrect_ext(_c1_x, _r6_y, _c1_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(make_color_rgb(70, 190, 130));
draw_roundrect_ext(_c1_x, _r6_y, _c1_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);

draw_set_color(make_color_rgb(110, 240, 170));
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_c1_x + 8, _r6_y + _chip_h / 2, "[C]");
draw_sprite_ext(sUiIcons, 7, _c1_x + 38, _r6_y + 4, 0.5, 0.5, 0, c_white, 1.0);
draw_set_color(make_color_rgb(220, 255, 230));
draw_text(_c1_x + 60, _r6_y + _chip_h / 2, "x" + string(global.player_potions));

// Chip 2: Serangan [Z]
var _c2_x = _c1_x + _chip_w + _chip_gap;
draw_set_alpha(0.9);

var _cstep = (instance_exists(oPlayer)) ? oPlayer.combo_step : 0;
var _atk_tag = "ATK";
if (_cstep == 2) _atk_tag = "K2";
if (_cstep == 3) _atk_tag = "FIN!";

var _atk_bg = (_cstep == 3) ? make_color_rgb(65, 30, 15) : make_color_rgb(40, 34, 20);
var _atk_bd = (_cstep == 3) ? make_color_rgb(255, 130, 45) : make_color_rgb(240, 190, 70);
var _atk_fg = (_cstep == 3) ? make_color_rgb(255, 220, 130) : make_color_rgb(255, 225, 120);

if (!global.player_has_sword) {
    _atk_bg = make_color_rgb(24, 30, 48);
    _atk_bd = make_color_rgb(80, 105, 150);
    _atk_fg = make_color_rgb(160, 185, 225);
    _atk_tag = "ATK";
}

draw_set_color(_atk_bg);
draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(_atk_bd);
draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);

draw_set_color(_atk_fg);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_c2_x + 8, _r6_y + _chip_h / 2, "[Z]");
draw_sprite_ext(sUiIcons, 3, _c2_x + 38, _r6_y + 4, 0.5, 0.5, 0, c_white, 1.0);
draw_set_color(_atk_fg);
draw_text(_c2_x + 60, _r6_y + _chip_h / 2, _atk_tag);

// Chip 3: Roll [Shift]
var _c3_x = _c2_x + _chip_w + _chip_gap;
var _can_roll = (_cur_sp >= 25);
draw_set_alpha(0.9);
draw_set_color(_can_roll ? make_color_rgb(20, 40, 68) : make_color_rgb(28, 32, 42));
draw_roundrect_ext(_c3_x, _r6_y, _c3_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(_can_roll ? make_color_rgb(85, 170, 245) : make_color_rgb(70, 80, 100));
draw_roundrect_ext(_c3_x, _r6_y, _c3_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);

draw_sprite_ext(sUiIcons, 4, _c3_x + 8, _r6_y + 4, 0.5, 0.5, 0, _can_roll ? c_white : c_dkgray, 1.0);
draw_set_color(_can_roll ? make_color_rgb(180, 230, 255) : make_color_rgb(110, 120, 135));
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_c3_x + 30, _r6_y + _chip_h / 2, "[Shift]");

// Chip 4: Sihir [X]
var _c4_x = _c3_x + _chip_w + _chip_gap;
draw_set_alpha(0.9);

var _sp_tag = "--";
var _sp_icon = 10;
var _sp_bg = make_color_rgb(22, 28, 44);
var _sp_bd = make_color_rgb(70, 90, 130);
var _sp_fg = make_color_rgb(130, 150, 185);

if (global.spell_selected == 1) {
    _sp_tag = "Api";
    _sp_icon = 11;
    _sp_bg = make_color_rgb(55, 25, 16);
    _sp_bd = make_color_rgb(255, 120, 50);
    _sp_fg = make_color_rgb(255, 215, 140);
} else if (global.spell_selected == 2) {
    _sp_tag = "Es";
    _sp_icon = 12;
    _sp_bg = make_color_rgb(18, 42, 68);
    _sp_bd = make_color_rgb(80, 190, 250);
    _sp_fg = make_color_rgb(180, 235, 255);
}

draw_set_color(_sp_bg);
draw_roundrect_ext(_c4_x, _r6_y, _c4_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(_sp_bd);
draw_roundrect_ext(_c4_x, _r6_y, _c4_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);

draw_set_color(_sp_fg);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_c4_x + 8, _r6_y + _chip_h / 2, "[X]");
draw_sprite_ext(sUiIcons, _sp_icon, _c4_x + 36, _r6_y + 4, 0.5, 0.5, 0, (global.spell_selected > 0) ? c_white : c_dkgray, 1.0);
draw_set_color(_sp_fg);
draw_text(_c4_x + 58, _r6_y + _chip_h / 2, _sp_tag);



// =========================================================================
// 2. JRPG QUEST SCROLL PLATE (Deep Indigo Glass - Kanan Atas 380x106)
// =========================================================================
if (variable_global_exists("quest_title")) {
    var _qw = 380;
    var _qh = 106;
    var _qx = _gw - _qw - 24;
    var _qy = 16;

    // Background Scroll Deep Indigo Glass
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(20, 26, 46));
    draw_roundrect_ext(_qx, _qy, _qx + _qw, _qy + _qh, 14, 14, false);

    // Glowing Lavender Border
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(135, 160, 245));
    draw_roundrect_ext(_qx, _qy, _qx + _qw, _qy + _qh, 14, 14, true);
    draw_set_color(make_color_rgb(55, 75, 135));
    draw_roundrect_ext(_qx + 2, _qy + 2, _qx + _qw - 2, _qy + _qh - 2, 12, 12, true);

    _draw_corner_diamond(_qx + 6, _qy + 6);
    _draw_corner_diamond(_qx + _qw - 6, _qy + 6);
    _draw_corner_diamond(_qx + 6, _qy + _qh - 6);
    _draw_corner_diamond(_qx + _qw - 6, _qy + _qh - 6);

    // Header Pill: Quest Utama
    var _qr1_y = _qy + 14;
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(45, 38, 22));
    draw_roundrect_ext(_qx + 10, _qr1_y - 6, _qx + 140, _qr1_y + 11, 6, 6, false);
    draw_set_color(make_color_rgb(240, 195, 70));
    draw_roundrect_ext(_qx + 10, _qr1_y - 6, _qx + 140, _qr1_y + 11, 6, 6, true);

    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 225, 100));
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(_qx + 16, _qr1_y + 2, "★ QUEST UTAMA");

    // Stage Pill Indicator (Kanan Atas)
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(28, 44, 75));
    draw_roundrect_ext(_qx + _qw - 95, _qr1_y - 6, _qx + _qw - 10, _qr1_y + 11, 6, 6, false);
    draw_set_color(make_color_rgb(110, 180, 255));
    draw_roundrect_ext(_qx + _qw - 95, _qr1_y - 6, _qx + _qw - 10, _qr1_y + 11, 6, 6, true);

    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(180, 230, 255));
    draw_set_halign(fa_center);
    draw_text(_qx + _qw - 52, _qr1_y + 2, "✦ Aktif");

    // Title Quest
    draw_set_color(make_color_rgb(255, 235, 160));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_qx + 12, _qy + 32, global.quest_title);

    // Subtext / Petunjuk Objektif Aktif
    draw_set_color(make_color_rgb(210, 225, 245));
    draw_text_ext(_qx + 12, _qy + 54, "▶ " + global.quest_desc, 16, _qw - 24);
}

// =========================================================================
// 3. ROOM LOCATION BANNER (Saat Masuk Ruangan Baru)
// =========================================================================
if (banner_timer > 0) {
    var _b_alpha = (banner_timer > 120) ? (160 - banner_timer) / 40 : ((banner_timer < 30) ? banner_timer / 30 : 1.0);
    var _bw = 500;
    var _bh = 58;
    var _bx = (_gw - _bw) / 2;
    var _by = 175;

    draw_set_alpha(_b_alpha * 0.94);
    draw_set_color(make_color_rgb(18, 24, 44));
    draw_roundrect_ext(_bx, _by, _bx + _bw, _by + _bh, 14, 14, false);
    draw_set_color(make_color_rgb(135, 160, 245));
    draw_roundrect_ext(_bx, _by, _bx + _bw, _by + _bh, 14, 14, true);

    draw_set_alpha(_b_alpha);
    draw_set_color(make_color_rgb(255, 225, 120));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_gw / 2, _by + 18, "✧ " + banner_title + " ✧");

    draw_set_color(make_color_rgb(205, 220, 245));
    draw_text(_gw / 2, _by + 40, banner_subtitle);
}

// =========================================================================
// 4. MODAL SHEET: STATUS JRPG & KELENGKAPAN KSATRIA [P] (Native Composition Pixel UI)
// =========================================================================
if (global.stat_menu_open) {
    var _gui_mx = device_mouse_x_to_gui(0);
    var _gui_my = device_mouse_y_to_gui(0);
    
    // Dim background overlay
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1.0);
    
    var _mw = 860;
    var _mh = 530;
    var _mx = round((_gw - _mw) / 2);
    var _my = round((_gh - _mh) / 2);
    
    // -------------------------------------------------------------------------
    // 1. WINDOW FRAME NATIVE (Deep Indigo Glass 16-bit JRPG)
    // -------------------------------------------------------------------------
    // Panel Utama
    draw_set_color(make_color_rgb(14, 20, 36));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, false);
    // Double Glowing Border Emas & Navy
    draw_set_color(make_color_rgb(65, 105, 180));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, true);
    draw_set_color(make_color_rgb(28, 42, 75));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 14, 14, true);
    
    // Header Banner Judul
    var _ban_x = _mx + 30;
    var _ban_y = _my + 14;
    var _ban_w = _mw - 100;
    var _ban_h = 36;
    draw_set_color(make_color_rgb(22, 32, 60));
    draw_roundrect_ext(_ban_x, _ban_y, _ban_x + _ban_w, _ban_y + _ban_h, 8, 8, false);
    draw_set_color(make_color_rgb(215, 175, 75));
    draw_roundrect_ext(_ban_x, _ban_y, _ban_x + _ban_w, _ban_y + _ban_h, 8, 8, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 230, 120));
    draw_text_transformed(_ban_x + _ban_w / 2, _ban_y + _ban_h / 2, "STATUS & KELENGKAPAN KSATRIA", 1.05, 1.05, 0);
    
    // Tombol Tutup [X] Merah di Kanan Atas
    var _btn_x_x = _mx + 806;
    var _btn_x_y = _my + 14;
    var _btn_x_w = 36;
    var _btn_x_h = 36;
    var _hov_close = (_gui_mx >= _btn_x_x && _gui_mx <= _btn_x_x + _btn_x_w && _gui_my >= _btn_x_y && _gui_my <= _btn_x_y + _btn_x_h);
    draw_set_color(_hov_close ? make_color_rgb(225, 55, 60) : make_color_rgb(160, 40, 45));
    draw_roundrect_ext(_btn_x_x, _btn_x_y, _btn_x_x + _btn_x_w, _btn_x_y + _btn_x_h, 8, 8, false);
    draw_set_color(make_color_rgb(255, 190, 190));
    draw_roundrect_ext(_btn_x_x, _btn_x_y, _btn_x_x + _btn_x_w, _btn_x_y + _btn_x_h, 8, 8, true);
    draw_set_color(c_white);
    draw_text_transformed(_btn_x_x + _btn_x_w / 2, _btn_x_y + _btn_x_h / 2, "X", 1.1, 1.1, 0);
    
    // -------------------------------------------------------------------------
    // 2. KOLOM 1: PROFIL & 3 BAR STATUS PENUH (Kiri, x: _c1_x)
    // -------------------------------------------------------------------------
    var _c1_x = _mx + 26;
    var _c1_y = _my + 65;
    var _c1_w = 216;
    
    // 2.1. Box Portrait Hero Sestrina (192x192) - Origin is (96, 96) Center!
    var _port_x = _c1_x + (_c1_w - 192) / 2;
    var _port_y = _c1_y;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_port_x - 3, _port_y - 3, _port_x + 195, _port_y + 195, 10, 10, false);
    draw_set_color(make_color_rgb(215, 175, 75));
    draw_roundrect_ext(_port_x - 3, _port_y - 3, _port_x + 195, _port_y + 195, 10, 10, true);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_port_x - 1, _port_y - 1, _port_x + 193, _port_y + 193, 8, 8, true);
    
    if (sprite_exists(sHeroPortrait)) {
        // Draw centered at _port_x + 96, _port_y + 96 using subimage 0 (Sestrina pixel art)
        draw_sprite(sHeroPortrait, 0, _port_x + 96, _port_y + 96);
    }
    
    // 2.2. Hero Info Card (Level, EXP & Gold)
    var _hcard_y = _port_y + 202;
    var _hcard_h = 56;
    draw_set_color(make_color_rgb(20, 28, 52));
    draw_roundrect_ext(_c1_x, _hcard_y, _c1_x + _c1_w, _hcard_y + _hcard_h, 8, 8, false);
    draw_set_color(make_color_rgb(60, 95, 160));
    draw_roundrect_ext(_c1_x, _hcard_y, _c1_x + _c1_w, _hcard_y + _hcard_h, 8, 8, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 230, 110));
    var _cur_lvl = variable_global_exists("player_level") ? global.player_level : 1;
    var _cur_exp = variable_global_exists("player_exp") ? global.player_exp : 0;
    var _max_exp = variable_global_exists("player_max_exp") ? global.player_max_exp : 60;
    draw_text_transformed(_c1_x + _c1_w / 2, _hcard_y + 18, "Lv." + string(_cur_lvl) + "   EXP: " + string(round(_cur_exp)) + "/" + string(round(_max_exp)), 0.82, 0.82, 0);
    
    var _cur_gold = variable_global_exists("gold") ? global.gold : 50;
    if (sprite_exists(sItemIcons)) {
        // sItemIcons origin is (12, 12)
        draw_sprite(sItemIcons, 5, _c1_x + 64, _hcard_y + 38);
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c1_x + 84, _hcard_y + 38, string(_cur_gold) + " Gold", 0.88, 0.88, 0);
    
    // 2.3. Bar Status HP, MP, dan Stamina (Proporsional & Sejajar)
    var _bar_rel_w = 162;
    var _bar_rel_h = 18;
    
    // Bar HP
    var _hp_y = _hcard_y + 68;
    draw_set_color(make_color_rgb(220, 50, 65));
    draw_roundrect_ext(_c1_x, _hp_y, _c1_x + 36, _hp_y + _bar_rel_h, 4, 4, false);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_c1_x + 18, _hp_y + _bar_rel_h / 2, "HP", 0.75, 0.75, 0);
    
    var _hp_rel_x = _c1_x + 42;
    draw_set_color(make_color_rgb(25, 28, 44));
    draw_rectangle(_hp_rel_x, _hp_y, _hp_rel_x + _bar_rel_w, _hp_y + _bar_rel_h, false);
    draw_set_color(make_color_rgb(60, 75, 110));
    draw_rectangle(_hp_rel_x, _hp_y, _hp_rel_x + _bar_rel_w, _hp_y + _bar_rel_h, true);
    
    var _hp_pct = clamp(global.player_hp / max(1, global.player_max_hp), 0, 1);
    var _hp_fill = round(_bar_rel_w * _hp_pct);
    if (_hp_fill > 0) {
        draw_set_color(make_color_rgb(235, 60, 75));
        draw_rectangle(_hp_rel_x + 1, _hp_y + 1, _hp_rel_x + _hp_fill - 1, _hp_y + _bar_rel_h - 1, false);
        draw_set_color(make_color_rgb(255, 140, 150));
        draw_line(_hp_rel_x + 1, _hp_y + 1, _hp_rel_x + _hp_fill - 1, _hp_y + 1);
    }
    draw_set_color(c_white);
    draw_text_transformed(_hp_rel_x + _bar_rel_w / 2, _hp_y + _bar_rel_h / 2, string(round(global.player_hp)) + " / " + string(round(global.player_max_hp)), 0.72, 0.72, 0);
    
    // Bar MP
    var _mp_y = _hp_y + 26;
    draw_set_color(make_color_rgb(30, 110, 190));
    draw_roundrect_ext(_c1_x, _mp_y, _c1_x + 36, _mp_y + _bar_rel_h, 4, 4, false);
    draw_set_color(c_white);
    draw_text_transformed(_c1_x + 18, _mp_y + _bar_rel_h / 2, "MP", 0.75, 0.75, 0);
    
    var _mp_rel_x = _c1_x + 42;
    draw_set_color(make_color_rgb(25, 28, 44));
    draw_rectangle(_mp_rel_x, _mp_y, _mp_rel_x + _bar_rel_w, _mp_y + _bar_rel_h, false);
    draw_set_color(make_color_rgb(60, 75, 110));
    draw_rectangle(_mp_rel_x, _mp_y, _mp_rel_x + _bar_rel_w, _mp_y + _bar_rel_h, true);
    
    var _mp_pct = clamp(global.player_mp / max(1, global.player_max_mp), 0, 1);
    var _mp_fill = round(_bar_rel_w * _mp_pct);
    if (_mp_fill > 0) {
        draw_set_color(make_color_rgb(45, 175, 245));
        draw_rectangle(_mp_rel_x + 1, _mp_y + 1, _mp_rel_x + _mp_fill - 1, _mp_y + _bar_rel_h - 1, false);
        draw_set_color(make_color_rgb(130, 225, 255));
        draw_line(_mp_rel_x + 1, _mp_y + 1, _mp_rel_x + _mp_fill - 1, _mp_y + 1);
    }
    draw_set_color(c_white);
    draw_text_transformed(_mp_rel_x + _bar_rel_w / 2, _mp_y + _bar_rel_h / 2, string(round(global.player_mp)) + " / " + string(round(global.player_max_mp)), 0.72, 0.72, 0);
    
    // Bar Stamina
    var _sta_y = _mp_y + 26;
    draw_set_color(make_color_rgb(35, 145, 80));
    draw_roundrect_ext(_c1_x, _sta_y, _c1_x + 36, _sta_y + _bar_rel_h, 4, 4, false);
    draw_set_color(c_white);
    draw_text_transformed(_c1_x + 18, _sta_y + _bar_rel_h / 2, "STA", 0.75, 0.75, 0);
    
    var _sta_rel_x = _c1_x + 42;
    draw_set_color(make_color_rgb(25, 28, 44));
    draw_rectangle(_sta_rel_x, _sta_y, _sta_rel_x + _bar_rel_w, _sta_y + _bar_rel_h, false);
    draw_set_color(make_color_rgb(60, 75, 110));
    draw_rectangle(_sta_rel_x, _sta_y, _sta_rel_x + _bar_rel_w, _sta_y + _bar_rel_h, true);
    
    var _sta_pct = clamp(global.player_stamina / max(1, global.player_max_stamina), 0, 1);
    var _sta_fill = round(_bar_rel_w * _sta_pct);
    if (_sta_fill > 0) {
        draw_set_color(make_color_rgb(50, 210, 120));
        draw_rectangle(_sta_rel_x + 1, _sta_y + 1, _sta_rel_x + _sta_fill - 1, _sta_y + _bar_rel_h - 1, false);
        draw_set_color(make_color_rgb(140, 250, 180));
        draw_line(_sta_rel_x + 1, _sta_y + 1, _sta_rel_x + _sta_fill - 1, _sta_y + 1);
    }
    draw_set_color(c_white);
    draw_text_transformed(_sta_rel_x + _bar_rel_w / 2, _sta_y + _bar_rel_h / 2, string(round(global.player_stamina)) + " / " + string(round(global.player_max_stamina)), 0.72, 0.72, 0);
    
    // -------------------------------------------------------------------------
    // 3. KOLOM 2: ATRIBUT KSATRIA & STATISTIK TEMPUR (Tengah, x: _c2_x)
    // -------------------------------------------------------------------------
    var _c2_x = _mx + 258;
    var _c2_y = _my + 65;
    var _c2_w = 306;
    
    // 3.1. Panel Atribut Ksatria
    var _attr_box_h = 246;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_c2_x, _c2_y, _c2_x + _c2_w, _c2_y + _attr_box_h, 10, 10, false);
    draw_set_color(make_color_rgb(50, 75, 130));
    draw_roundrect_ext(_c2_x, _c2_y, _c2_x + _c2_w, _c2_y + _attr_box_h, 10, 10, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c2_x + 16, _c2_y + 20, "-- ATRIBUT KSATRIA --", 0.85, 0.85, 0);
    
    var _has_pts = (variable_global_exists("stat_points") && global.stat_points > 0);
    draw_set_halign(fa_right);
    draw_set_color(_has_pts ? make_color_rgb(255, 230, 70) : make_color_rgb(160, 175, 205));
    draw_text_transformed(_c2_x + _c2_w - 16, _c2_y + 20, "Poin: " + string(global.stat_points), 0.85, 0.85, 0);
    
    draw_set_color(make_color_rgb(40, 58, 100));
    draw_line(_c2_x + 14, _c2_y + 36, _c2_x + _c2_w - 14, _c2_y + 36);
    
    // 4 Baris Atribut: VIT, STR, INT, AGI (LURUS & SEJAJAR 100%)
    var _attr_names = ["VIT (Vitalitas)", "STR (Kekuatan)", "INT (Kecerdasan)", "AGI (Kelincahan)"];
    var _attr_descs = ["+8 Max HP & Pertahanan Fisik", "+Daya Tebasan Pedang Fisik", "+8 Max MP & Daya Sihir", "+4 Max Stamina & Kecepatan"];
    var _attr_vals  = [global.stat_vit, global.stat_str, global.stat_int, global.stat_agi];
    
    var _ay_start = _c2_y + 60;
    var _ay_step  = 46;
    
    for (var _ai = 0; _ai < 4; _ai++) {
        var _row_y = _ay_start + _ai * _ay_step;
        
        // 1. Gambar Badge Sprite (sStatBadges origin is (16, 16) Center!)
        if (sprite_exists(sStatBadges)) {
            draw_sprite(sStatBadges, _ai, _c2_x + 30, _row_y);
        }
        
        // 2. Nama Atribut & Subteks
        draw_set_halign(fa_left);
        draw_set_valign(fa_bottom);
        draw_set_color(c_white);
        draw_text_transformed(_c2_x + 54, _row_y - 1, _attr_names[_ai], 0.85, 0.85, 0);
        draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(140, 160, 200));
        draw_text_transformed(_c2_x + 54, _row_y + 3, _attr_descs[_ai], 0.72, 0.72, 0);
        
        // 3. Nilai Atribut (Rata Kanan Presisi di _c2_x + 242)
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(255, 225, 90));
        draw_text_transformed(_c2_x + 242, _row_y, string(_attr_vals[_ai]), 0.95, 0.95, 0);
        
        // 4. Tombol [+]
        var _btn_plus_x = _c2_x + 254;
        var _btn_plus_y = _row_y - 13;
        var _btn_plus_size = 26;
        var _hov_plus = (_gui_mx >= _btn_plus_x && _gui_mx <= _btn_plus_x + _btn_plus_size && _gui_my >= _btn_plus_y && _gui_my <= _btn_plus_y + _btn_plus_size);
        
        draw_set_color(_has_pts ? (_hov_plus ? make_color_rgb(255, 210, 60) : make_color_rgb(180, 135, 40)) : make_color_rgb(45, 55, 80));
        draw_roundrect_ext(_btn_plus_x, _btn_plus_y, _btn_plus_x + _btn_plus_size, _btn_plus_y + _btn_plus_size, 6, 6, false);
        draw_set_color(_has_pts ? make_color_rgb(255, 240, 150) : make_color_rgb(70, 85, 120));
        draw_roundrect_ext(_btn_plus_x, _btn_plus_y, _btn_plus_x + _btn_plus_size, _btn_plus_y + _btn_plus_size, 6, 6, true);
        
        draw_set_color(_has_pts ? c_white : make_color_rgb(120, 130, 160));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(_btn_plus_x + _btn_plus_size / 2, _btn_plus_y + _btn_plus_size / 2, "+", 0.9, 0.9, 0);
    }
    
    // 3.2. Panel Statistik Tempur Efektif
    var _cbox_y = _c2_y + _attr_box_h + 12;
    var _cbox_h = 96;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_c2_x, _cbox_y, _c2_x + _c2_w, _cbox_y + _cbox_h, 10, 10, false);
    draw_set_color(make_color_rgb(50, 75, 130));
    draw_roundrect_ext(_c2_x, _cbox_y, _c2_x + _c2_w, _cbox_y + _cbox_h, 10, 10, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c2_x + 14, _cbox_y + 16, "Statistik Tempur Efektif:", 0.82, 0.82, 0);
    
    draw_set_color(make_color_rgb(40, 58, 100));
    draw_line(_c2_x + 14, _cbox_y + 28, _c2_x + _c2_w - 14, _cbox_y + 28);
    
    // Grid 2x2: sCombatIcons origin is (12, 12) Center!
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 0, _c2_x + 26, _cbox_y + 44);
    draw_set_color(c_white);
    draw_text_transformed(_c2_x + 44, _cbox_y + 44, "ATK: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(255, 230, 110));
    draw_text_transformed(_c2_x + 84, _cbox_y + 44, string(scr_get_player_atk()), 0.85, 0.85, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 1, _c2_x + 166, _cbox_y + 44);
    draw_set_color(c_white);
    draw_text_transformed(_c2_x + 184, _cbox_y + 44, "MATK: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(130, 215, 255));
    draw_text_transformed(_c2_x + 232, _cbox_y + 44, string(global.stat_int * 7), 0.85, 0.85, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 2, _c2_x + 26, _cbox_y + 72);
    draw_set_color(c_white);
    draw_text_transformed(_c2_x + 44, _cbox_y + 72, "Armor: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(200, 220, 245));
    draw_text_transformed(_c2_x + 96, _cbox_y + 72, string(global.stat_vit * 2), 0.85, 0.85, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 3, _c2_x + 166, _cbox_y + 72);
    draw_set_color(c_white);
    draw_text_transformed(_c2_x + 184, _cbox_y + 72, "Crit: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(255, 180, 220));
    draw_text_transformed(_c2_x + 224, _cbox_y + 72, string(5 + floor(global.stat_agi * 0.4)) + "%", 0.85, 0.85, 0);
    
    // -------------------------------------------------------------------------
    // 4. KOLOM 3: 3 SUB-PANEL MODULAR RAPI (Kanan, x: _c3_x)
    // -------------------------------------------------------------------------
    var _c3_x = _mx + 576;
    var _c3_y = _my + 65;
    var _c3_w = 260;
    
    // -------------------------------------------------------------------------
    // 4.1. SUB-PANEL 3A: PERLENGKAPAN (4 Slot 40x40)
    // -------------------------------------------------------------------------
    var _eq_box_h = 86;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_c3_x, _c3_y, _c3_x + _c3_w, _c3_y + _eq_box_h, 10, 10, false);
    draw_set_color(make_color_rgb(50, 75, 130));
    draw_roundrect_ext(_c3_x, _c3_y, _c3_x + _c3_w, _c3_y + _eq_box_h, 10, 10, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c3_x + 14, _c3_y + 16, "-- PERLENGKAPAN --", 0.82, 0.82, 0);
    
    draw_set_color(make_color_rgb(40, 58, 100));
    draw_line(_c3_x + 14, _c3_y + 28, _c3_x + _c3_w - 14, _c3_y + 28);
    
    // 4 Slot Perlengkapan: sEquipmentSlots origin is (20, 20) Center!
    var _slot_cy = _c3_y + 54;
    var _slot_step = 58;
    for (var _si = 0; _si < 4; _si++) {
        var _sx_c = _c3_x + 43 + _si * _slot_step;
        if (sprite_exists(sEquipmentSlots)) {
            draw_sprite(sEquipmentSlots, _si, _sx_c, _slot_cy);
        }
        // Efek Hover Highlight
        if (abs(_gui_mx - _sx_c) <= 20 && abs(_gui_my - _slot_cy) <= 20) {
            draw_set_color(make_color_rgb(255, 215, 80));
            draw_roundrect_ext(_sx_c - 20, _slot_cy - 20, _sx_c + 20, _slot_cy + 20, 6, 6, true);
        }
    }
    
    // -------------------------------------------------------------------------
    // 4.2. SUB-PANEL 3B: BAHAN TEMPA & KANTONG (Grid 2x3 Rapi)
    // -------------------------------------------------------------------------
    var _mat_box_y = _c3_y + 94;
    var _mat_box_h = 126;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_c3_x, _mat_box_y, _c3_x + _c3_w, _mat_box_y + _mat_box_h, 10, 10, false);
    draw_set_color(make_color_rgb(50, 75, 130));
    draw_roundrect_ext(_c3_x, _mat_box_y, _c3_x + _c3_w, _mat_box_y + _mat_box_h, 10, 10, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c3_x + 14, _mat_box_y + 16, "-- BAHAN TEMPA & KANTONG --", 0.82, 0.82, 0);
    
    draw_set_color(make_color_rgb(40, 58, 100));
    draw_line(_c3_x + 14, _mat_box_y + 28, _c3_x + _c3_w - 14, _mat_box_y + 28);
    
    var _cur_sj = variable_global_exists("mat_slime_jelly") ? global.mat_slime_jelly : 0;
    var _cur_bs = variable_global_exists("mat_bone_shard") ? global.mat_bone_shard : 0;
    var _cur_si = variable_global_exists("mat_scrap_iron") ? global.mat_scrap_iron : 0;
    var _cur_io = variable_global_exists("mat_iron_ore") ? global.mat_iron_ore : 0;
    var _cur_mc = variable_global_exists("mat_magic_crystal") ? global.mat_magic_crystal : 0;
    var _cur_pot = variable_global_exists("player_potions") ? global.player_potions : 1;
    
    // sItemIcons origin is (12, 12) Center!
    // Row 1: Slime & Bone
    var _my1 = _mat_box_y + 45;
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 0, _c3_x + 24, _my1);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 40, _my1, "Slime", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_text_transformed(_c3_x + 116, _my1, string(_cur_sj), 0.82, 0.82, 0);
    
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 3, _c3_x + 144, _my1);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 160, _my1, "Bone", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_text_transformed(_c3_x + 244, _my1, string(_cur_bs), 0.82, 0.82, 0);
    
    // Row 2: Scrap & Ore
    var _my2 = _mat_box_y + 73;
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 1, _c3_x + 24, _my2);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 40, _my2, "Scrap", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_text_transformed(_c3_x + 116, _my2, string(_cur_si), 0.82, 0.82, 0);
    
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 4, _c3_x + 144, _my2);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 160, _my2, "Ore", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_text_transformed(_c3_x + 244, _my2, string(_cur_io), 0.82, 0.82, 0);
    
    // Row 3: Crystal & Ramuan
    var _my3 = _mat_box_y + 101;
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 2, _c3_x + 24, _my3);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 40, _my3, "Crystal", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(255, 225, 90));
    draw_text_transformed(_c3_x + 116, _my3, string(_cur_mc), 0.82, 0.82, 0);
    
    if (sprite_exists(sItemIcons)) draw_sprite(sItemIcons, 6, _c3_x + 144, _my3);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 160, _my3, "Ramuan", 0.78, 0.78, 0);
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(100, 240, 140));
    draw_text_transformed(_c3_x + 244, _my3, string(_cur_pot) + "/5", 0.82, 0.82, 0);
    
    // -------------------------------------------------------------------------
    // 4.3. SUB-PANEL 3C: PROGRES QUEST & KUNCI (Status Kolom Presisi)
    // -------------------------------------------------------------------------
    var _qbox_y = _mat_box_y + _mat_box_h + 8;
    var _qbox_h = 126;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_c3_x, _qbox_y, _c3_x + _c3_w, _qbox_y + _qbox_h, 10, 10, false);
    draw_set_color(make_color_rgb(50, 75, 130));
    draw_roundrect_ext(_c3_x, _qbox_y, _c3_x + _c3_w, _qbox_y + _qbox_h, 10, 10, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_c3_x + 14, _qbox_y + 16, "-- PROGRES QUEST & KUNCI --", 0.82, 0.82, 0);
    
    draw_set_color(make_color_rgb(40, 58, 100));
    draw_line(_c3_x + 14, _qbox_y + 28, _c3_x + _c3_w - 14, _qbox_y + 28);
    
    var _has_bkey = (variable_global_exists("has_boss_key") && global.has_boss_key);
    var _cat_open = ((variable_global_exists("catacombs_gate_opened") && global.catacombs_gate_opened) || (variable_global_exists("catacombs_unlocked") && global.catacombs_unlocked) || (variable_global_exists("dungeon_catacombs_unlocked") && global.dungeon_catacombs_unlocked));
    var _has_rem = ((variable_global_exists("player_has_remedy") && global.player_has_remedy) || (variable_global_exists("remedy_found") && global.remedy_found));
    var _has_goran = (variable_global_exists("party_goran") && global.party_goran);
    
    // 4 Baris Quest dengan Kolom Status Rata Kanan Presisi di _c3_x + _c3_w - 14
    var _qy1 = _qbox_y + 44;
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 14, _qy1, "* Kunci Boss:", 0.75, 0.75, 0);
    draw_set_halign(fa_right);
    draw_set_color(_has_bkey ? make_color_rgb(100, 240, 140) : make_color_rgb(240, 120, 120));
    draw_text_transformed(_c3_x + _c3_w - 14, _qy1, _has_bkey ? "Didapat" : "Belum Didapat", 0.75, 0.75, 0);
    
    var _qy2 = _qbox_y + 66;
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 14, _qy2, "* Segel Katakombe:", 0.75, 0.75, 0);
    draw_set_halign(fa_right);
    draw_set_color(_cat_open ? make_color_rgb(100, 240, 140) : make_color_rgb(240, 120, 120));
    draw_text_transformed(_c3_x + _c3_w - 14, _qy2, _cat_open ? "Terbuka" : "Terkunci", 0.75, 0.75, 0);
    
    var _qy3 = _qbox_y + 88;
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 14, _qy3, "* The Lost Remedy:", 0.75, 0.75, 0);
    draw_set_halign(fa_right);
    draw_set_color(_has_rem ? make_color_rgb(100, 240, 140) : make_color_rgb(240, 120, 120));
    draw_text_transformed(_c3_x + _c3_w - 14, _qy3, _has_rem ? "Didapat" : "Belum Selesai", 0.75, 0.75, 0);
    
    var _qy4 = _qbox_y + 108;
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(_c3_x + 14, _qy4, "* Rekan Party:", 0.75, 0.75, 0);
    draw_set_halign(fa_right);
    draw_set_color(_has_goran ? make_color_rgb(100, 240, 140) : make_color_rgb(160, 180, 210));
    draw_text_transformed(_c3_x + _c3_w - 14, _qy4, _has_goran ? "Goran (Aktif)" : "Solo (Sendiri)", 0.75, 0.75, 0);
    
    // -------------------------------------------------------------------------
    // 5. FOOTER & TOOLTIP SLOT
    // -------------------------------------------------------------------------
    var _foot_y = _my + _mh - 36;
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    var _sis_cond = variable_global_exists("sister_condition") ? global.sister_condition : 100;
    draw_set_color(make_color_rgb(100, 230, 150));
    draw_text_transformed(_c1_x, _foot_y, "Status Sestrina: " + string(_sis_cond) + "% (Stabil)", 0.85, 0.85, 0);
    
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(160, 175, 210));
    draw_text_transformed(_mx + _mw - 24, _foot_y, "[X] / [ESC] Tutup Menu", 0.85, 0.85, 0);
    
    // Tooltip Hover Mouse Slot Perlengkapan
    var _hover_text = "";
    if (_gui_my >= _slot_cy - 20 && _gui_my <= _slot_cy + 20) {
        for (var _hi = 0; _hi < 4; _hi++) {
            var _hx = _c3_x + 43 + _hi * _slot_step;
            if (abs(_gui_mx - _hx) <= 20) {
                if (_hi == 0) _hover_text = "Senjata: " + (variable_global_exists("weapon_name") ? global.weapon_name : "Tangan Kosong") + " (" + string(scr_get_player_atk()) + " ATK)";
                if (_hi == 1) _hover_text = "Zirah: " + (variable_global_exists("armor_name") ? global.armor_name : "Zirah Ksatria") + " (10 DEF)";
                if (_hi == 2) _hover_text = "Aksesoris: " + (variable_global_exists("acc_name") ? global.acc_name : "Pita Harapan") + " (+10 SPD)";
                if (_hi == 3) {
                    var _sp_sel = variable_global_exists("spell_selected") ? global.spell_selected : 0;
                    _hover_text = "Sihir: " + (_sp_sel == 1 ? "Fireball (Klik ganti)" : (_sp_sel == 2 ? "Frost Nova (Klik ganti)" : "Belum Ada"));
                }
            }
        }
    }
    
    if (_hover_text != "") {
        draw_set_alpha(0.95);
        draw_set_color(make_color_rgb(15, 20, 35));
        var _tw = string_width(_hover_text) * 0.8 + 24;
        var _th = 26;
        var _tx = clamp(_gui_mx - _tw / 2, _mx + 450, _mx + _mw - _tw - 10);
        var _ty = _slot_cy + 26;
        draw_roundrect_ext(_tx, _ty, _tx + _tw, _ty + _th, 6, 6, false);
        draw_set_color(make_color_rgb(255, 215, 80));
        draw_roundrect_ext(_tx, _ty, _tx + _tw, _ty + _th, 6, 6, true);
        draw_set_alpha(1.0);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(_tx + _tw / 2, _ty + _th / 2, _hover_text, 0.8, 0.8, 0);
    }
}
// =========================================================================
// 5. MODAL SHEET: BENGKEL TEMPA SENJATA GORAN
// =========================================================================
if (global.shop_menu_open == "goran") {
    draw_set_alpha(0.68);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    var _mw = 600;
    var _mh = 390;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(24, 22, 34));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, false);
    draw_set_color(make_color_rgb(255, 150, 60));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, true);
    draw_set_color(make_color_rgb(95, 60, 35));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 14, 14, true);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 215, 110));
    draw_text(_gw / 2, _my + 16, "⚔ BENGKEL TEMPA GORAN - UPGRADE SENJATA ⚔");

    draw_set_halign(fa_left);
    var _tx = _mx + 35;
    var _ty = _my + 60;

    draw_set_color(make_color_rgb(220, 225, 240));
    draw_text(_tx, _ty, "Senjata Saat Ini: " + global.weapon_name + " (Tier " + string(global.weapon_tier) + ") - ATK " + string(scr_get_player_atk()));

    if (global.weapon_tier == 1) {
        draw_set_color(make_color_rgb(255, 185, 90));
        draw_text(_tx, _ty + 30, "Peningkatan Berikutnya: Tier 2 (Pedang Besi Tempa) -> ATK +10");
        draw_set_color(c_white);
        draw_text(_tx, _ty + 55, "Syarat Material Tempa:");
        
        var _col_si = (global.mat_scrap_iron >= 4) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_si);
        draw_text(_tx + 20, _ty + 80, "• 4x Besi Bekas (Scrap Iron)   - Dimiliki: " + string(global.mat_scrap_iron));
        
        var _col_io = (global.mat_iron_ore >= 2) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_io);
        draw_text(_tx + 20, _ty + 105, "• 2x Bijih Besi (Iron Ore)      - Dimiliki: " + string(global.mat_iron_ore));
        
        var _col_g = (global.gold >= 40) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_g);
        draw_text(_tx + 20, _ty + 130, "• 40 Gold                      - Dimiliki: " + string(global.gold));
        
        var _can_forge = (global.mat_scrap_iron >= 4 && global.mat_iron_ore >= 2 && global.gold >= 40);
        draw_set_halign(fa_center);
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(160, 160, 160));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Bahan belum mencukupi. Farming di Katakombe Lantai 1!");
    } else if (global.weapon_tier == 2) {
        draw_set_color(make_color_rgb(255, 185, 90));
        draw_text(_tx, _ty + 30, "Peningkatan Berikutnya: Tier 3 (Pedang Baja Damaskus) -> ATK +14");
        draw_set_color(c_white);
        draw_text(_tx, _ty + 55, "Syarat Material Tempa:");
        
        var _col_io = (global.mat_iron_ore >= 6) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_io);
        draw_text(_tx + 20, _ty + 80, "• 6x Bijih Besi (Iron Ore)      - Dimiliki: " + string(global.mat_iron_ore));
        
        var _col_bs = (global.mat_bone_shard >= 4) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_bs);
        draw_text(_tx + 20, _ty + 105, "• 4x Tulang (Bone Shard)        - Dimiliki: " + string(global.mat_bone_shard));
        
        var _col_g = (global.gold >= 120) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_g);
        draw_text(_tx + 20, _ty + 130, "• 120 Gold                     - Dimiliki: " + string(global.gold));
        
        var _can_forge = (global.mat_iron_ore >= 6 && global.mat_bone_shard >= 4 && global.gold >= 120);
        draw_set_halign(fa_center);
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(160, 160, 160));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Bahan belum mencukupi. Jelajahi Katakombe!");
    } else if (global.weapon_tier == 3) {
        draw_set_color(make_color_rgb(255, 185, 90));
        draw_text(_tx, _ty + 30, "Peningkatan Berikutnya: Tier 4 (Pedang Perak Runic) -> ATK +20 & Magic Scale");
        draw_set_color(c_white);
        draw_text(_tx, _ty + 55, "Syarat Material Tempa:");
        
        var _col_mc = (global.mat_magic_crystal >= 2) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_mc);
        draw_text(_tx + 20, _ty + 80, "• 2x Kristal Sihir (Magic Crystal) - Dimiliki: " + string(global.mat_magic_crystal));
        
        var _col_bs = (global.mat_bone_shard >= 6) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_bs);
        draw_text(_tx + 20, _ty + 105, "• 6x Tulang (Bone Shard)          - Dimiliki: " + string(global.mat_bone_shard));
        
        var _col_g = (global.gold >= 250) ? make_color_rgb(100, 255, 120) : make_color_rgb(255, 90, 90);
        draw_set_color(_col_g);
        draw_text(_tx + 20, _ty + 130, "• 250 Gold                       - Dimiliki: " + string(global.gold));
        
        var _can_forge = (global.mat_magic_crystal >= 2 && global.mat_bone_shard >= 6 && global.gold >= 250);
        draw_set_halign(fa_center);
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(160, 160, 160));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Kalahkan Panglima Tengkorak untuk kristal!");
    } else {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(130, 255, 160));
        draw_text(_gw / 2, _my + 140, "✧ SENJATA TELAH MENCAPAI TINGKAT MAKSIMAL (TIER 4) ✧");
        draw_text(_gw / 2, _my + 170, "Pedangmu siap menembus pelindung Forgotten Sanctum!");
    }

    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(180, 190, 210));
    draw_text(_gw / 2, _my + _mh - 36, "Tekan [SPACE] Tempa Senjata  •  Tekan [X] Keluar");
    
    // Opsi Party Opsional (Hanya Muncul jika Memiliki Kunci Sanctum / Boss Key)
    if (variable_global_exists("has_boss_key") && global.has_boss_key) {
        if (variable_global_exists("party_goran") && global.party_goran) {
            draw_set_color(make_color_rgb(255, 130, 130));
            draw_text(_gw / 2, _my + _mh - 16, "[P] Lepas Goran dari Party (Saat Ini: MENDAMPINGI)");
        } else {
            draw_set_color(make_color_rgb(130, 220, 255));
            draw_text(_gw / 2, _my + _mh - 16, "[P] Rekrut Goran ke Party (Opsional: Rekan Tempur)");
        }
    }
}

// =========================================================================
// 6. MODAL SHEET: TOKO ALKIMIA & GRIMOIRE ELYSIA
// =========================================================================
if (global.shop_menu_open == "elysia") {
    draw_set_alpha(0.68);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    var _mw = 600;
    var _mh = 390;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(18, 28, 45));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, false);
    draw_set_color(make_color_rgb(90, 195, 255));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 16, 16, true);
    draw_set_color(make_color_rgb(45, 80, 120));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 14, 14, true);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(210, 240, 255));
    draw_text(_gw / 2, _my + 16, "⚗ APOTEK HERBAL & GRIMOIRE ELYSIA ⚗");

    draw_set_halign(fa_left);
    var _tx = _mx + 35;
    var _ty = _my + 65;

    // Item 1: Ramuan Darah
    draw_set_color(make_color_rgb(255, 130, 140));
    draw_text(_tx, _ty, "[1] Beli Ramuan Penyembuh Darah (+1 Potion)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_tx + 20, _ty + 22, "Biaya: 25 Gold  (Dimiliki: " + string(global.gold) + " G, Potion: " + string(global.player_potions) + "/5)");

    // Item 2: Mantra Frost Nova
    var _frost_unlocked = global.spell_unlocked_frost;
    draw_set_color(_frost_unlocked ? make_color_rgb(140, 255, 170) : make_color_rgb(120, 210, 255));
    draw_text(_tx, _ty + 65, "[2] Pelajari Mantra: Frost Nova (Ledakan Es Membekukan)");
    draw_set_color(_frost_unlocked ? make_color_rgb(180, 240, 190) : make_color_rgb(255, 215, 80));
    var _fn_cost = _frost_unlocked ? "✓ SUDAH DIPELAJARI (Ganti mantra dengan tombol [Q])" : "Biaya: 5 Slime Jelly, 1 Magic Crystal, 80 Gold";
    draw_text(_tx + 20, _ty + 87, _fn_cost);

    // Item 3: Elixir Mana Permanen
    draw_set_color(make_color_rgb(220, 160, 255));
    draw_text(_tx, _ty + 130, "[3] Ramuan Elixir Mana (+3 INT Permanen, +24 Max MP)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_tx + 20, _ty + 152, "Biaya: 4 Slime Jelly, 2 Magic Crystal, 150 Gold");

    // Tas Singkat
    draw_set_color(make_color_rgb(190, 205, 225));
    draw_text(_tx, _ty + 195, "Bahan Anda: " + string(global.mat_slime_jelly) + " Slime Jelly  •  " + string(global.mat_magic_crystal) + " Magic Crystal");

    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(175, 190, 210));
    draw_text(_gw / 2, _my + _mh - 30, "Tekan tombol [1], [2], atau [3] untuk Membeli  •  Tekan [X] Keluar");
}

// =========================================================================
// 6.5. MODAL SHEET: KIOS BAHAN MENTAH & MINERAL BAZAAR (MARCUS)
// =========================================================================
if (global.shop_menu_open == "material_trader") {
    var _gui_mx = device_mouse_x_to_gui(0);
    var _gui_my = device_mouse_y_to_gui(0);

    // Dim background overlay
    draw_set_alpha(0.72);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    var _mw = 840;
    var _mh = 520;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;

    // Panel Frosted Glass Warm Dark Slate
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(18, 22, 34));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 18, 18, false);

    // Amber Golden Double Border (Bazaar Theme)
    draw_set_color(make_color_rgb(235, 175, 75));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 18, 18, true);
    draw_set_color(make_color_rgb(85, 60, 25));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 16, 16, true);

    // Diamond corners
    _draw_corner_diamond(_mx + 6, _my + 6);
    _draw_corner_diamond(_mx + _mw - 6, _my + 6);
    _draw_corner_diamond(_mx + 6, _my + _mh - 6);
    _draw_corner_diamond(_mx + _mw - 6, _my + _mh - 6);

    // Close button [X]
    var _close_hover = (_gui_mx >= _mx + _mw - 44 && _gui_mx <= _mx + _mw - 12 && _gui_my >= _my + 12 && _gui_my <= _my + 44);
    draw_set_color(_close_hover ? make_color_rgb(220, 50, 60) : make_color_rgb(45, 38, 30));
    draw_roundrect_ext(_mx + _mw - 44, _my + 12, _mx + _mw - 12, _my + 44, 8, 8, false);
    draw_set_color(c_white);
    draw_roundrect_ext(_mx + _mw - 44, _my + 12, _mx + _mw - 12, _my + 44, 8, 8, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_mx + _mw - 28, _my + 28, "✕");

    // Title & Subtitle
    draw_set_alpha(1.0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 215, 110));
    draw_text(_mx + 24, _my + 16, "🏪 KIOS BAHAN MENTAH & MINERAL - BAZAAR PASAR ALTDORF");

    draw_set_color(make_color_rgb(180, 195, 215));
    draw_text(_mx + 24, _my + 40, "Marcus: \"Bahan tambang, tulang monster, dan kristal sihir terlengkap untuk kebutuhan tempa & alkimia!\"");

    // Top Bar Status: Gold balance & Owned Materials bar
    var _bar_y = _my + 68;
    draw_set_color(make_color_rgb(28, 34, 52));
    draw_roundrect_ext(_mx + 20, _bar_y, _mx + _mw - 20, _bar_y + 30, 8, 8, false);
    draw_set_color(make_color_rgb(60, 75, 110));
    draw_roundrect_ext(_mx + 20, _bar_y, _mx + _mw - 20, _bar_y + 30, 8, 8, true);

    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 220, 90));
    draw_text(_mx + 30, _bar_y + 15, "💰 Koin Gold: " + string(global.gold) + " G");

    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(200, 220, 245));
    draw_text(_mx + _mw - 30, _bar_y + 15, "🎒 Pouch: " + string(global.mat_scrap_iron) + " Besi | " + string(global.mat_iron_ore) + " Bijih | " + string(global.mat_bone_shard) + " Tulang | " + string(global.mat_magic_crystal) + " Kristal | " + string(global.mat_slime_jelly) + " Slime");

    // Item List
    var _list_y = _my + 110;
    var _row_h = 66;

    var _item_names = [
        "Besi Bekas (Scrap Iron)",
        "Bijih Besi Murni (Iron Ore)",
        "Tulang Monster (Bone Shard)",
        "Kristal Sihir Runic (Magic Crystal)",
        "Jeli Slime Hijau (Slime Jelly)"
    ];
    var _item_descs = [
        "Komponen dasar tempa pedang Tier 2 di Goran",
        "Logam tempa padat untuk pedang Tier 2 & Tier 3",
        "Material bertulang keras untuk pedang Tier 3 & Tier 4",
        "Kristal energi magis untuk pedang Tier 4 & Frost Nova",
        "Zat kental alkimia untuk ramuan & elixir mana Elysia"
    ];
    var _item_counts = [
        global.mat_scrap_iron,
        global.mat_iron_ore,
        global.mat_bone_shard,
        global.mat_magic_crystal,
        global.mat_slime_jelly
    ];
    var _buy_prices = [15, 25, 30, 65, 10];
    var _sell_prices = [8, 12, 15, 35, 5];
    var _item_keys_buy = ["[1]", "[2]", "[3]", "[4]", "[5]"];
    var _item_keys_sell = ["[6]", "[7]", "[8]", "[9]", "[0]"];

    for (var _i = 0; _i < 5; _i++) {
        var _ry = _list_y + _i * _row_h;
        var _is_hover = (_gui_mx >= _mx + 20 && _gui_mx <= _mx + _mw - 20 && _gui_my >= _ry && _gui_my <= _ry + _row_h - 6);

        // Row background
        draw_set_alpha(0.85);
        draw_set_color(_is_hover ? make_color_rgb(32, 40, 62) : make_color_rgb(24, 28, 44));
        draw_roundrect_ext(_mx + 20, _ry, _mx + _mw - 20, _ry + _row_h - 6, 8, 8, false);
        draw_set_color(_is_hover ? make_color_rgb(110, 140, 200) : make_color_rgb(45, 55, 80));
        draw_roundrect_ext(_mx + 20, _ry, _mx + _mw - 20, _ry + _row_h - 6, 8, 8, true);

        // Item Name & Owned count
        draw_set_alpha(1.0);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(255, 235, 175));
        draw_text(_mx + 32, _ry + 8, _item_names[_i]);

        draw_set_color(make_color_rgb(130, 220, 160));
        draw_text(_mx + 350, _ry + 8, "Milik: " + string(_item_counts[_i]));

        // Item Description
        draw_set_color(make_color_rgb(165, 175, 195));
        draw_text(_mx + 32, _ry + 32, _item_descs[_i]);

        // Tombol BELI
        var _b_btn_x = _mx + 530;
        var _b_btn_w = 125;
        var _b_can = (global.gold >= _buy_prices[_i]);
        var _b_hover = (_gui_mx >= _b_btn_x && _gui_mx <= _b_btn_x + _b_btn_w && _gui_my >= _ry + 10 && _gui_my <= _ry + 48);

        draw_set_color(_b_can ? (_b_hover ? make_color_rgb(40, 140, 70) : make_color_rgb(25, 95, 50)) : make_color_rgb(45, 50, 55));
        draw_roundrect_ext(_b_btn_x, _ry + 10, _b_btn_x + _b_btn_w, _ry + 48, 6, 6, false);
        draw_set_color(_b_can ? (_b_hover ? make_color_rgb(100, 255, 140) : make_color_rgb(60, 180, 95)) : make_color_rgb(90, 95, 100));
        draw_roundrect_ext(_b_btn_x, _ry + 10, _b_btn_x + _b_btn_w, _ry + 48, 6, 6, true);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(_b_can ? c_white : make_color_rgb(150, 150, 150));
        draw_text(_b_btn_x + _b_btn_w / 2, _ry + 29, _item_keys_buy[_i] + " Beli: " + string(_buy_prices[_i]) + " G");

        // Tombol JUAL
        var _s_btn_x = _mx + 670;
        var _s_btn_w = 125;
        var _s_can = (_item_counts[_i] > 0);
        var _s_hover = (_gui_mx >= _s_btn_x && _gui_mx <= _s_btn_x + _s_btn_w && _gui_my >= _ry + 10 && _gui_my <= _ry + 48);

        draw_set_color(_s_can ? (_s_hover ? make_color_rgb(160, 100, 30) : make_color_rgb(110, 68, 20)) : make_color_rgb(45, 50, 55));
        draw_roundrect_ext(_s_btn_x, _ry + 10, _s_btn_x + _s_btn_w, _ry + 48, 6, 6, false);
        draw_set_color(_s_can ? (_s_hover ? make_color_rgb(255, 190, 80) : make_color_rgb(200, 140, 50)) : make_color_rgb(90, 95, 100));
        draw_roundrect_ext(_s_btn_x, _ry + 10, _s_btn_x + _s_btn_w, _ry + 48, 6, 6, true);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(_s_can ? c_white : make_color_rgb(150, 150, 150));
        draw_text(_s_btn_x + _s_btn_w / 2, _ry + 29, _item_keys_sell[_i] + " Jual: +" + string(_sell_prices[_i]) + " G");
    }

    // Footer Info
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(180, 195, 220));
    draw_text(_gw / 2, _my + _mh - 25, "Shortcut: [1]-[5] Beli Cepat  •  [6]-[0] Jual Cepat  •  Klik Tombol Mouse  •  [X] Tutup Kios");
}

// =========================================================================
// 7. MODAL SHEET: JENDELA SAVE STATE MULTI-SLOT [F7] (Save State Manager)
// =========================================================================
if (variable_global_exists("save_menu_open") && global.save_menu_open) {
    var _gui_mx = device_mouse_x_to_gui(0);
    var _gui_my = device_mouse_y_to_gui(0);
    
    // Dim background overlay
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    
    var _mw = 920;
    var _mh = 570;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;
    
    // Panel Deep Indigo Frosted Glass
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(16, 22, 40));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 18, 18, false);
    
    // Double Glowing Golden / Lavender Border
    draw_set_color(make_color_rgb(135, 165, 245));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 18, 18, true);
    draw_set_color(make_color_rgb(50, 70, 130));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 16, 16, true);

    _draw_corner_diamond(_mx + 6, _my + 6);
    _draw_corner_diamond(_mx + _mw - 6, _my + 6);
    _draw_corner_diamond(_mx + 6, _my + _mh - 6);
    _draw_corner_diamond(_mx + _mw - 6, _my + _mh - 6);

    // --- Header Modal ---
    draw_set_alpha(1.0);
    
    // Tombol Close [X] (Pojok kanan atas)
    var _close_hover = (_gui_mx >= _mx + _mw - 44 && _gui_mx <= _mx + _mw - 12 && _gui_my >= _my + 12 && _gui_my <= _my + 44);
    draw_set_color(_close_hover ? make_color_rgb(220, 50, 60) : make_color_rgb(38, 48, 80));
    draw_roundrect_ext(_mx + _mw - 44, _my + 12, _mx + _mw - 12, _my + 44, 8, 8, false);
    draw_set_color(c_white);
    draw_roundrect_ext(_mx + _mw - 44, _my + 12, _mx + _mw - 12, _my + 44, 8, 8, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_mx + _mw - 28, _my + 28, "✕");

    // Judul & Subjudul
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 225, 120));
    draw_text(_mx + 24, _my + 28, "💾 MANAJEMEN SIMPANAN (SAVE STATE MANAGER)");
    
    draw_set_color(make_color_rgb(170, 195, 235));
    draw_text(_mx + 460, _my + 28, "Simpan / Muat berbagai titik progres permainan");

    // Divider Line
    draw_set_color(make_color_rgb(50, 70, 125));
    draw_line(_mx + 20, _my + 54, _mx + _mw - 20, _my + 54);

    // --- 4 Slot Cards ---
    var _card_y = _my + 68;
    var _card_h = 102;
    var _card_gap = 12;
    var _cx = _mx + 24;
    var _cw = _mw - 48;
    
    for (var _i = 0; _i < array_length(save_slots); _i++) {
        var _cy = _card_y + _i * (_card_h + _card_gap);
        var _slot = save_slots[_i];
        var _info = (_i < array_length(save_slots_cache)) ? save_slots_cache[_i] : scr_get_save_info(_slot.id);
        
        var _card_hover = (_gui_mx >= _cx && _gui_mx <= _cx + _cw && _gui_my >= _cy && _gui_my <= _cy + _card_h);
        
        // Card Background
        draw_set_alpha(0.92);
        draw_set_color(_card_hover ? make_color_rgb(28, 38, 68) : make_color_rgb(20, 26, 48));
        draw_roundrect_ext(_cx, _cy, _cx + _cw, _cy + _card_h, 12, 12, false);
        
        // Card Border
        draw_set_color(_info.exists ? (_card_hover ? make_color_rgb(120, 180, 255) : make_color_rgb(65, 90, 150)) : make_color_rgb(45, 55, 80));
        draw_roundrect_ext(_cx, _cy, _cx + _cw, _cy + _card_h, 12, 12, true);
        
        // Slot Tag Pill (Kiri)
        var _pill_col = (_slot.id == "quicksave") ? make_color_rgb(220, 160, 40) : make_color_rgb(60, 120, 210);
        draw_set_color(_pill_col);
        draw_roundrect_ext(_cx + 12, _cy + 12, _cx + 120, _cy + 34, 6, 6, false);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_cx + 66, _cy + 23, _slot.title);
        
        draw_set_halign(fa_left);
        if (_info.exists) {
            // Judul Lokasi & Waktu
            draw_set_color(make_color_rgb(255, 230, 140));
            draw_text(_cx + 130, _cy + 23, _info.room_title);
            
            draw_set_color(make_color_rgb(130, 220, 245));
            draw_text(_cx + 340, _cy + 23, "🕒 " + _info.time_str);
            
            // Detail Karakter (Level, Senjata, HP, Gold)
            draw_set_color(make_color_rgb(220, 235, 255));
            draw_text(_cx + 20, _cy + 52, _info.level_str);
            
            // Objektif Quest
            draw_set_color(make_color_rgb(165, 185, 215));
            draw_text(_cx + 20, _cy + 76, _info.quest_str);
            
            // --- Action Buttons Kanan ---
            // 1. Tombol SIMPAN / TIMPA
            var _bs_x = _cx + _cw - 280;
            var _bs_y = _cy + 32;
            var _bs_w = 84;
            var _bs_h = 38;
            var _hov_s = (_gui_mx >= _bs_x && _gui_mx <= _bs_x + _bs_w && _gui_my >= _bs_y && _gui_my <= _bs_y + _bs_h);
            draw_set_color(_hov_s ? make_color_rgb(45, 95, 175) : make_color_rgb(28, 48, 85));
            draw_roundrect_ext(_bs_x, _bs_y, _bs_x + _bs_w, _bs_y + _bs_h, 8, 8, false);
            draw_set_color(_hov_s ? make_color_rgb(140, 210, 255) : make_color_rgb(90, 130, 195));
            draw_roundrect_ext(_bs_x, _bs_y, _bs_x + _bs_w, _bs_y + _bs_h, 8, 8, true);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_text(_bs_x + _bs_w / 2, _bs_y + _bs_h / 2, "💾 Timpa");

            // 2. Tombol MUAT / LOAD
            var _bl_x = _cx + _cw - 188;
            var _bl_y = _cy + 32;
            var _bl_w = 84;
            var _bl_h = 38;
            var _hov_l = (_gui_mx >= _bl_x && _gui_mx <= _bl_x + _bl_w && _gui_my >= _bl_y && _gui_my <= _bl_y + _bl_h);
            draw_set_color(_hov_l ? make_color_rgb(40, 125, 75) : make_color_rgb(25, 75, 45));
            draw_roundrect_ext(_bl_x, _bl_y, _bl_x + _bl_w, _bl_y + _bl_h, 8, 8, false);
            draw_set_color(_hov_l ? make_color_rgb(120, 255, 160) : make_color_rgb(60, 180, 100));
            draw_roundrect_ext(_bl_x, _bl_y, _bl_x + _bl_w, _bl_y + _bl_h, 8, 8, true);
            draw_set_color(c_white);
            draw_text(_bl_x + _bl_w / 2, _bl_y + _bl_h / 2, "📂 Muat");

            // 3. Tombol HAPUS / DELETE
            var _bd_x = _cx + _cw - 96;
            var _bd_y = _cy + 32;
            var _bd_w = 76;
            var _bd_h = 38;
            var _hov_d = (_gui_mx >= _bd_x && _gui_mx <= _bd_x + _bd_w && _gui_my >= _bd_y && _gui_my <= _bd_y + _bd_h);
            draw_set_color(_hov_d ? make_color_rgb(140, 35, 45) : make_color_rgb(85, 25, 30));
            draw_roundrect_ext(_bd_x, _bd_y, _bd_x + _bd_w, _bd_y + _bd_h, 8, 8, false);
            draw_set_color(_hov_d ? make_color_rgb(255, 120, 130) : make_color_rgb(175, 60, 70));
            draw_roundrect_ext(_bd_x, _bd_y, _bd_x + _bd_w, _bd_y + _bd_h, 8, 8, true);
            draw_set_color(c_white);
            draw_text(_bd_x + _bd_w / 2, _bd_y + _bd_h / 2, "🗑 Hapus");
        } else {
            // Slot Kosong
            draw_set_color(make_color_rgb(150, 160, 180));
            draw_text(_cx + 130, _cy + 23, "[ SLOT KOSONG ]");
            
            draw_set_color(make_color_rgb(110, 125, 150));
            draw_text(_cx + 20, _cy + 60, "Belum ada file simpanan petualangan di slot ini. Klik Simpan untuk mencatat titik ini.");
            
            // Tombol Simpan Baru
            var _bn_x = _cx + _cw - 200;
            var _bn_y = _cy + 32;
            var _bn_w = 180;
            var _bn_h = 38;
            var _hov_n = (_gui_mx >= _bn_x && _gui_mx <= _bn_x + _bn_w && _gui_my >= _bn_y && _gui_my <= _bn_y + _bn_h);
            draw_set_color(_hov_n ? make_color_rgb(45, 95, 175) : make_color_rgb(28, 48, 85));
            draw_roundrect_ext(_bn_x, _bn_y, _bn_x + _bn_w, _bn_y + _bn_h, 8, 8, false);
            draw_set_color(_hov_n ? make_color_rgb(140, 210, 255) : make_color_rgb(90, 130, 195));
            draw_roundrect_ext(_bn_x, _bn_y, _bn_x + _bn_w, _bn_y + _bn_h, 8, 8, true);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_text(_bn_x + _bn_w / 2, _bn_y + _bn_h / 2, "💾 Simpan ke Slot Ini");
        }
    }
    
    // --- Footer Modal ---
    draw_set_color(make_color_rgb(150, 175, 215));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_mx + _mw / 2, _my + _mh - 24, "💡 Tips: Tekan [X] / [ESC] untuk Menutup • Tekan [F5] untuk Quick Save • Tekan [F6] untuk Quick Load");
}

// =========================================================================
// 8. HUD TOWN-GUIDE & MAP BUTTON (Pojok Kanan Bawah - Reference: map.png)
// =========================================================================
if (!global.dialogue_active && global.shop_menu_open == "" && !global.stat_menu_open && (!variable_global_exists("save_menu_open") || !global.save_menu_open) && (!variable_global_exists("map_menu_open") || !global.map_menu_open) && (!variable_global_exists("leave_confirm_active") || !global.leave_confirm_active) && (!variable_global_exists("game_ending") || global.game_ending == "")) {
    var _tg_x = _gw - 145;
    var _tg_y = _gh - 55;
    var _tg_w = 125;
    var _tg_h = 36;
    
    var _tg_hover = (device_mouse_x_to_gui(0) >= _tg_x && device_mouse_x_to_gui(0) <= _tg_x + _tg_w && device_mouse_y_to_gui(0) >= _tg_y && device_mouse_y_to_gui(0) <= _tg_y + _tg_h);
    
    draw_set_alpha(_tg_hover ? 0.95 : 0.85);
    draw_set_color(_tg_hover ? make_color_rgb(35, 55, 95) : make_color_rgb(22, 34, 62));
    draw_roundrect_ext(_tg_x, _tg_y, _tg_x + _tg_w, _tg_y + _tg_h, 14, 14, false);
    
    draw_set_color(_tg_hover ? make_color_rgb(160, 220, 255) : make_color_rgb(110, 160, 240));
    draw_roundrect_ext(_tg_x, _tg_y, _tg_x + _tg_w, _tg_y + _tg_h, 14, 14, true);
    
    draw_set_alpha(1.0);
    draw_set_color(_tg_hover ? make_color_rgb(255, 240, 180) : make_color_rgb(225, 240, 255));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_tg_x + _tg_w / 2, _tg_y + _tg_h / 2, "🗺️ Map [M]");
}

// =========================================================================
// 9. LEAVING AREA OPTION MODAL (Reference: leaving area option.png)
// =========================================================================
if (variable_global_exists("leave_confirm_active") && global.leave_confirm_active) {
    // 1. Dark Vignette Tint
    draw_set_alpha(0.68);
    draw_set_color(make_color_rgb(6, 10, 24));
    draw_rectangle(0, 0, _gw, _gh, false);
    
    // 2. Bottom-left Prompt Text (Reference: leaving area option.png - Leave Joy Street?)
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(240, 248, 255));
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    var _area_str = (global.leave_confirm_area_name != "") ? global.leave_confirm_area_name : "Area ini";
    draw_text(160, _gh - 130, "Leave " + _area_str + "?");
    
    // 3. Center Choice Pills
    var _btn_cx = _gw / 2;
    var _btn_w = 460;
    var _btn_h = 44;
    var _b1_y = _gh / 2 - 25;
    var _b2_y = _gh / 2 + 35;
    
    // Helper Gambar Pill Opsi dengan Diamond Ends
    var _draw_choice_pill = function(_cx, _cy, _w, _h, _text, _is_selected) {
        var _x1 = _cx - _w / 2;
        var _y1 = _cy - _h / 2;
        var _x2 = _cx + _w / 2;
        var _y2 = _cy + _h / 2;
        
        // Background Pill
        draw_set_alpha(_is_selected ? 0.92 : 0.65);
        draw_set_color(_is_selected ? make_color_rgb(26, 48, 92) : make_color_rgb(16, 24, 46));
        draw_roundrect_ext(_x1, _y1, _x2, _y2, 22, 22, false);
        
        // Glowing Neon Border
        draw_set_alpha(_is_selected ? 0.95 : 0.5);
        draw_set_color(_is_selected ? make_color_rgb(120, 195, 255) : make_color_rgb(45, 65, 110));
        draw_roundrect_ext(_x1, _y1, _x2, _y2, 22, 22, true);
        if (_is_selected) {
            draw_set_color(make_color_rgb(190, 230, 255));
            draw_roundrect_ext(_x1 + 1, _y1 + 1, _x2 - 1, _y2 - 1, 20, 20, true);
        }
        
        // Diamond Accent Braces di Kiri & Kanan (<> Text <>)
        var _c_dia = _is_selected ? make_color_rgb(160, 215, 255) : make_color_rgb(70, 95, 145);
        draw_set_color(_c_dia);
        var _d_offset = _w / 2 - 42;
        // Diamond Kiri
        draw_triangle(_cx - _d_offset - 8, _cy, _cx - _d_offset, _cy - 7, _cx - _d_offset + 8, _cy, true);
        draw_triangle(_cx - _d_offset - 8, _cy, _cx - _d_offset, _cy + 7, _cx - _d_offset + 8, _cy, true);
        // Diamond Kanan
        draw_triangle(_cx + _d_offset - 8, _cy, _cx + _d_offset, _cy - 7, _cx + _d_offset + 8, _cy, true);
        draw_triangle(_cx + _d_offset - 8, _cy, _cx + _d_offset, _cy + 7, _cx + _d_offset + 8, _cy, true);
        
        // Text
        draw_set_alpha(1.0);
        draw_set_color(_is_selected ? c_white : make_color_rgb(175, 195, 225));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_cx, _cy - 1, _text);
    };
    
    _draw_choice_pill(_btn_cx, _b1_y, _btn_w, _btn_h, "Leave", global.leave_confirm_selection == 0);
    _draw_choice_pill(_btn_cx, _b2_y, _btn_w, _btn_h, "Don't leave", global.leave_confirm_selection == 1);
    
    // Bottom-right VN Control Icons (⏩ ▶ ≡ ✖)
    draw_set_color(make_color_rgb(180, 210, 255));
    draw_set_halign(fa_right);
    draw_text(_gw - 160, _gh - 130, "⏩   ▶   ≡   ✖");
    
    // Controls Hint
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(140, 165, 210));
    draw_text(_gw / 2, _b2_y + 46, "Gunakan [W]/[S] atau Panah untuk Memilih  •  [Enter] / [Space] / [Z] Konfirmasi  •  [X] Batal");
}

// =========================================================================
// 10. ISOMETRIC TOWN MAP & SPOTLIGHT VIGNETTE (Reference: map.png & choosing are.png)
// =========================================================================
if (variable_global_exists("map_menu_open") && global.map_menu_open) {
    // 1. Dark Backdrop
    draw_set_alpha(0.88);
    draw_set_color(make_color_rgb(8, 12, 26));
    draw_rectangle(0, 0, _gw, _gh, false);
    
    // 2. Lukisan Peta Isometrik Wilayah Altdorf
    // Sungai Membelah Kota (Diagonal Ribbon)
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(22, 54, 102));
    draw_triangle(0, 180, _gw, 480, 0, 280, false);
    draw_triangle(_gw, 480, _gw, 580, 0, 280, false);
    
    // Riak Air Biru Terang
    draw_set_color(make_color_rgb(50, 120, 195));
    for (var _rw = 0; _rw < 8; _rw++) {
        var _rwx = (_rw * 180 + map_anim_timer * 15) mod _gw;
        var _rwy = 220 + (_rwx / _gw) * 300;
        draw_line_width(_rwx - 25, _rwy, _rwx + 25, _rwy, 2);
    }
    
    // Jembatan Batu Menghubungkan Distrik
    draw_set_color(make_color_rgb(70, 75, 95));
    draw_rectangle(560, 310, 640, 370, false);
    draw_rectangle(820, 420, 890, 480, false);
    
    // Jalur Jalan Setapak Cobblestone
    draw_set_color(make_color_rgb(55, 60, 78));
    for (var _p = 0; _p < array_length(map_nodes) - 1; _p++) {
        var _n1 = map_nodes[_p];
        var _n2 = map_nodes[_p + 1];
        draw_line_width(_n1.map_x, _n1.map_y, _n2.map_x, _n2.map_y, 4);
    }
    
    // 3. Render Node Distrik di Peta
    var _cur_node = map_nodes[map_selected_node];
    
    // A. Spotlight Vignette (Reference: choosing are.png)
    var _spx = _cur_node.map_x;
    var _spy = _cur_node.map_y;
    var _sp_rad = 145 + sin(map_anim_timer * 2.5) * 6;
    
    gpu_set_blendmode(bm_add);
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(90, 180, 255));
    draw_circle(_spx, _spy, _sp_rad, false);
    draw_set_alpha(0.65);
    draw_set_color(make_color_rgb(180, 230, 255));
    draw_circle(_spx, _spy, _sp_rad * 0.5, false);
    gpu_set_blendmode(bm_normal);
    
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(140, 215, 255));
    draw_circle(_spx, _spy, _sp_rad, true);
    
    // B. Gambar Masing-Masing Node Icon
    for (var _i = 0; _i < array_length(map_nodes); _i++) {
        var _node = map_nodes[_i];
        var _is_sel = (_i == map_selected_node);
        var _is_locked = (global.quest_stage < _node.req_stage);
        
        // Base Pin Disc
        draw_set_alpha(0.95);
        draw_set_color(_is_sel ? make_color_rgb(45, 95, 175) : (_is_locked ? make_color_rgb(40, 42, 52) : make_color_rgb(28, 42, 75)));
        draw_circle(_node.map_x, _node.map_y, _is_sel ? 28 : 22, false);
        
        draw_set_color(_is_sel ? make_color_rgb(145, 220, 255) : (_is_locked ? make_color_rgb(85, 90, 105) : make_color_rgb(95, 140, 220)));
        draw_circle(_node.map_x, _node.map_y, _is_sel ? 28 : 22, true);
        
        // Label Nama Node di Atas Pin
        draw_set_alpha(1.0);
        draw_set_color(_is_sel ? c_white : (_is_locked ? make_color_rgb(140, 145, 160) : make_color_rgb(205, 225, 255)));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(_node.map_x, _node.map_y - (_is_sel ? 32 : 26), _node.name);
        
        // Ikon Pin di Tengah
        draw_set_valign(fa_middle);
        if (_is_locked) {
            draw_set_color(make_color_rgb(255, 90, 90));
            draw_text(_node.map_x, _node.map_y - 1, "🔒");
        } else {
            draw_set_color(_is_sel ? make_color_rgb(255, 230, 130) : make_color_rgb(200, 230, 255));
            draw_text(_node.map_x, _node.map_y - 1, string(_i + 1));
        }
    }
    
    // 4. Panel Informasi Area (Bottom-Left Banner - Reference: choosing are.png)
    var _inf_x = 75;
    var _inf_y = _gh - 220;
    var _inf_w = 520;
    var _inf_h = 160;
    
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(20, 30, 56));
    draw_roundrect_ext(_inf_x, _inf_y, _inf_x + _inf_w, _inf_y + _inf_h, 20, 20, false);
    
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(130, 175, 255));
    draw_roundrect_ext(_inf_x, _inf_y, _inf_x + _inf_w, _inf_y + _inf_h, 20, 20, true);
    
    // Judul Area: ~ Joy Street ~
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_inf_x + 24, _inf_y + 18, "~ " + _cur_node.name + " ~ (" + _cur_node.subname + ")");
    
    // Lore Text Area
    draw_set_color(make_color_rgb(225, 238, 255));
    draw_text_ext(_inf_x + 24, _inf_y + 48, _cur_node.lore, 24, _inf_w - 48);
    
    // Status Syarat
    var _is_cur_locked = (global.quest_stage < _cur_node.req_stage);
    draw_set_color(_is_cur_locked ? make_color_rgb(255, 110, 120) : make_color_rgb(120, 240, 180));
    draw_text(_inf_x + 24, _inf_y + _inf_h - 32, _is_cur_locked ? "⚠ Persyaratan Belum Terpenuhi (Ikuti alur cerita utama)" : "✓ Siap Dikunjungi / Fast Travel Tersedia");
    
    // 5. Tombol Keputusan Enter / Don't enter di Kanan (Reference: choosing are.png)
    var _dec_x = _gw - 230;
    var _dec_y = _gh / 2 - 30;
    var _dec_w = 170;
    var _dec_h = 42;
    
    // Tombol [Enter]
    draw_set_alpha(0.92);
    draw_set_color(_is_cur_locked ? make_color_rgb(30, 35, 50) : make_color_rgb(32, 60, 115));
    draw_roundrect_ext(_dec_x, _dec_y, _dec_x + _dec_w, _dec_y + _dec_h, 12, 12, false);
    draw_set_color(_is_cur_locked ? make_color_rgb(70, 75, 95) : make_color_rgb(140, 200, 255));
    draw_roundrect_ext(_dec_x, _dec_y, _dec_x + _dec_w, _dec_y + _dec_h, 12, 12, true);
    
    draw_set_alpha(1.0);
    draw_set_color(_is_cur_locked ? make_color_rgb(150, 155, 170) : c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_dec_x + _dec_w / 2, _dec_y + _dec_h / 2, "Enter");
    
    // Tombol [Don't enter]
    var _dec2_y = _dec_y + 52;
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(20, 28, 50));
    draw_roundrect_ext(_dec_x, _dec2_y, _dec_x + _dec_w, _dec2_y + _dec_h, 12, 12, false);
    draw_set_color(make_color_rgb(90, 120, 180));
    draw_roundrect_ext(_dec_x, _dec2_y, _dec_x + _dec_w, _dec2_y + _dec_h, 12, 12, true);
    
    draw_set_color(make_color_rgb(200, 215, 240));
    draw_text(_dec_x + _dec_w / 2, _dec2_y + _dec_h / 2, "Don't enter");
    
    // 6. Tombol Town-Guide Mascot di Kanan Bawah Peta
    var _tg_mx = _gw - 120;
    var _tg_my = _gh - 80;
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_circle(_tg_mx, _tg_my, 28, false);
    draw_set_color(make_color_rgb(30, 20, 15));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_tg_mx, _tg_my - 1, "MAP");
    draw_set_color(c_white);
    draw_text(_tg_mx, _tg_my + 36, "Town-Guide");
    
    // Hotkey Controls Hint
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(150, 180, 225));
    draw_text(_gw / 2, _gh - 30, "[A]/[D] Ganti Distrik  •  [1]-[6] Pilih Langsung  •  [Enter] / [Z] Masuk  •  [X] Tutup Peta");
}

// =========================================================================
// 11. CINEMATIC MULTI-ENDING RESOLUTION OVERLAY (Prioritas 4 - Red Eyes GDD)
// =========================================================================
if (variable_global_exists("game_ending") && global.game_ending != "") {
    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(6, 8, 18));
    draw_rectangle(0, 0, _gw, _gh, false);
    
    var _ew = 860;
    var _eh = 480;
    var _ex = (_gw - _ew) / 2;
    var _ey = (_gh - _eh) / 2;
    
    var _col_border = make_color_rgb(255, 215, 80);
    var _col_title = make_color_rgb(255, 235, 140);
    var _title_txt = "";
    var _sub_txt = "";
    var _story_txt = "";
    
    if (global.game_ending == "human") {
        _col_border = make_color_rgb(130, 210, 255);
        _col_title = make_color_rgb(215, 245, 255);
        _title_txt = "✦ ENDING 1: TETAP MANUSIA (THE PURE REMEDY) ✦";
        _sub_txt = "Misi Berhasil - Hari ke-" + string(global.day_count) + " (Sebelum Batas Waktu)";
        _story_txt = "Kau berhasil membawa The Lost Remedy dari takhta Forgotten Sanctum tanpa mengorbankan jiwamu pada kekuatan iblis.\n\nSirkulasi mana Sestrina yang mengalami Overclock fatal telah dinetralkan seutuhnya. Rasa terbakar dan rambutnya yang memutih perlahan kembali seperti semula.\n\nKalian adalah manusia biasa yang dicampakkan oleh party petualang bangsawan, namun dengan tekad baja, kalian membuktikan bahwa cinta kasih persaudaraan sanggup menembus takdir terkelam sekalipun.";
    } else if (global.game_ending == "half_demon") {
        _col_border = make_color_rgb(235, 50, 70);
        _col_title = make_color_rgb(255, 140, 160);
        _title_txt = "🩸 ENDING 2: MENINGGALKAN KEMANUSIAAN (THE CRIMSON PACT) 🩸";
        _sub_txt = "Kekuatan Darah Iblis Dibuka Demi Menyelamatkan Adik";
        _story_txt = "Demi mengalahkan penjaga purba dan membawa pulang The Lost Remedy tepat waktu, kau memecahkan segel terlarang darah iblis.\n\nSestrina terselamatkan dari kematian Overclock mana leak, namun saat membuka mata, ia menangis melihat wujudmu. Matamu kini merah menyala bagai darah dan aura kutukan kegelapan abadi kini mengalir di nadimu.\n\n'Kakak... apa yang telah kau korbankan demi diriku...?'\nKau tersenyum lembut di balik bayang-bayang: 'Asalkan kau hidup, aku rela menjadi monster sekalipun.'";
    } else if (global.game_ending == "death") {
        _col_border = make_color_rgb(140, 60, 80);
        _col_title = make_color_rgb(230, 130, 150);
        _title_txt = "🥀 ENDING 3: KEGAGALAN TRAGIS (THE OVERCLOCK CONSUMED) 🥀";
        _sub_txt = "Batas Waktu Terlampaui - Hari ke-" + string(global.day_count) + " (Hari 6+)";
        _story_txt = "Waktu terus bergulir tanpa henti. Saat kau melangkah kembali ke gubuk pengasingan, hembusan angin dingin menyambutmu di ambang pintu.\n\nSestrina terbaring kaku. Seluruh rambutnya telah memutih seutuhnya dan denyut nadinya telah berhenti selamanya. Overclock sihir telah melahap habis sirkulasi hidupnya sebelum obat penawar tiba.\n\nKau bersimpuh di samping ranjangnya dalam kehampaan malam, meratapi setiap detik yang terbuang sia-sia...";
    }
    
    // Background Frame
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(18, 22, 42));
    draw_roundrect_ext(_ex, _ey, _ex + _ew, _ey + _eh, 24, 24, false);
    
    // Glowing Double Border
    draw_set_alpha(0.95);
    draw_set_color(_col_border);
    draw_roundrect_ext(_ex, _ey, _ex + _ew, _ey + _eh, 24, 24, true);
    draw_set_color(make_color_rgb(45, 60, 95));
    draw_roundrect_ext(_ex + 2, _ey + 2, _ex + _ew - 2, _ey + _eh - 2, 22, 22, true);
    
    // Title
    draw_set_alpha(1.0);
    draw_set_color(_col_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_gw / 2, _ey + 26, _title_txt);
    
    // Subtitle
    draw_set_color(make_color_rgb(180, 205, 235));
    draw_text(_gw / 2, _ey + 58, _sub_txt);
    
    // Divider line
    draw_set_color(_col_border);
    draw_line_width(_ex + 60, _ey + 88, _ex + _ew - 60, _ey + 88, 1.5);
    
    // Story Text
    draw_set_color(make_color_rgb(240, 245, 255));
    draw_text_ext(_gw / 2, _ey + 108, _story_txt, 26, _ew - 80);
    
    // Dismiss button
    if (variable_instance_exists(id, "ending_card_cooldown") && ending_card_cooldown > 0) {
        ending_card_cooldown--;
    }
    var _btn_y = _ey + _eh - 44;
    draw_set_color(make_color_rgb(255, 230, 130));
    draw_text(_gw / 2, _btn_y, "▶ [Tekan SPACE / ENTER / Z untuk Melihat Ending & Kredit Pengembang] ◀");
    
    if (ending_card_cooldown <= 0) {
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_left)) {
            credits_cached_ending = global.game_ending;
            global.game_ending = "";
            showing_credits = true;
            credits_cooldown = 45;
            ending_credits_y = _gh;
            scr_audio_play("ui", "confirm");
        }
    }
}

// =========================================================================
// 11B. GRAND CINEMATIC ENDING & STAFF CREDITS ROLL
// =========================================================================
if (variable_instance_exists(id, "showing_credits") && showing_credits) {
    if (variable_instance_exists(id, "credits_cooldown") && credits_cooldown > 0) {
        credits_cooldown--;
    }
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(8, 12, 24));
    draw_rectangle(0, 0, _gw, _gh, false);

    ending_credits_y -= 0.8;

    var _end_lines = [
        "✦ SELAMAT! ✦",
        "ANDA TELAH MENYELESAIKAN PETUALANGAN",
        "S E S T R I N A",
        "THE LOST REMEDY",
        "",
        (credits_cached_ending == "human") ? "✦ ENDING TERCAPAI: TETAP MANUSIA (THE PURE REMEDY) ✦" : "🩸 ENDING TERCAPAI: THE CRIMSON PACT 🩸",
        "",
        "\"Kekuatan cinta seorang kakak sanggup menembus takdir terkelam.\"",
        "",
        "========================================",
        "KREDIT PENGEMBANGAN",
        "========================================",
        "",
        "SUTRADARA & PRODUSER PROYEK",
        "Luqman / Hnzsama",
        "",
        "DESAIN CERITA & SKENARIO",
        "The Sestrina Chronicles",
        "",
        "SISTEM ARPG & GAMEPLAY",
        "Antigravity GameMaker Engine",
        "Kombo Pedang 3-Hit, Parry & Dodge Roll",
        "Sistem Sihir Elemen Api & Es",
        "Sistem Waktu Day/Night & Kondisi Adik",
        "",
        "DESAIN GRAFIS & PIXEL ART",
        "Diorama Kamar: Medieval Blacksmith Studio",
        "Arsitektur Kota: Fantasy RPG Town Tileset Collection",
        "Desain Karakter Heroine & Sestrina 2D Visual",
        "Monster & Boss Kuil Purba Atlas",
        "",
        "AUDIO & DESAIN SUARA",
        "Category-Centric Modular Soundworks",
        "",
        "TERIMA KASIH KHUSUS",
        "Untuk Anda yang telah berjuang dan menyelamatkan Sestrina!",
        "",
        "========================================",
        "✧ TAMAT ~ THE END ✧",
        "========================================"
    ];

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _cy = ending_credits_y;
    for (var _ei = 0; _ei < array_length(_end_lines); _ei++) {
        var _txt = _end_lines[_ei];
        if (_txt != "") {
            if (string_pos("SELAMAT", _txt) > 0 || string_pos("S E S T R I N A", _txt) > 0 || string_pos("TAMAT", _txt) > 0) {
                draw_set_color(make_color_rgb(255, 235, 140));
                draw_text_transformed(_gw / 2, _cy, _txt, 1.45, 1.45, 0);
            } else if (string_pos("ENDING", _txt) > 0) {
                draw_set_color((credits_cached_ending == "human") ? make_color_rgb(130, 215, 255) : make_color_rgb(255, 120, 140));
                draw_text_transformed(_gw / 2, _cy, _txt, 1.15, 1.15, 0);
            } else if (string_pos("===", _txt) > 0 || string_pos("KREDIT", _txt) > 0 || string_pos("SUTRADARA", _txt) > 0) {
                draw_set_color(make_color_rgb(255, 215, 90));
                draw_text_transformed(_gw / 2, _cy, _txt, 1.05, 1.05, 0);
            } else {
                draw_set_color(make_color_rgb(220, 230, 250));
                draw_text(_gw / 2, _cy, _txt);
            }
        }
        _cy += 36;
    }

    // Tombol Kembali ke Menu Utama
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(18, 24, 45));
    draw_rectangle(0, _gh - 55, _gw, _gh, false);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_line_width(0, _gh - 55, _gw, _gh - 55, 2);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_text(_gw / 2, _gh - 28, "▶ [Tekan SPACE / ENTER / ESC untuk Kembali ke Menu Utama] ◀");

    if (credits_cooldown <= 0 && (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("Z")))) {
        showing_credits = false;
        room_goto(rm_main_menu);
    }
}

// =========================================================================
// 12. SCREEN FADE OVERLAY
// =========================================================================
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
