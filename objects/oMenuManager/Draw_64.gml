/// @description Draw GUI Event - JRPG Modular Custom Menu (Adapted from MK_UICustomizer)

if (room == rm_main_menu || menu_alpha <= 0.01) exit;

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// 1. Dark Backdrop Overlay
draw_set_alpha(0.78 * menu_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_alpha(menu_alpha);

// Koordinat Layout Responsif
var _top_x = 40;
var _top_y = 22;
var _top_w = _gw - 80;
var _top_h = 44;

var _col_y = _top_y + _top_h + 12;
var _col_h = _gh - _col_y - 42;

var _cmd_w  = 230;
var _hero_w = 345;
var _det_w  = _top_w - _cmd_w - _hero_w - 24;

var _cmd_x  = _top_x;
var _hero_x = _cmd_x + _cmd_w + 12;
var _det_x  = _hero_x + _hero_w + 12;

// =========================================================================
// 2. TOP BAR (HEADER & STATUS RINGKAS)
// =========================================================================
scr_ui_draw_glass_panel(_top_x, _top_y, _top_w, _top_h, make_color_rgb(65, 105, 180), 0.92 * menu_alpha);

// 2.1. Kiri: Siklus Waktu & Kondisi Adik Sestrina
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var _time_str = "Day " + string(variable_global_exists("day_count") ? global.day_count : 1) + " (" + string(variable_global_exists("time_of_day") ? global.time_of_day : "Daytime") + ")";
var _is_day = (variable_global_exists("time_of_day") && global.time_of_day == "Daytime");
draw_set_color(_is_day ? make_color_rgb(255, 205, 80) : make_color_rgb(140, 205, 255));
draw_text_transformed(_top_x + 16, _top_y + _top_h / 2, _time_str, 0.85, 0.85, 0);

var _sis_val = variable_global_exists("sister_condition") ? global.sister_condition : 100;
draw_set_color(make_color_rgb(80, 100, 140));
draw_text_transformed(_top_x + 175, _top_y + _top_h / 2, "|", 0.85, 0.85, 0);
draw_set_color(_sis_val > 50 ? make_color_rgb(120, 240, 150) : (_sis_val > 25 ? make_color_rgb(255, 215, 80) : make_color_rgb(255, 90, 90)));
draw_text_transformed(_top_x + 190, _top_y + _top_h / 2, "Kondisi Adik: " + string(_sis_val) + "% (Mana Leak)", 0.82, 0.82, 0);

// 2.2. Tengah: Nama Lokasi Saat Ini
var _r_raw = room_get_name(room);
var _r_title = "Kamar Tidur Sestrina";
if (_r_raw == "rm_town_square") _r_title = "Alun-Alun Kota Altdorf";
else if (_r_raw == "rm_weapon_shop") _r_title = "Bengkel Pandai Besi Goran";
else if (_r_raw == "rm_potion_shop") _r_title = "Apotek Herbal Elysia";
else if (_r_raw == "rm_outskirts") _r_title = "Pelataran Kuil Purba";
else if (_r_raw == "rm_catacombs") _r_title = "Katakombe Bawah Tanah";
else if (_r_raw == "rm_boss_chamber") _r_title = "Sanctum Core (Altar Lost Remedy)";

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(240, 245, 255));
draw_text_transformed(_top_x + _top_w / 2, _top_y + _top_h / 2, "~ " + _r_title + " ~", 0.95, 0.95, 0);

// 2.3. Kanan: Emas / Gold
draw_set_halign(fa_right);
var _cur_gold = variable_global_exists("gold") ? global.gold : 50;
if (sprite_exists(sItemIcons)) {
    draw_sprite_ext(sItemIcons, 5, _top_x + _top_w - 95, _top_y + _top_h / 2, 0.8, 0.8, 0, c_white, menu_alpha);
}
draw_set_color(make_color_rgb(255, 220, 90));
draw_text_transformed(_top_x + _top_w - 20, _top_y + _top_h / 2, string(_cur_gold) + " Gold", 0.88, 0.88, 0);


// =========================================================================
// 3. KOLOM KIRI: DAFTAR PERINTAH MENU (MK_UICustomizer Command Window)
// =========================================================================
scr_ui_draw_glass_panel(_cmd_x, _col_y, _cmd_w, _col_h, (focus_column == 0) ? make_color_rgb(215, 175, 75) : make_color_rgb(50, 75, 130), 0.92 * menu_alpha);

// Header Perintah
draw_set_color(make_color_rgb(22, 32, 60));
draw_roundrect_ext(_cmd_x + 10, _col_y + 10, _cmd_x + _cmd_w - 10, _col_y + 42, 6, 6, false);
draw_set_color(make_color_rgb(75, 105, 160));
draw_roundrect_ext(_cmd_x + 10, _col_y + 10, _cmd_x + _cmd_w - 10, _col_y + 42, 6, 6, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 230, 110));
draw_text_transformed(_cmd_x + _cmd_w / 2, _col_y + 26, "MENU UTAMA", 0.85, 0.85, 0);

// Render Setiap Item Perintah
var _cmd_start_y = _col_y + 54;
var _cmd_item_h  = 46;
var _cmd_gap     = 6;

