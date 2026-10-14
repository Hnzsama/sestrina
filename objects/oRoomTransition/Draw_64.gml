/// @description Draw GUI Event - Aesthetic Medieval RPG Status HUD, Quest Tracker, Stat & Shop Menus

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// =========================================================================
// 1. KNIGHT HEROINE STATUS PLATE (Kiri Atas - 420x150)
// =========================================================================
var _hud_x = 24;
var _hud_y = 16;
var _hud_w = 420;
var _hud_h = 146;

// Background Plate Ornate Medieval Obsidian / Dark Iron
draw_set_alpha(0.94);
draw_set_color(make_color_rgb(18, 22, 32));
draw_roundrect_ext(_hud_x, _hud_y, _hud_x + _hud_w, _hud_y + _hud_h, 12, 12, false);

// Golden Beveled Outer & Inner Border
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(215, 175, 75));
draw_roundrect_ext(_hud_x, _hud_y, _hud_x + _hud_w, _hud_y + _hud_h, 12, 12, true);
draw_set_color(make_color_rgb(90, 75, 45));
draw_roundrect_ext(_hud_x + 2, _hud_y + 2, _hud_x + _hud_w - 2, _hud_y + _hud_h - 2, 10, 10, true);

// Brass Corner Rivets
draw_set_color(make_color_rgb(230, 190, 80));
draw_circle(_hud_x + 6, _hud_y + 6, 1.5, false);
draw_circle(_hud_x + _hud_w - 6, _hud_y + 6, 1.5, false);
draw_circle(_hud_x + 6, _hud_y + _hud_h - 6, 1.5, false);
draw_circle(_hud_x + _hud_w - 6, _hud_y + _hud_h - 6, 1.5, false);

// --- Row 1: Level Badge, Gold Badge, Hotkey Hint ---
var _r1_y = _hud_y + 13;