for (var _ci = 0; _ci < array_length(commands); _ci++) {
    var _citem = commands[_ci];
    var _iy = _cmd_start_y + _ci * (_cmd_item_h + _cmd_gap);
    var _is_sel = (selected_cmd == _ci);
    
    // Badge alert pada Status jika memiliki poin atribut yang belum dialokasikan
    var _b_text = "";
    if (_citem.id == "status" && variable_global_exists("stat_points") && global.stat_points > 0) {
        _b_text = "!" + string(global.stat_points);
    }
    
    scr_ui_draw_command_item(_cmd_x + 10, _iy, _cmd_w - 20, _cmd_item_h, _citem.icon, _citem.name, _is_sel, true, _b_text);
}


// =========================================================================
// 4. KOLOM TENGAH: KARTU PROFIL & STATUS HERO (MK_UICustomizer Actor Window)
// =========================================================================
scr_ui_draw_glass_panel(_hero_x, _col_y, _hero_w, _col_h, make_color_rgb(50, 75, 130), 0.92 * menu_alpha);

// 4.1. Box Portrait Hero (192x192 Pixel Art)
var _port_w = 192;
var _port_h = 192;
var _port_x = _hero_x + (_hero_w - _port_w) / 2;
var _port_y = _col_y + 16;

draw_set_color(make_color_rgb(18, 25, 48));
draw_roundrect_ext(_port_x - 3, _port_y - 3, _port_x + _port_w + 3, _port_y + _port_h + 3, 10, 10, false);
draw_set_color(make_color_rgb(215, 175, 75));
draw_roundrect_ext(_port_x - 3, _port_y - 3, _port_x + _port_w + 3, _port_y + _port_h + 3, 10, 10, true);
draw_set_color(make_color_rgb(45, 65, 110));
draw_roundrect_ext(_port_x - 1, _port_y - 1, _port_x + _port_w + 1, _port_y + _port_h + 1, 8, 8, true);

if (sprite_exists(sHeroPortrait)) {
    // sHeroPortrait origin is (96, 96) Center!
    draw_sprite(sHeroPortrait, 0, _port_x + 96, _port_y + 96);
}

// 4.2. Info Nama & Gelar Hero
var _info_y = _port_y + _port_h + 14;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 230, 120));
draw_text_transformed(_hero_x + _hero_w / 2, _info_y, "SESTRINA", 1.05, 1.05, 0);

draw_set_color(make_color_rgb(140, 185, 240));
draw_text_transformed(_hero_x + _hero_w / 2, _info_y + 18, "Ksatria Altdorf • Tingkat " + string(variable_global_exists("player_level") ? global.player_level : 1), 0.78, 0.78, 0);

// 4.3. Bar EXP (Progres Level)
var _exp_y = _info_y + 36;
var _cur_exp = variable_global_exists("player_exp") ? global.player_exp : 0;
var _max_exp = variable_global_exists("player_max_exp") ? global.player_max_exp : 60;
scr_ui_draw_gauge(_hero_x + 18, _exp_y, _hero_w - 36, 16, "EXP", _cur_exp, _max_exp, make_color_rgb(160, 95, 240), make_color_rgb(220, 180, 255), make_color_rgb(45, 30, 75));

// 4.4. Tiga Bar Sumber Daya Utama (HP, MP, Stamina)
var _bar_y = _exp_y + 26;
var _cur_hp  = variable_global_exists("player_hp") ? global.player_hp : 120;
var _max_hp  = variable_global_exists("player_max_hp") ? global.player_max_hp : 120;
var _cur_mp  = variable_global_exists("player_mp") ? global.player_mp : 80;
var _max_mp  = variable_global_exists("player_max_mp") ? global.player_max_mp : 80;
var _cur_sta = variable_global_exists("player_stamina") ? global.player_stamina : 100;
var _max_sta = variable_global_exists("player_max_stamina") ? global.player_max_stamina : 100;

// Bar HP
scr_ui_draw_gauge(_hero_x + 18, _bar_y, _hero_w - 36, 18, "HP", _cur_hp, _max_hp, make_color_rgb(235, 60, 75), make_color_rgb(255, 140, 150), make_color_rgb(70, 20, 30));
// Bar MP
scr_ui_draw_gauge(_hero_x + 18, _bar_y + 25, _hero_w - 36, 18, "MP", _cur_mp, _max_mp, make_color_rgb(45, 175, 245), make_color_rgb(130, 225, 255), make_color_rgb(20, 50, 90));
// Bar Stamina
scr_ui_draw_gauge(_hero_x + 18, _bar_y + 50, _hero_w - 36, 18, "STA", _cur_sta, _max_sta, make_color_rgb(50, 210, 120), make_color_rgb(140, 250, 180), make_color_rgb(20, 65, 40));

// 4.5. Ringkasan Senjata & Zirah
var _gear_box_y = _bar_y + 82;
var _gear_box_h = 68;
draw_set_color(make_color_rgb(18, 26, 48));
draw_roundrect_ext(_hero_x + 18, _gear_box_y, _hero_x + _hero_w - 18, _gear_box_y + _gear_box_h, 8, 8, false);
draw_set_color(make_color_rgb(45, 65, 110));
draw_roundrect_ext(_hero_x + 18, _gear_box_y, _hero_x + _hero_w - 18, _gear_box_y + _gear_box_h, 8, 8, true);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 215, 80));
draw_text_transformed(_hero_x + 30, _gear_box_y + 20, "Senjata: ", 0.8, 0.8, 0);
draw_set_color(c_white);
var _wpn_name = variable_global_exists("weapon_name") ? global.weapon_name : "Tangan Kosong";
var _wpn_tier = variable_global_exists("weapon_tier") ? global.weapon_tier : 0;
draw_text_transformed(_hero_x + 95, _gear_box_y + 20, _wpn_name + " (T" + string(_wpn_tier) + ")", 0.8, 0.8, 0);

draw_set_color(make_color_rgb(255, 215, 80));
draw_text_transformed(_hero_x + 30, _gear_box_y + 46, "Zirah: ", 0.8, 0.8, 0);
draw_set_color(c_white);
var _arm_name = variable_global_exists("armor_name") ? global.armor_name : "Zirah Ksatria";
draw_text_transformed(_hero_x + 95, _gear_box_y + 46, _arm_name, 0.8, 0.8, 0);

// 4.6. Sub-Card Companion (Goran Blacksmith) jika bergabung di Party
if (variable_global_exists("party_goran") && global.party_goran) {
    var _comp_y = _gear_box_y + _gear_box_h + 10;
    var _comp_h = 58;
    draw_set_color(make_color_rgb(24, 30, 52));
    draw_roundrect_ext(_hero_x + 18, _comp_y, _hero_x + _hero_w - 18, _comp_y + _comp_h, 8, 8, false);
    draw_set_color(make_color_rgb(215, 150, 60));
    draw_roundrect_ext(_hero_x + 18, _comp_y, _hero_x + _hero_w - 18, _comp_y + _comp_h, 8, 8, true);
    
    // Ikon Portrait Goran
    if (sprite_exists(sPortrait_Goran)) {
        draw_sprite_ext(sPortrait_Goran, 0, _hero_x + 46, _comp_y + _comp_h / 2, 0.28, 0.28, 0, c_white, menu_alpha);
    }
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 220, 110));
    draw_text_transformed(_hero_x + 75, _comp_y + 18, "Goran (Companion)", 0.8, 0.8, 0);
    
    var _g_hp = variable_global_exists("goran_hp") ? global.goran_hp : 300;
    var _g_max = variable_global_exists("goran_max_hp") ? global.goran_max_hp : 300;
    scr_ui_draw_gauge(_hero_x + 75, _comp_y + 32, _hero_w - 105, 14, "HP", _g_hp, _g_max, make_color_rgb(235, 80, 60), c_white, make_color_rgb(70, 30, 30));
}


// =========================================================================
// 5. KOLOM KANAN: DYNAMIC DETAIL PANEL (MK_UICustomizer Sub-Window)
// =========================================================================
var _panel_border_col = (focus_column == 1) ? make_color_rgb(215, 175, 75) : make_color_rgb(50, 75, 130);
scr_ui_draw_glass_panel(_det_x, _col_y, _det_w, _col_h, _panel_border_col, 0.92 * menu_alpha);

var _cur_cmd_id = commands[selected_cmd].id;

// Header Tab Kanan
draw_set_color(make_color_rgb(22, 32, 60));
draw_roundrect_ext(_det_x + 12, _col_y + 10, _det_x + _det_w - 12, _col_y + 42, 6, 6, false);
draw_set_color(make_color_rgb(75, 105, 160));
draw_roundrect_ext(_det_x + 12, _col_y + 10, _det_x + _det_w - 12, _col_y + 42, 6, 6, true);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 230, 110));
draw_text_transformed(_det_x + 24, _col_y + 26, string_upper(commands[selected_cmd].name), 0.88, 0.88, 0);

draw_set_halign(fa_right);
draw_set_color(make_color_rgb(160, 190, 240));
draw_text_transformed(_det_x + _det_w - 24, _col_y + 26, commands[selected_cmd].desc, 0.72, 0.72, 0);

var _body_y = _col_y + 54;
var _body_h = _col_h - 66;