// Level Badge Pill
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(45, 32, 68));
draw_roundrect_ext(_hud_x + 10, _r1_y - 6, _hud_x + 95, _r1_y + 11, 6, 6, false);
draw_set_color(make_color_rgb(175, 120, 255));
draw_roundrect_ext(_hud_x + 10, _r1_y - 6, _hud_x + 95, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
draw_set_color(make_color_rgb(235, 205, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_hud_x + 52, _r1_y + 2, "★ Lv " + string(global.player_level));

// Gold Badge Pill
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(55, 45, 22));
draw_roundrect_ext(_hud_x + 105, _r1_y - 6, _hud_x + 215, _r1_y + 11, 6, 6, false);
draw_set_color(make_color_rgb(220, 170, 55));
draw_roundrect_ext(_hud_x + 105, _r1_y - 6, _hud_x + 215, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
draw_set_color(make_color_rgb(255, 215, 80));
draw_set_halign(fa_center);
draw_text(_hud_x + 160, _r1_y + 2, "🪙 " + string(global.gold) + " G");

// Status Menu [P] Badge (Kanan Atas Plate)
draw_set_alpha(0.9);
var _pts = variable_global_exists("stat_points") ? global.stat_points : 0;
var _pcol = (_pts > 0) ? make_color_rgb(180, 50, 40) : make_color_rgb(26, 45, 68);
draw_set_color(_pcol);
draw_roundrect_ext(_hud_x + _hud_w - 140, _r1_y - 6, _hud_x + _hud_w - 10, _r1_y + 11, 6, 6, false);
draw_set_color((_pts > 0) ? make_color_rgb(255, 160, 100) : make_color_rgb(90, 170, 240));
draw_roundrect_ext(_hud_x + _hud_w - 140, _r1_y - 6, _hud_x + _hud_w - 10, _r1_y + 11, 6, 6, true);

draw_set_alpha(1.0);
draw_set_color((_pts > 0) ? make_color_rgb(255, 240, 180) : make_color_rgb(180, 230, 255));
draw_set_halign(fa_center);
draw_text(_hud_x + _hud_w - 75, _r1_y + 2, (_pts > 0) ? "✦ [P] +" + string(_pts) + " Poin!" : "✦ [P] Status");

// --- Parameter Bar Setup ---
var _bar_w = 275;
var _bar_h = 8;
var _bar_x = _hud_x + 36;

// --- Row 2: Health Bar (HP) ---
var _r2_y = _hud_y + 30;
draw_set_color(make_color_rgb(255, 120, 120));
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(_hud_x + 10, _r2_y + _bar_h / 2, "HP");

draw_set_color(make_color_rgb(45, 15, 15));
draw_rectangle(_bar_x, _r2_y, _bar_x + _bar_w, _r2_y + _bar_h, false);

var _fill_hp = max(0, (_bar_w * (global.player_hp / global.player_max_hp)));
draw_set_color(make_color_rgb(225, 45, 45));
draw_rectangle(_bar_x, _r2_y, _bar_x + _fill_hp, _r2_y + _bar_h, false);
draw_set_color(make_color_rgb(255, 130, 130));
draw_rectangle(_bar_x, _r2_y, _bar_x + _fill_hp, _r2_y + 2, false);

draw_set_color(make_color_rgb(235, 195, 90));
draw_rectangle(_bar_x, _r2_y, _bar_x + _bar_w, _r2_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(_hud_x + _hud_w - 12, _r2_y + _bar_h / 2, string(round(global.player_hp)) + "/" + string(round(global.player_max_hp)));

// --- Row 3: Mana Bar (MP) ---
var _r3_y = _hud_y + 44;
draw_set_color(make_color_rgb(110, 185, 255));
draw_set_halign(fa_left);
draw_text(_hud_x + 10, _r3_y + _bar_h / 2, "MP");

draw_set_color(make_color_rgb(15, 25, 50));
draw_rectangle(_bar_x, _r3_y, _bar_x + _bar_w, _r3_y + _bar_h, false);

var _fill_mp = max(0, (_bar_w * (global.player_mp / global.player_max_mp)));
draw_set_color(make_color_rgb(35, 120, 240));
draw_rectangle(_bar_x, _r3_y, _bar_x + _fill_mp, _r3_y + _bar_h, false);
draw_set_color(make_color_rgb(130, 210, 255));
draw_rectangle(_bar_x, _r3_y, _bar_x + _fill_mp, _r3_y + 2, false);

draw_set_color(make_color_rgb(160, 205, 255));
draw_rectangle(_bar_x, _r3_y, _bar_x + _bar_w, _r3_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(_hud_x + _hud_w - 12, _r3_y + _bar_h / 2, string(round(global.player_mp)) + "/" + string(round(global.player_max_mp)));

// --- Row 4: Stamina Bar (SP) ---
var _r4_y = _hud_y + 58;
draw_set_color(make_color_rgb(100, 240, 160));
draw_set_halign(fa_left);
draw_text(_hud_x + 10, _r4_y + _bar_h / 2, "SP");

draw_set_color(make_color_rgb(15, 40, 25));
draw_rectangle(_bar_x, _r4_y, _bar_x + _bar_w, _r4_y + _bar_h, false);

var _cur_sp = variable_global_exists("player_stamina") ? global.player_stamina : 100;
var _max_sp = variable_global_exists("player_max_stamina") ? global.player_max_stamina : 100;
var _fill_sp = max(0, (_bar_w * (_cur_sp / _max_sp)));
draw_set_color(make_color_rgb(40, 200, 110));
draw_rectangle(_bar_x, _r4_y, _bar_x + _fill_sp, _r4_y + _bar_h, false);
draw_set_color(make_color_rgb(140, 255, 190));
draw_rectangle(_bar_x, _r4_y, _bar_x + _fill_sp, _r4_y + 2, false);

draw_set_color(make_color_rgb(180, 210, 120));
draw_rectangle(_bar_x, _r4_y, _bar_x + _bar_w, _r4_y + _bar_h, true);

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(_hud_x + _hud_w - 12, _r4_y + _bar_h / 2, string(round(_cur_sp)) + "/" + string(round(_max_sp)));

// --- Row 5: Experience Bar (EXP) ---
var _r5_y = _hud_y + 72;
draw_set_color(make_color_rgb(220, 180, 255));
draw_set_halign(fa_left);
draw_text(_hud_x + 10, _r5_y + 3, "XP");

draw_set_color(make_color_rgb(30, 20, 45));
draw_rectangle(_bar_x, _r5_y, _bar_x + _bar_w, _r5_y + 6, false);

var _fill_exp = max(0, (_bar_w * (global.player_exp / global.player_max_exp)));
draw_set_color(make_color_rgb(175, 90, 245));
draw_rectangle(_bar_x, _r5_y, _bar_x + _fill_exp, _r5_y + 6, false);
draw_set_color(make_color_rgb(220, 170, 255));
draw_rectangle(_bar_x, _r5_y, _bar_x + _bar_w, _r5_y + 6, true);

draw_set_color(make_color_rgb(220, 200, 240));
draw_set_halign(fa_right);
draw_text(_hud_x + _hud_w - 12, _r5_y + 3, string(round(global.player_exp)) + "/" + string(round(global.player_max_exp)));

// --- Row 6: 4 Action Chips ---
var _r6_y = _hud_y + 86;
var _chip_w = 94;
var _chip_h = 24;
var _chip_gap = 8;

// Chip 1: Ramuan [C]
var _c1_x = _hud_x + 10;
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(24, 48, 34));
draw_roundrect_ext(_c1_x, _r6_y, _c1_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(make_color_rgb(80, 200, 120));
draw_roundrect_ext(_c1_x, _r6_y, _c1_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(140, 245, 170));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_c1_x + _chip_w / 2, _r6_y + _chip_h / 2, "⚗ [C] x" + string(global.player_potions));

// Chip 2: Serangan [Z]
var _c2_x = _c1_x + _chip_w + _chip_gap;
draw_set_alpha(0.9);
if (global.player_has_sword) {
    var _cstep = (instance_exists(oPlayer)) ? oPlayer.combo_step : 0;
    var _ctxt = "⚔ [Z] T" + string(global.weapon_tier);
    if (_cstep == 2) _ctxt = "⚔ [Z] Kombo 2";
    if (_cstep == 3) _ctxt = "⚔ [Z] FINISH!";
    
    draw_set_color((_cstep == 3) ? make_color_rgb(75, 36, 15) : make_color_rgb(45, 38, 18));
    draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
    draw_set_color((_cstep == 3) ? make_color_rgb(255, 120, 50) : make_color_rgb(245, 200, 75));
    draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
    draw_set_alpha(1.0);
    draw_set_color((_cstep == 3) ? make_color_rgb(255, 220, 140) : make_color_rgb(255, 225, 110));
    draw_text(_c2_x + _chip_w / 2, _r6_y + _chip_h / 2, _ctxt);
} else {
    draw_set_color(make_color_rgb(28, 30, 38));
    draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
    draw_set_color(make_color_rgb(95, 100, 115));
    draw_roundrect_ext(_c2_x, _r6_y, _c2_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(165, 170, 185));
    draw_text(_c2_x + _chip_w / 2, _r6_y + _chip_h / 2, "✦ [Z] Kosong");
}

// Chip 3: Roll [Space]
var _c3_x = _c2_x + _chip_w + _chip_gap;
var _can_roll = (_cur_sp >= 25);
draw_set_alpha(0.9);
draw_set_color(_can_roll ? make_color_rgb(20, 44, 65) : make_color_rgb(32, 34, 40));
draw_roundrect_ext(_c3_x, _r6_y, _c3_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(_can_roll ? make_color_rgb(88, 175, 240) : make_color_rgb(85, 90, 100));
draw_roundrect_ext(_c3_x, _r6_y, _c3_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);
draw_set_color(_can_roll ? make_color_rgb(160, 225, 255) : make_color_rgb(135, 140, 150));
draw_text(_c3_x + _chip_w / 2, _r6_y + _chip_h / 2, "🌀 [Space]");

// Chip 4: Sihir [X] & Switch [Q]
var _c4_x = _c3_x + _chip_w + _chip_gap;
draw_set_alpha(0.9);
var _sp_text = "✨ [X] Kosong";
var _sp_bg = make_color_rgb(28, 30, 38);
var _sp_border = make_color_rgb(95, 100, 115);
var _sp_col = make_color_rgb(165, 170, 185);

if (global.spell_selected == 1) {
    _sp_text = "🔥 [X] Api";
    _sp_bg = make_color_rgb(60, 25, 15);
    _sp_border = make_color_rgb(255, 120, 50);
    _sp_col = make_color_rgb(255, 210, 140);
} else if (global.spell_selected == 2) {
    _sp_text = "❄ [X] Es";
    _sp_bg = make_color_rgb(18, 45, 65);
    _sp_border = make_color_rgb(90, 190, 255);
    _sp_col = make_color_rgb(180, 235, 255);
}

draw_set_color(_sp_bg);
draw_roundrect_ext(_c4_x, _r6_y, _c4_x + _chip_w, _r6_y + _chip_h, 6, 6, false);
draw_set_color(_sp_border);
draw_roundrect_ext(_c4_x, _r6_y, _c4_x + _chip_w, _r6_y + _chip_h, 6, 6, true);
draw_set_alpha(1.0);
draw_set_color(_sp_col);
draw_text(_c4_x + _chip_w / 2, _r6_y + _chip_h / 2, _sp_text);

// --- Sub-Row 7: Weapon Name & Active Spell Switch Hint ---
var _r7_y = _hud_y + 116;
draw_set_color(make_color_rgb(220, 195, 120));
draw_set_halign(fa_left);
draw_text(_hud_x + 12, _r7_y + 6, "⚔ Senjata: " + global.weapon_name + " (ATK: " + string(scr_get_player_atk()) + ")");

draw_set_halign(fa_right);
draw_set_color(make_color_rgb(160, 215, 255));
draw_text(_hud_x + _hud_w - 12, _r7_y + 6, "[Q] Ganti • Sihir: " + string(scr_get_magic_power()));


// =========================================================================
// 2. ROYAL QUEST SCROLL PLATE (Kanan Atas - Symmetrical 380x104)
// =========================================================================
if (variable_global_exists("quest_title")) {
    var _qw = 380;
    var _qh = 104;
    var _qx = _gw - _qw - 24;
    var _qy = 16;

    // Background Scroll Dark Gothic Obsidian
    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(20, 24, 34));
    draw_roundrect_ext(_qx, _qy, _qx + _qw, _qy + _qh, 12, 12, false);

    // Golden Beveled Outer & Inner Border
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(215, 175, 75));
    draw_roundrect_ext(_qx, _qy, _qx + _qw, _qy + _qh, 12, 12, true);
    draw_set_color(make_color_rgb(90, 75, 45));
    draw_roundrect_ext(_qx + 2, _qy + 2, _qx + _qw - 2, _qy + _qh - 2, 10, 10, true);

    // Brass Corner Rivets
    draw_set_color(make_color_rgb(230, 190, 80));
    draw_circle(_qx + 6, _qy + 6, 1.5, false);
    draw_circle(_qx + _qw - 6, _qy + 6, 1.5, false);
    draw_circle(_qx + 6, _qy + _qh - 6, 1.5, false);
    draw_circle(_qx + _qw - 6, _qy + _qh - 6, 1.5, false);

    // Header Pill: Quest Utama
    var _qr1_y = _qy + 13;
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(60, 44, 20));
    draw_roundrect_ext(_qx + 10, _qr1_y - 6, _qx + 135, _qr1_y + 11, 6, 6, false);
    draw_set_color(make_color_rgb(235, 185, 70));
    draw_roundrect_ext(_qx + 10, _qr1_y - 6, _qx + 135, _qr1_y + 11, 6, 6, true);

    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 220, 90));
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(_qx + 16, _qr1_y + 2, "★ QUEST UTAMA");

    // Stage Pill Indicator (Kanan Atas)
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(26, 45, 68));
    draw_roundrect_ext(_qx + _qw - 90, _qr1_y - 6, _qx + _qw - 10, _qr1_y + 11, 6, 6, false);
    draw_set_color(make_color_rgb(90, 170, 240));
    draw_roundrect_ext(_qx + _qw - 90, _qr1_y - 6, _qx + _qw - 10, _qr1_y + 11, 6, 6, true);

    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(160, 225, 255));
    draw_set_halign(fa_center);
    draw_text(_qx + _qw - 50, _qr1_y + 2, "✦ Aktif");

    // Title Quest
    draw_set_color(make_color_rgb(255, 235, 160));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(_qx + 12, _qy + 30, global.quest_title);

    // Subtext / Petunjuk Objektif Aktif
    draw_set_color(make_color_rgb(205, 215, 230));
    draw_text_ext(_qx + 12, _qy + 52, "▶ " + global.quest_desc, 16, _qw - 24);
}