// -------------------------------------------------------------------------
// TAB 5.1: STATUS & ATRIBUT KSATRIA
// -------------------------------------------------------------------------
if (_cur_cmd_id == "status") {
    // 1. Box Atribut Poin
    var _abox_h = 240;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _abox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _abox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 28, _body_y + 18, "ALOKASI POIN ATRIBUT:", 0.82, 0.82, 0);
    
    var _pts = variable_global_exists("stat_points") ? global.stat_points : 0;
    draw_set_halign(fa_right);
    draw_set_color(_pts > 0 ? make_color_rgb(255, 230, 70) : make_color_rgb(160, 175, 205));
    draw_text_transformed(_det_x + _det_w - 28, _body_y + 18, "Poin Tersedia: " + string(_pts), 0.85, 0.85, 0);
    
    var _anames = ["VIT (Vitalitas)", "STR (Kekuatan)", "INT (Kecerdasan)", "AGI (Kelincahan)"];
    var _adescs = ["+8 Max HP & Pertahanan Fisik", "+Daya Tebasan Kombo Pedang Fisik", "+8 Max MP & Daya Sihir", "+4 Max Stamina & Kecepatan Roll"];
    var _avals  = [global.stat_vit, global.stat_str, global.stat_int, global.stat_agi];
    
    var _ay_start = _body_y + 54;
    var _ay_step  = 44;
    
    for (var _ai = 0; _ai < 4; _ai++) {
        var _ry = _ay_start + _ai * _ay_step;
        var _is_sub_sel = (focus_column == 1 && detail_sub_index == _ai);
        
        if (_is_sub_sel) {
            draw_set_alpha(0.2);
            draw_set_color(make_color_rgb(255, 215, 80));
            draw_rectangle(_det_x + 20, _ry - 18, _det_x + _det_w - 20, _ry + 18, false);
            draw_set_alpha(1.0);
        }
        
        if (sprite_exists(sStatBadges)) {
            draw_sprite(sStatBadges, _ai, _det_x + 38, _ry);
        }
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_bottom);
        draw_set_color(_is_sub_sel ? make_color_rgb(255, 235, 140) : c_white);
        draw_text_transformed(_det_x + 64, _ry - 1, _anames[_ai], 0.85, 0.85, 0);
        
        draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(140, 165, 205));
        draw_text_transformed(_det_x + 64, _ry + 2, _adescs[_ai], 0.72, 0.72, 0);
        
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(255, 225, 90));
        draw_text_transformed(_det_x + _det_w - 85, _ry, string(_avals[_ai]), 0.95, 0.95, 0);
        
        // Tombol [+]
        var _bx = _det_x + _det_w - 65;
        var _by = _ry - 12;
        var _bsize = 24;
        draw_set_color(_pts > 0 ? (_is_sub_sel ? make_color_rgb(255, 210, 60) : make_color_rgb(180, 135, 40)) : make_color_rgb(45, 55, 80));
        draw_roundrect_ext(_bx, _by, _bx + _bsize, _by + _bsize, 4, 4, false);
        draw_set_color(_pts > 0 ? c_white : make_color_rgb(120, 130, 160));
        draw_set_halign(fa_center);
        draw_text_transformed(_bx + _bsize / 2, _by + _bsize / 2, "+", 0.88, 0.88, 0);
    }
    
    // 2. Box Statistik Tempur Efektif
    var _cbox_y = _body_y + _abox_h + 14;
    var _cbox_h = 130;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _cbox_y, _det_x + _det_w - 14, _cbox_y + _cbox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _cbox_y, _det_x + _det_w - 14, _cbox_y + _cbox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 28, _cbox_y + 18, "PARAMETRIKAL TEMPUR EFEKTIF:", 0.82, 0.82, 0);
    
    // Grid 2x2 Combat Stats
    var _cs_y1 = _cbox_y + 50;
    var _cs_y2 = _cbox_y + 90;
    var _mid_x = _det_x + _det_w / 2;
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 0, _det_x + 40, _cs_y1);
    draw_set_color(c_white);
    draw_text_transformed(_det_x + 60, _cs_y1, "ATK Fisik: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(255, 230, 110));
    draw_text_transformed(_det_x + 140, _cs_y1, string(scr_get_player_atk()), 0.88, 0.88, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 1, _mid_x + 20, _cs_y1);
    draw_set_color(c_white);
    draw_text_transformed(_mid_x + 40, _cs_y1, "Daya Sihir: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(130, 215, 255));
    draw_text_transformed(_mid_x + 130, _cs_y1, string(scr_get_magic_power()), 0.88, 0.88, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 2, _det_x + 40, _cs_y2);
    draw_set_color(c_white);
    draw_text_transformed(_det_x + 60, _cs_y2, "Pertahanan: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(200, 220, 245));
    draw_text_transformed(_det_x + 155, _cs_y2, string(global.stat_vit * 2), 0.88, 0.88, 0);
    
    if (sprite_exists(sCombatIcons)) draw_sprite(sCombatIcons, 3, _mid_x + 20, _cs_y2);
    draw_set_color(c_white);
    draw_text_transformed(_mid_x + 40, _cs_y2, "Critical Rate: ", 0.82, 0.82, 0);
    draw_set_color(make_color_rgb(255, 180, 220));
    draw_text_transformed(_mid_x + 145, _cs_y2, string(5 + floor(global.stat_agi * 0.4)) + "%", 0.88, 0.88, 0);
    
    // 3. 4 Slot Perlengkapan
    var _eq_y = _cbox_y + _cbox_h + 14;
    var _eq_h = 90;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _eq_y, _det_x + _det_w - 14, _eq_y + _eq_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _eq_y, _det_x + _det_w - 14, _eq_y + _eq_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 28, _eq_y + 18, "SLOT KELENGKAPAN TERPASANG:", 0.82, 0.82, 0);
    
    var _slot_cy = _eq_y + 54;
    var _slot_gap = (_det_w - 80) / 4;
    var _slot_labels = ["Senjata", "Zirah", "Aksesori", "Relik"];
    for (var _si = 0; _si < 4; _si++) {
        var _scx = _det_x + 50 + _si * _slot_gap;
        if (sprite_exists(sEquipmentSlots)) {
            draw_sprite(sEquipmentSlots, _si, _scx, _slot_cy);
        }
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(180, 205, 240));
        draw_text_transformed(_scx, _slot_cy + 22, _slot_labels[_si], 0.7, 0.7, 0);
    }
}

// -------------------------------------------------------------------------
// TAB 5.2: KANTONG & BAHAN TEMPA (INVENTORY)
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "items") {
    // 1. Box Ramuan Penyembuh (Consumable)
    var _pot_h = 100;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _pot_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _pot_h, 8, 8, true);
    
    if (sprite_exists(sItemIcons)) {
        draw_sprite_ext(sItemIcons, 6, _det_x + 50, _body_y + _pot_h / 2, 1.4, 1.4, 0, c_white, menu_alpha);
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 230, 110));
    draw_text_transformed(_det_x + 85, _body_y + 28, "Ramuan Penyembuh Altdorf", 0.95, 0.95, 0);
    
    draw_set_color(make_color_rgb(180, 205, 235));
    draw_text_transformed(_det_x + 85, _body_y + 52, "Memulihkan 60 HP secara instan. Tekan [C] saat menjelajah.", 0.75, 0.75, 0);
    
    var _cur_pots = variable_global_exists("player_potions") ? global.player_potions : 1;
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(100, 240, 140));
    draw_text_transformed(_det_x + _det_w - 30, _body_y + _pot_h / 2, string(_cur_pots) + " / 5 Botol", 0.92, 0.92, 0);
    
    // 2. Box Material Tempa & Alkimia
    var _mat_y = _body_y + _pot_h + 16;
    var _mat_h = 240;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _mat_y, _det_x + _det_w - 14, _mat_y + _mat_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _mat_y, _det_x + _det_w - 14, _mat_y + _mat_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 28, _mat_y + 20, "MATERIAL TEMPA & ALKIMIA:", 0.85, 0.85, 0);
    
    var _mat_data = [
        { name: "Slime Jelly",    count: global.mat_slime_jelly,    icon: 0, desc: "Zat kental dari monster Slime liar di Outskirts." },
        { name: "Bone Shard",     count: global.mat_bone_shard,     icon: 3, desc: "Serpihan tulang kuno dari Skeleton Katakombe." },
        { name: "Scrap Iron",     count: global.mat_scrap_iron,     icon: 1, desc: "Besi bekas dari reruntuhan perlengkapan perang." },
        { name: "Iron Ore",       count: global.mat_iron_ore,       icon: 4, desc: "Bijih besi murni hasil menambang nodus batu." },
        { name: "Magic Crystal",  count: global.mat_magic_crystal,  icon: 2, desc: "Kristal padat energi mana untuk memperkuat mantra." }
    ];
    
    var _my_start = _mat_y + 54;
    for (var _mi = 0; _mi < array_length(_mat_data); _mi++) {
        var _mitem = _mat_data[_mi];
        var _row_y = _my_start + _mi * 36;
        
        if (sprite_exists(sItemIcons)) {
            draw_sprite(sItemIcons, _mitem.icon, _det_x + 38, _row_y);
        }
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_text_transformed(_det_x + 58, _row_y, _mitem.name, 0.82, 0.82, 0);
        
        draw_set_color(make_color_rgb(140, 160, 190));
        draw_text_transformed(_det_x + 180, _row_y, "- " + _mitem.desc, 0.7, 0.7, 0);
        
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(255, 225, 90));
        draw_text_transformed(_det_x + _det_w - 30, _row_y, string(_mitem.count) + "x", 0.85, 0.85, 0);
    }
    
    // 3. Box Benda Pusaka & Kunci Dungeon
    var _key_y = _mat_y + _mat_h + 16;
    var _key_h = 110;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _key_y, _det_x + _det_w - 14, _key_y + _key_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _key_y, _det_x + _det_w - 14, _key_y + _key_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 28, _key_y + 20, "KUNCI DUNGEON & PUSAKA:", 0.85, 0.85, 0);
    
    var _k1_got = (variable_global_exists("has_catacomb_key") && global.has_catacomb_key);
    var _k2_got = (variable_global_exists("has_boss_key") && global.has_boss_key);
    var _k3_got = (variable_global_exists("player_has_remedy") && global.player_has_remedy);
    
    draw_set_color(_k1_got ? make_color_rgb(100, 240, 140) : make_color_rgb(120, 130, 150));
    draw_text_transformed(_det_x + 28, _key_y + 48, "[ " + (_k1_got ? "V" : "X") + " ] Kunci Katakombe", 0.78, 0.78, 0);
    
    draw_set_color(_k2_got ? make_color_rgb(100, 240, 140) : make_color_rgb(120, 130, 150));
    draw_text_transformed(_det_x + 230, _key_y + 48, "[ " + (_k2_got ? "V" : "X") + " ] Kunci Kuil Boss", 0.78, 0.78, 0);
    
    draw_set_color(_k3_got ? make_color_rgb(255, 215, 80) : make_color_rgb(120, 130, 150));
    draw_text_transformed(_det_x + 28, _key_y + 78, "[ " + (_k3_got ? "V" : "X") + " ] The Lost Remedy (Pusaka Kesembuhan)", 0.82, 0.82, 0);
}