// =========================================================================
// 3. ROOM LOCATION BANNER (Saat Masuk Ruangan Baru)
// =========================================================================
if (banner_timer > 0) {
    var _b_alpha = (banner_timer > 120) ? (160 - banner_timer) / 40 : ((banner_timer < 30) ? banner_timer / 30 : 1.0);
    var _bw = 480;
    var _bh = 58;
    var _bx = (_gw - _bw) / 2;
    var _by = 168; // Tepat di bawah HUD atas

    draw_set_alpha(_b_alpha * 0.94);
    draw_set_color(make_color_rgb(16, 18, 26));
    draw_roundrect_ext(_bx, _by, _bx + _bw, _by + _bh, 12, 12, false);
    draw_set_color(make_color_rgb(230, 195, 90));
    draw_roundrect_ext(_bx, _by, _bx + _bw, _by + _bh, 12, 12, true);

    draw_set_alpha(_b_alpha);
    draw_set_color(make_color_rgb(255, 225, 120));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_gw / 2, _by + 18, "✧ " + banner_title + " ✧");

    draw_set_color(make_color_rgb(200, 210, 225));
    draw_text(_gw / 2, _by + 40, banner_subtitle);
}

// =========================================================================
// 4. MODAL SHEET: STATUS & ALOKASI STAT [P]
// =========================================================================
if (global.stat_menu_open) {
    // Backdrop blur
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    
    var _mw = 640;
    var _mh = 420;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;
    
    // Panel Kotak Gelap
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(18, 22, 32));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, false);
    draw_set_color(make_color_rgb(220, 175, 75));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, true);
    draw_set_color(make_color_rgb(90, 75, 45));
    draw_roundrect_ext(_mx + 2, _my + 2, _mx + _mw - 2, _my + _mh - 2, 12, 12, true);

    draw_set_alpha(1.0);
    // Header Modal
    draw_set_color(make_color_rgb(255, 220, 100));
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(_gw / 2, _my + 16, "✧ STATUS KSATRIA & TAS PETUALANG ✧");
    
    draw_set_color(make_color_rgb(170, 180, 200));
    draw_text(_gw / 2, _my + 36, "Level: " + string(global.player_level) + "  •  EXP: " + string(global.player_exp) + "/" + string(global.player_max_exp));
    
    // Poin Atribut
    var _pt_col = (global.stat_points > 0) ? make_color_rgb(255, 215, 60) : make_color_rgb(150, 160, 175);
    draw_set_color(_pt_col);
    draw_text(_gw / 2, _my + 54, "✦ Poin Atribut Tersedia: " + string(global.stat_points) + " (Tekan tombol [1-4] untuk alokasi)");

    // Pemisah Garis
    draw_set_color(make_color_rgb(60, 50, 35));
    draw_line(_mx + 20, _my + 78, _mx + _mw - 20, _my + 78);
    draw_line(_mx + _mw / 2, _my + 86, _mx + _mw / 2, _my + 360);

    // --- Kolom Kiri: Atribut & Kemampuan Tempur ---
    var _lx = _mx + 30;
    var _sy = _my + 95;
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 230, 130));
    draw_text(_lx, _sy, "【 ATRIBUT KSATRIA 】");
    
    // VIT
    draw_set_color(make_color_rgb(255, 130, 130));
    draw_text(_lx, _sy + 28, "• VIT (Vitalitas): " + string(global.stat_vit) + "  (+HP & Def)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_lx + 200, _sy + 28, "[1] +1");

    // STR
    draw_set_color(make_color_rgb(255, 180, 100));
    draw_text(_lx, _sy + 54, "• STR (Kekuatan): " + string(global.stat_str) + "  (+Tebasan Pedang)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_lx + 200, _sy + 54, "[2] +1");

    // INT
    draw_set_color(make_color_rgb(120, 200, 255));
    draw_text(_lx, _sy + 80, "• INT (Kecerdasan): " + string(global.stat_int) + "  (+Mana & Sihir)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_lx + 200, _sy + 80, "[3] +1");

    // AGI
    draw_set_color(make_color_rgb(120, 255, 170));
    draw_text(_lx, _sy + 106, "• AGI (Kelincahan): " + string(global.stat_agi) + "  (+Stamina & Roll)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_lx + 200, _sy + 106, "[4] +1");

    // Ringkasan Status
    draw_set_color(make_color_rgb(200, 210, 230));
    draw_text(_lx, _sy + 144, "Serangan Pedang (ATK): " + string(scr_get_player_atk()));
    draw_text(_lx, _sy + 166, "Kekuatan Sihir (Magic): " + string(scr_get_magic_power()));
    draw_text(_lx, _sy + 188, "Senjata: " + global.weapon_name + " (Tier " + string(global.weapon_tier) + ")");
    var _sp_name = (global.spell_selected == 1) ? "Fireball" : ((global.spell_selected == 2) ? "Frost Nova" : "Belum Ada");
    draw_text(_lx, _sy + 210, "Sihir Aktif: " + _sp_name);

    // --- Kolom Kanan: Tas Material & Kunci Eksplorasi ---
    var _rx = _mx + _mw / 2 + 25;
    draw_set_color(make_color_rgb(255, 230, 130));
    draw_text(_rx, _sy, "【 TAS MATERIAL & BAHAN 】");

    draw_set_color(make_color_rgb(120, 240, 140));
    draw_text(_rx, _sy + 28, "🟢 Slime Jelly: " + string(global.mat_slime_jelly) + " buah");

    draw_set_color(make_color_rgb(230, 225, 210));
    draw_text(_rx, _sy + 54, "🦴 Bone Shard (Tulang): " + string(global.mat_bone_shard) + " buah");

    draw_set_color(make_color_rgb(175, 185, 205));
    draw_text(_rx, _sy + 80, "⛓ Scrap Iron (Besi Bekas): " + string(global.mat_scrap_iron) + " buah");

    draw_set_color(make_color_rgb(230, 170, 100));
    draw_text(_rx, _sy + 106, "🪨 Iron Ore (Bijih Besi): " + string(global.mat_iron_ore) + " buah");

    draw_set_color(make_color_rgb(180, 120, 255));
    draw_text(_rx, _sy + 132, "🔮 Magic Crystal (Kristal): " + string(global.mat_magic_crystal) + " buah");

    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_rx, _sy + 168, "🔑 Kunci Ruang Boss: " + (global.has_boss_key ? "✓ SUDAH DIDAPATKAN" : "✕ Belum (Kalahkan Panglima)"));
    draw_text(_rx, _sy + 190, "🚪 Segel Katakombe: " + (global.weapon_tier >= 2 ? "✓ Terbuka (Pedang Tier 2+)" : "✕ Terkunci (Butuh Tier 2)"));

    // Footer Petunjuk
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(160, 175, 195));
    draw_text(_gw / 2, _my + _mh - 32, "Tekan tombol [1] s/d [4] untuk Alokasi Stat  •  Tekan [P] / [ESC] untuk Tutup");
}

// =========================================================================
// 5. MODAL SHEET: BENGKEL TEMPA SENJATA GORAN
// =========================================================================
if (global.shop_menu_open == "goran") {
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    var _mw = 580;
    var _mh = 380;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(26, 20, 16));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, false);
    draw_set_color(make_color_rgb(255, 140, 50));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, true);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 210, 100));
    draw_text(_gw / 2, _my + 16, "⚔ BENGKEL TEMPA GORAN - UPGRADE SENJATA ⚔");

    draw_set_halign(fa_left);
    var _tx = _mx + 35;
    var _ty = _my + 60;

    draw_set_color(make_color_rgb(220, 220, 230));
    draw_text(_tx, _ty, "Senjata Saat Ini: " + global.weapon_name + " (Tier " + string(global.weapon_tier) + ") - ATK " + string(scr_get_player_atk()));

    if (global.weapon_tier == 1) {
        draw_set_color(make_color_rgb(255, 180, 80));
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
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(150, 150, 150));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Bahan belum mencukupi. Farming di Hutan Reruntuhan!");
    } else if (global.weapon_tier == 2) {
        draw_set_color(make_color_rgb(255, 180, 80));
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
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(150, 150, 150));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Bahan belum mencukupi. Jelajahi Katakombe!");
    } else if (global.weapon_tier == 3) {
        draw_set_color(make_color_rgb(255, 180, 80));
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
        draw_set_color(_can_forge ? make_color_rgb(255, 220, 80) : make_color_rgb(150, 150, 150));
        draw_text(_gw / 2, _my + _mh - 75, _can_forge ? "★ SIAP DITEMPA! Tekan [SPACE] Sekarang ★" : "✕ Kalahkan Panglima Tengkorak untuk kristal!");
    } else {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(120, 255, 150));
        draw_text(_gw / 2, _my + 140, "✧ SENJATA TELAH MENCAPAI TINGKAT MAKSIMAL (TIER 4) ✧");
        draw_text(_gw / 2, _my + 170, "Pedangmu siap menghancurkan Golem Penjaga Purba!");
    }

    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(170, 180, 195));
    draw_text(_gw / 2, _my + _mh - 30, "Tekan [SPACE] Tempa  •  Tekan [ESC] / [E] Keluar");
}

// =========================================================================
// 6. MODAL SHEET: TOKO ALKIMIA & GRIMOIRE ELYSIA
// =========================================================================
if (global.shop_menu_open == "elysia") {
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);

    var _mw = 580;
    var _mh = 380;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(15, 25, 35));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, false);
    draw_set_color(make_color_rgb(80, 180, 240));
    draw_roundrect_ext(_mx, _my, _mx + _mw, _my + _mh, 14, 14, true);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(200, 235, 255));
    draw_text(_gw / 2, _my + 16, "⚗ APOTEK HERBAL & GRIMOIRE ELYSIA ⚗");

    draw_set_halign(fa_left);
    var _tx = _mx + 35;
    var _ty = _my + 65;

    // Item 1: Ramuan Darah
    draw_set_color(make_color_rgb(255, 120, 130));
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
    draw_set_color(make_color_rgb(215, 150, 255));
    draw_text(_tx, _ty + 130, "[3] Ramuan Elixir Mana (+3 INT Permanen, +24 Max MP)");
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text(_tx + 20, _ty + 152, "Biaya: 4 Slime Jelly, 2 Magic Crystal, 150 Gold");

    // Tas Singkat
    draw_set_color(make_color_rgb(180, 195, 215));
    draw_text(_tx, _ty + 195, "Bahan Anda: " + string(global.mat_slime_jelly) + " Slime Jelly  •  " + string(global.mat_magic_crystal) + " Magic Crystal");

    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(170, 180, 195));
    draw_text(_gw / 2, _my + _mh - 30, "Tekan tombol [1], [2], atau [3] untuk Membeli  •  Tekan [ESC] / [E] Keluar");
}

// =========================================================================
// 7. SCREEN FADE OVERLAY
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