// -------------------------------------------------------------------------
// TAB 5.3: SIHIR & MANTRA (MAGIC)
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "magic") {
    var _sp1_unlocked = variable_global_exists("spell_unlocked_fireball") && global.spell_unlocked_fireball;
    var _sp2_unlocked = variable_global_exists("spell_unlocked_frost") && global.spell_unlocked_frost;
    var _sp_sel = variable_global_exists("spell_selected") ? global.spell_selected : 0;
    
    // Card Mantra 1: Fireball
    var _s1_y = _body_y;
    var _s1_h = 130;
    var _s1_focus = (focus_column == 1 && detail_sub_index == 0);
    draw_set_color(_s1_focus ? make_color_rgb(32, 40, 70) : make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _s1_y, _det_x + _det_w - 14, _s1_y + _s1_h, 8, 8, false);
    draw_set_color((_sp_sel == 1) ? make_color_rgb(255, 140, 40) : (_s1_focus ? make_color_rgb(255, 215, 80) : make_color_rgb(50, 75, 130)));
    draw_roundrect_ext(_det_x + 14, _s1_y, _det_x + _det_w - 14, _s1_y + _s1_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(_sp1_unlocked ? make_color_rgb(255, 140, 50) : make_color_rgb(140, 140, 150));
    draw_text_transformed(_det_x + 30, _s1_y + 26, "Mantra Api: Bola Api Purba (Fireball)", 0.95, 0.95, 0);
    
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(100, 205, 255));
    draw_text_transformed(_det_x + _det_w - 30, _s1_y + 26, "Biaya: 20 MP", 0.85, 0.85, 0);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(220, 230, 245));
    draw_text_transformed(_det_x + 30, _s1_y + 60, "Melontarkan proyektil api lurus yang membakar musuh dan nodus rapuh.", 0.78, 0.78, 0);
    
    draw_set_color(_sp_sel == 1 ? make_color_rgb(100, 240, 140) : make_color_rgb(180, 190, 210));
    draw_text_transformed(_det_x + 30, _s1_y + 94, "Status: " + (_sp1_unlocked ? (_sp_sel == 1 ? "[AKTIF DIGUNAKAN - TEKAN X DI GAME]" : "[TERBUKA - TEKAN Z UNTUK MEMILIH]") : "[TERKUNCI - PELAJARI DARI APOTEK ELYSIA]"), 0.78, 0.78, 0);
    
    // Card Mantra 2: Frost Nova
    var _s2_y = _s1_y + _s1_h + 18;
    var _s2_h = 130;
    var _s2_focus = (focus_column == 1 && detail_sub_index == 1);
    draw_set_color(_s2_focus ? make_color_rgb(32, 40, 70) : make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _s2_y, _det_x + _det_w - 14, _s2_y + _s2_h, 8, 8, false);
    draw_set_color((_sp_sel == 2) ? make_color_rgb(50, 180, 255) : (_s2_focus ? make_color_rgb(255, 215, 80) : make_color_rgb(50, 75, 130)));
    draw_roundrect_ext(_det_x + 14, _s2_y, _det_x + _det_w - 14, _s2_y + _s2_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_color(_sp2_unlocked ? make_color_rgb(80, 210, 255) : make_color_rgb(140, 140, 150));
    draw_text_transformed(_det_x + 30, _s2_y + 26, "Mantra Es: Ledakan Embun Beku (Frost Nova)", 0.95, 0.95, 0);
    
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(100, 205, 255));
    draw_text_transformed(_det_x + _det_w - 30, _s2_y + 26, "Biaya: 35 MP", 0.85, 0.85, 0);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(220, 230, 245));
    draw_text_transformed(_det_x + 30, _s2_y + 60, "Membekukan area sekeliling dan menghentikan pergerakan musuh seketika.", 0.78, 0.78, 0);
    
    draw_set_color(_sp_sel == 2 ? make_color_rgb(100, 240, 140) : make_color_rgb(180, 190, 210));
    draw_text_transformed(_det_x + 30, _s2_y + 94, "Status: " + (_sp2_unlocked ? (_sp_sel == 2 ? "[AKTIF DIGUNAKAN - TEKAN X DI GAME]" : "[TERBUKA - TEKAN Z UNTUK MEMILIH]") : "[TERKUNCI - PELAJARI DARI APOTEK ELYSIA]"), 0.78, 0.78, 0);
}

// -------------------------------------------------------------------------
// TAB 5.4: JURNAL QUEST & ALUR CERITA
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "quest") {
    var _q_title = variable_global_exists("quest_title") ? global.quest_title : "Pencarian The Lost Remedy";
    var _q_desc  = variable_global_exists("quest_desc") ? global.quest_desc : "Periksa kondisi Sestrina di ranjang.";
    var _q_stage = variable_global_exists("quest_stage") ? global.quest_stage : 0;
    
    // Panel Misi Utama
    var _qbox_h = 160;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _qbox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _qbox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 30, _body_y + 24, "MISI UTAMA: " + _q_title, 0.95, 0.95, 0);
    
    draw_set_color(make_color_rgb(240, 245, 255));
    draw_text_ext_transformed(_det_x + 30, _body_y + 62, _q_desc, 22, _det_w - 60, 0.85, 0.85, 0);
    
    // Alur Tahapan Quest (0 s/d 5)
    var _steps_y = _body_y + _qbox_h + 18;
    var _steps_h = 240;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _steps_y, _det_x + _det_w - 14, _steps_y + _steps_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _steps_y, _det_x + _det_w - 14, _steps_y + _steps_h, 8, 8, true);
    
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 30, _steps_y + 20, "TAHAPAN PETUALANGAN SESTRINA:", 0.85, 0.85, 0);
    
    var _stages_text = [
        "0. Awal Mula: Periksa Sestrina yang terbaring lemas akibat Overclock Mana.",
        "1. Kota Altdorf: Tempa senjata di Bengkel Goran & ramu obat di Apotek Elysia.",
        "2. Menuju Outskirts: Tembus rimbun hutan luar kota & hadapi kawanan monster.",
        "3. Katakombe Purba: Buka gerbang bawah tanah & hadapi Mini-Boss Stone Golem.",
        "4. Sanctum Core: Buka segel Altar Purba & kalahkan Legendary Guardian.",
        "5. The Lost Remedy: Rebut pusaka obat penawar & selamatkan adik Sestrina!"
    ];
    
    for (var _si = 0; _si < array_length(_stages_text); _si++) {
        var _sy = _steps_y + 50 + _si * 30;
        var _is_cur  = (_q_stage == _si);
        var _is_done = (_q_stage > _si);
        
        draw_set_color(_is_cur ? make_color_rgb(255, 225, 90) : (_is_done ? make_color_rgb(100, 240, 140) : make_color_rgb(130, 145, 175)));
        draw_text_transformed(_det_x + 30, _sy, (_is_done ? "[SELESAI] " : (_is_cur ? "[AKTIF]   " : "[BELUM]   ")) + _stages_text[_si], 0.76, 0.76, 0);
    }
}

// -------------------------------------------------------------------------
// TAB 5.5: PETA DISTRIK & PANDUAN AREA
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "map") {
    var _mbox_h = 360;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _mbox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _mbox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 30, _body_y + 24, "PETA DISTRIK & PERJALANAN ALTDORF", 0.95, 0.95, 0);
    
    draw_set_color(make_color_rgb(220, 235, 255));
    draw_text_transformed(_det_x + 30, _body_y + 54, "Wilayah yang dapat dijelajahi sepanjang pencarian The Lost Remedy:", 0.8, 0.8, 0);
    
    var _districts = [
        "1. Secluded Cabin      : Kamar tidur peristirahatan adik Sestrina.",
        "2. Downtown Plaza      : Alun-alun kota Altdorf, air mancur, papan guild & kedai.",
        "3. Craftsmen District  : Bengkel pandai besi Goran & laboratorium Elysia.",
        "4. Sanctum Outskirts   : Hutan rimba batas kota penuh Slime dan sarang monster.",
        "5. Forgotten Catacombs : Lorong pemakaman bawah tanah purba dan pintu segel.",
        "6. The Sanctum Core    : Ruang suci altar penawar The Lost Remedy (Stone Golem)."
    ];
    
    for (var _di = 0; _di < array_length(_districts); _di++) {
        draw_set_color(make_color_rgb(180, 210, 245));
        draw_text_transformed(_det_x + 30, _body_y + 90 + _di * 32, _districts[_di], 0.78, 0.78, 0);
    }
    
    // Tombol Masuk Peta Interaktif
    var _pbtn_y = _body_y + 300;
    draw_set_color(make_color_rgb(32, 55, 95));
    draw_roundrect_ext(_det_x + 30, _pbtn_y, _det_x + _det_w - 30, _pbtn_y + 44, 6, 6, false);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_roundrect_ext(_det_x + 30, _pbtn_y, _det_x + _det_w - 30, _pbtn_y + 44, 6, 6, true);
    
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_text_transformed(_det_x + _det_w / 2, _pbtn_y + 22, "TEKAN [Z] UNTUK MEMBUKA PETA ISOMETRIK PENUH", 0.85, 0.85, 0);
}

// -------------------------------------------------------------------------
// TAB 5.6: SIMPAN & MUAT PERMAINAN (SAVE / LOAD)
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "save") {
    var _sbox_y = _body_y;
    var _num_s = array_length(save_slots);
    
    for (var _si = 0; _si < _num_s; _si++) {
        var _sinfo = (array_length(save_slots_cache) > _si) ? save_slots_cache[_si] : { exists: false, room_title: "Slot Kosong", time_str: "-", level_str: "-" };
        var _srow_y = _sbox_y + _si * 88;
        var _is_cur_slot = (focus_column == 1 && detail_sub_index == _si);
        
        draw_set_color(_is_cur_slot ? make_color_rgb(32, 45, 78) : make_color_rgb(18, 25, 48));
        draw_roundrect_ext(_det_x + 14, _srow_y, _det_x + _det_w - 14, _srow_y + 76, 8, 8, false);
        draw_set_color(_is_cur_slot ? make_color_rgb(255, 215, 80) : make_color_rgb(45, 65, 110));
        draw_roundrect_ext(_det_x + 14, _srow_y, _det_x + _det_w - 14, _srow_y + 76, 8, 8, true);
        
        // Judul Slot
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(_is_cur_slot ? make_color_rgb(255, 235, 120) : make_color_rgb(215, 175, 75));
        draw_text_transformed(_det_x + 28, _srow_y + 22, save_slots[_si].title + ": " + _sinfo.room_title, 0.88, 0.88, 0);
        
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(160, 190, 235));
        draw_text_transformed(_det_x + _det_w - 28, _srow_y + 22, _sinfo.time_str, 0.78, 0.78, 0);
        
        draw_set_halign(fa_left);
        draw_set_color(_sinfo.exists ? make_color_rgb(230, 240, 255) : make_color_rgb(130, 140, 160));
        draw_text_transformed(_det_x + 28, _srow_y + 50, _sinfo.level_str, 0.78, 0.78, 0);
    }
    
    // Petunjuk Hotkey Save
    var _hint_y = _sbox_y + _num_s * 88 + 14;
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(255, 220, 110));
    draw_text_transformed(_det_x + _det_w / 2, _hint_y, "[Z] Simpan Permainan  •  [L] Muat Permainan  •  [Del] Hapus Slot", 0.82, 0.82, 0);
}

// -------------------------------------------------------------------------
// TAB 5.6B: PENGATURAN GAME (Settings)
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "settings") {
    var _sbox_h = 320;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _sbox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _sbox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 30, _body_y + 24, "⚙ PENGATURAN SUARA & TAMPILAN", 0.95, 0.95, 0);

    var _setting_items = [
        ["Volume Musik (BGM)", string(round(global.bgm_volume * 100)) + " %"],
        ["Volume Efek Suara (SFX)", string(round(global.sfx_volume * 100)) + " %"],
        ["Mode Tampilan", global.is_fullscreen ? "[ Layar Penuh ]" : "[ Jendela (Windowed) ]"]
    ];

    for (var _si = 0; _si < array_length(_setting_items); _si++) {
        var _s_y = _body_y + 70 + _si * 50;
        var _is_s = (focus_column == 1 && detail_sub_index == _si);

        if (_is_s) {
            draw_set_alpha(0.35);
            draw_set_color(make_color_rgb(80, 140, 240));
            draw_roundrect_ext(_det_x + 24, _s_y - 18, _det_x + _det_w - 24, _s_y + 18, 6, 6, false);
            draw_set_alpha(1.0);
            draw_set_color(make_color_rgb(255, 215, 90));
            draw_roundrect_ext(_det_x + 24, _s_y - 18, _det_x + _det_w - 24, _s_y + 18, 6, 6, true);
        }

        draw_set_alpha(1.0);
        draw_set_color(_is_s ? make_color_rgb(255, 240, 180) : make_color_rgb(210, 225, 250));
        draw_text_transformed(_det_x + 36, _s_y, (_is_s ? "▶ " : "  ") + _setting_items[_si][0], 0.85, 0.85, 0);

        draw_set_halign(fa_right);
        draw_set_color(_is_s ? make_color_rgb(255, 215, 90) : make_color_rgb(160, 205, 245));
        if (_si < 2) {
            draw_text_transformed(_det_x + _det_w - 36, _s_y, "◀  " + _setting_items[_si][1] + "  ▶", 0.85, 0.85, 0);
        } else {
            draw_text_transformed(_det_x + _det_w - 36, _s_y, _setting_items[_si][1], 0.85, 0.85, 0);
        }
        draw_set_halign(fa_left);
    }

    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(160, 185, 220));
    draw_text_transformed(_det_x + _det_w / 2, _body_y + 250, "[A/D/←/→] Ubah Nilai    •    [W/S/↑/↓] Pilih    •    [Tab/Esc] Kembali", 0.8, 0.8, 0);
}

// -------------------------------------------------------------------------
// TAB 5.7: PANDUAN KONTROL & PENGATURAN
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "controls") {
    var _cbox_h = 380;
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _cbox_h, 8, 8, false);
    draw_set_color(make_color_rgb(45, 65, 110));
    draw_roundrect_ext(_det_x + 14, _body_y, _det_x + _det_w - 14, _body_y + _cbox_h, 8, 8, true);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_text_transformed(_det_x + 30, _body_y + 24, "PANDUAN KONTROL ARPG SESTRINA", 0.95, 0.95, 0);
    
    var _ctrl_list = [
        ["WASD / Tombol Panah", "Pergerakan Ksatria di dunia game."],
        ["Tombol [Z]",           "Serangan Pedang Kombo (1-2-3) & Interaksi Objek / Dialog."],
        ["Tombol [Shift]",       "Roll / Dash menghindar cepat (memerlukan Stamina)."],
        ["Tombol [X]",           "Menembakkan Sihir Terpilih (Fireball / Frost Nova)."],
        ["Tombol [C]",           "Meminum Ramuan Pemulih HP seketika."],
        ["Tombol [Tab] / [Esc]", "Membuka & Menutup Menu Utama JRPG ini."],
        ["Tombol [M]",           "Membuka Peta Isometrik Distrik Kota Altdorf."],
        ["Tombol [F5] / [F6]",   "Quick Save & Quick Load instan."]
    ];
    
    for (var _ci = 0; _ci < array_length(_ctrl_list); _ci++) {
        var _cy = _body_y + 60 + _ci * 36;
        
        draw_set_color(make_color_rgb(255, 220, 110));
        draw_text_transformed(_det_x + 30, _cy, _ctrl_list[_ci][0], 0.85, 0.85, 0);
        
        draw_set_color(make_color_rgb(220, 235, 255));
        draw_text_transformed(_det_x + 230, _cy, ": " + _ctrl_list[_ci][1], 0.8, 0.8, 0);
    }
}

// -------------------------------------------------------------------------
// TAB 5.8: KEMBALI MAIN
// -------------------------------------------------------------------------
else if (_cur_cmd_id == "close") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 225, 110));
    draw_text_transformed(_det_x + _det_w / 2, _body_y + 120, "Tekan [Z] atau [Esc] untuk kembali melanjutkan petualangan.", 0.95, 0.95, 0);
}


// =========================================================================
// 6. FLOATING TOAST NOTIFICATION MESSAGE
// =========================================================================
if (menu_toast_timer > 0) {
    var _toast_w = string_width(menu_toast_text) * 0.9 + 40;
    var _toast_h = 36;
    var _toast_x = _gw / 2 - _toast_w / 2;
    var _toast_y = _top_y + _top_h + 16;
    
    draw_set_color(make_color_rgb(28, 38, 70));
    draw_roundrect_ext(_toast_x, _toast_y, _toast_x + _toast_w, _toast_y + _toast_h, 8, 8, false);
    draw_set_color(make_color_rgb(255, 215, 80));
    draw_roundrect_ext(_toast_x, _toast_y, _toast_x + _toast_w, _toast_y + _toast_h, 8, 8, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_toast_x + _toast_w / 2, _toast_y + _toast_h / 2, menu_toast_text, 0.85, 0.85, 0);
}


// =========================================================================
// 7. BOTTOM HINT BAR
// =========================================================================
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(180, 205, 245));
draw_text_transformed(_gw / 2, _gh - 20, "[W/S] Pilih Perintah  •  [D / Z] Masuk Panel  •  [A / X] Kembali  •  [Esc / Tab] Tutup Menu", 0.78, 0.78, 0);

draw_set_alpha(1.0);

