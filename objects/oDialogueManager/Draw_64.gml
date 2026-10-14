/// @description Draw GUI Event - VN Full-Height Standing Characters & Aesthetic Dialogue UI

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Keluar jika dialog sedang tidak aktif
if (current_dialogue == noone || !global.dialogue_active) {
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}


var _lines = current_dialogue.lines;
if (current_line_index >= array_length(_lines)) exit;
var _line = _lines[current_line_index];

// ==========================================
// 2. Helper Render Full-Height Standing 2D Anime Character
// ==========================================
var _draw_full_standing_anime_character = function(_type, _cx, _is_active, _alpha, _is_left, _gh) {
    var _base_y = _gh;
    var _sc = _is_active ? 1.0 : 0.95;
    var _cy = _base_y - 20;

    // Glow aura jika aktif
    if (_is_active) {
        draw_set_alpha(0.35 * _alpha);
        draw_set_color((_type == "protagonist") ? make_color_rgb(80, 160, 255) : make_color_rgb(255, 140, 180));
        draw_ellipse(_cx - 150, 40, _cx + 150, _gh, false);
    }

    draw_set_alpha(_alpha);

    if (_type == "protagonist") {
        // ==========================================
        // KARAKTER KIRI: BLUE-HAIRED KNIGHT HEROINE
        // ==========================================
        var _c_cloak = _is_active ? make_color_rgb(42, 68, 125) : make_color_rgb(24, 38, 70);
        var _c_armor = _is_active ? make_color_rgb(230, 235, 245) : make_color_rgb(140, 145, 155);
        var _c_hair  = _is_active ? make_color_rgb(85, 165, 240) : make_color_rgb(50, 95, 140);
        var _c_skin  = _is_active ? make_color_rgb(255, 226, 210) : make_color_rgb(170, 145, 130);
        var _c_gold  = _is_active ? make_color_rgb(225, 190, 80) : make_color_rgb(130, 110, 45);

        // 1. Jubah Biru Panjang (Flowing Cape)
        draw_set_color(_c_cloak);
        draw_triangle(_cx - 130, 280, _cx - 180, _gh, _cx - 40, _gh, false);
        draw_triangle(_cx + 80, 280, _cx + 160, _gh, _cx + 30, _gh, false);

        // 2. Kaki & Stockings Putih (White Thigh Highs)
        draw_set_color(_is_active ? make_color_rgb(245, 248, 255) : make_color_rgb(160, 165, 175));
        draw_roundrect_ext(_cx - 50, 460, _cx - 15, _gh, 12, 12, false);
        draw_roundrect_ext(_cx + 10, 460, _cx + 45, _gh, 12, 12, false);

        // Garter Straps Hitam
        draw_set_color(make_color_rgb(30, 30, 40));
        draw_rectangle(_cx - 48, 480, _cx - 17, 488, false);
        draw_rectangle(_cx + 12, 480, _cx + 43, 488, false);

        // 3. Rok Mini & Korset Armor
        draw_set_color(_is_active ? make_color_rgb(25, 30, 45) : make_color_rgb(15, 18, 28));
        draw_roundrect_ext(_cx - 65, 390, _cx + 65, 470, 14, 14, false);

        // Armor Dada & Kerah
        draw_set_color(_c_armor);
        draw_ellipse(_cx - 55, 270, _cx + 55, 390, false);
        draw_set_color(_c_cloak);
        draw_rectangle(_cx - 40, 340, _cx + 40, 410, false);
        draw_set_color(_c_gold);
        draw_rectangle(_cx - 42, 375, _cx + 42, 385, false);

        // Tangan Bersarung Tangan Hitam Melipat (Crossed Arms)
        draw_set_color(make_color_rgb(40, 40, 50));
        draw_roundrect_ext(_cx - 75, 300, _cx + 75, 345, 12, 12, false);

        // 4. Leher & Wajah
        draw_set_color(_c_skin);
        draw_ellipse(_cx - 38, 140, _cx + 38, 220, false);

        // Mata Anime Amber/Orange
        draw_set_color(_is_active ? make_color_rgb(255, 160, 40) : make_color_rgb(150, 90, 20));
        draw_circle(_cx - 15, 175, 5, false);
        draw_circle(_cx + 15, 175, 5, false);
        draw_set_color(c_black);
        draw_circle(_cx - 15, 175, 2.5, false);
        draw_circle(_cx + 15, 175, 2.5, false);

        // 5. Rambut Biru Menjuntai
        draw_set_color(_c_hair);
        draw_circle(_cx, 130, 52, false);
        draw_triangle(_cx - 55, 130, _cx - 65, 270, _cx - 20, 200, false);
        draw_triangle(_cx + 55, 130, _cx + 65, 270, _cx + 20, 200, false);
        draw_triangle(_cx - 30, 130, _cx, 170, _cx - 10, 130, false);
        draw_triangle(_cx + 10, 130, _cx + 25, 165, _cx + 30, 130, false);

    } else if (_type == "goran") {
        // ==========================================
        // PANDAI BESI GORAN (Muscular Blacksmith)
        // ==========================================
        var _c_apron = _is_active ? make_color_rgb(120, 65, 35) : make_color_rgb(70, 35, 20);
        var _c_skin  = _is_active ? make_color_rgb(240, 195, 170) : make_color_rgb(160, 125, 105);
        var _c_hair  = _is_active ? make_color_rgb(80, 50, 30) : make_color_rgb(45, 25, 15);
        
        // Tubuh Berotot & Celemek Kulit
        draw_set_color(_c_apron);
        draw_roundrect_ext(_cx - 70, 260, _cx + 70, _gh, 16, 16, false);
        draw_set_color(make_color_rgb(40, 40, 45));
        draw_rectangle(_cx - 65, 380, _cx + 65, 400, false); // Sabuk kulit besi
        
        // Lengan Kekar
        draw_set_color(_c_skin);
        draw_circle(_cx - 75, 310, 24, false);
        draw_circle(_cx + 75, 310, 24, false);
        draw_roundrect_ext(_cx - 90, 310, _cx - 60, 440, 12, 12, false);
        draw_roundrect_ext(_cx + 60, 310, _cx + 90, 440, 12, 12, false);
        
        // Kepala, Janggut & Ikat Kepala
        draw_set_color(_c_skin);
        draw_ellipse(_cx - 40, 140, _cx + 40, 230, false);
        draw_set_color(_c_hair);
        draw_ellipse(_cx - 42, 180, _cx + 42, 250, false); // Janggut lebat
        draw_set_color(make_color_rgb(200, 50, 50)); // Ikat kepala merah
        draw_rectangle(_cx - 42, 145, _cx + 42, 160, false);
        
        // Mata Bertekad
        draw_set_color(c_black);
        draw_circle(_cx - 15, 175, 3, false);
        draw_circle(_cx + 15, 175, 3, false);
        
    } else if (_type == "elysia") {
        // ==========================================
        // ALKEMIS ELYSIA (Mystic Herbalist in Emerald Cloak)
        // ==========================================
        var _c_cloak = _is_active ? make_color_rgb(35, 120, 85) : make_color_rgb(20, 70, 50);
        var _c_gold  = _is_active ? make_color_rgb(230, 200, 90) : make_color_rgb(130, 110, 50);
        var _c_hair  = _is_active ? make_color_rgb(180, 120, 210) : make_color_rgb(100, 65, 120);
        var _c_skin  = _is_active ? make_color_rgb(255, 230, 215) : make_color_rgb(170, 150, 140);
        
        // Jubah Emerald Panjang
        draw_set_color(_c_cloak);
        draw_triangle(_cx - 70, 270, _cx - 130, _gh, _cx + 110, _gh, false);
        draw_triangle(_cx + 50, 270, _cx + 130, _gh, _cx - 110, _gh, false);
        
        // Hiasan Emas Jubah
        draw_set_color(_c_gold);
        draw_roundrect_ext(_cx - 30, 280, _cx + 30, 390, 8, 8, false);
        
        // Botol Ramuan di Tangan
        draw_set_color(make_color_rgb(120, 240, 200));
        draw_circle(_cx + 40, 360, 14, false);
        
        // Wajah & Kacamata Alkemis
        draw_set_color(_c_skin);
        draw_ellipse(_cx - 34, 145, _cx + 34, 220, false);
        draw_set_color(_c_gold);
        draw_circle(_cx - 14, 176, 8, true);
        draw_circle(_cx + 14, 176, 8, true);
        draw_line(_cx - 6, 176, _cx + 6, 176);
        
        // Rambut Ungu Lavender & Topi Penyihir
        draw_set_color(_c_hair);
        draw_circle(_cx, 140, 48, false);
        draw_triangle(_cx - 50, 140, _cx - 70, 320, _cx - 20, 200, false);
        draw_triangle(_cx + 50, 140, _cx + 70, 320, _cx + 20, 200, false);
        
        // Topi Runcing Hijau Emerald
        draw_set_color(_c_cloak);
        draw_triangle(_cx - 80, 145, _cx + 80, 145, _cx, 30, false);
        draw_set_color(_c_gold);
        draw_ellipse(_cx - 80, 140, _cx + 80, 152, false);
        
    } else if (_type == "alden") {
        // ==========================================
        // KAPTEN ALDEN (Silver Armored Knight)
        // ==========================================
        var _c_plate = _is_active ? make_color_rgb(210, 220, 235) : make_color_rgb(120, 130, 145);
        var _c_red   = _is_active ? make_color_rgb(210, 45, 45) : make_color_rgb(120, 25, 25);
        
        // Zirah Baja Seluruh Tubuh
        draw_set_color(_c_plate);
        draw_roundrect_ext(_cx - 65, 260, _cx + 65, _gh, 14, 14, false);
        
        // Selempang Merah Kerajaan
        draw_set_color(_c_red);
        draw_line_width(_cx - 60, 265, _cx + 50, 420, 18);
        
        // Helm Ksatria Tertutup dengan Bulu Merah
        draw_set_color(_c_plate);
        draw_roundrect_ext(_cx - 40, 130, _cx + 40, 230, 14, 14, false);
        draw_set_color(make_color_rgb(30, 35, 45));
        draw_rectangle(_cx - 30, 175, _cx + 30, 185, false); // Celah Visor Helm
        
        // Bulu Helm Merah
        draw_set_color(_c_red);
        draw_triangle(_cx - 15, 130, _cx + 15, 130, _cx, 60, false);
        
    } else {
        // ==========================================
        // KARAKTER KANAN: DARK-HAIRED GIRL IN WHITE DRESS (Sestrina)
        // ==========================================
        var _c_dress = _is_active ? make_color_rgb(240, 248, 255) : make_color_rgb(150, 155, 165);
        var _c_ribbon= _is_active ? make_color_rgb(130, 190, 255) : make_color_rgb(80, 120, 160);
        var _c_hair  = _is_active ? make_color_rgb(45, 55, 80) : make_color_rgb(25, 30, 45);
        var _c_skin  = _is_active ? make_color_rgb(255, 228, 215) : make_color_rgb(170, 150, 140);

        // 1. Gaun Putih Panjang Transparan
        draw_set_color(_c_dress);
        draw_triangle(_cx - 60, 310, _cx - 110, _gh, _cx + 90, _gh, false);
        draw_triangle(_cx + 40, 310, _cx + 120, _gh, _cx - 40, _gh, false);

        // Pita Biru Pinggang
        draw_set_color(_c_ribbon);
        draw_roundrect_ext(_cx - 35, 360, _cx + 35, 375, 6, 6, false);

        // Kaki Anggun
        draw_set_color(_c_skin);
        draw_roundrect_ext(_cx - 35, 480, _cx - 10, _gh, 10, 10, false);
        draw_roundrect_ext(_cx + 5, 480, _cx + 30, _gh, 10, 10, false);
        draw_set_color(_c_ribbon);
        draw_line_width(_cx - 35, 650, _cx - 10, 640, 2);
        draw_line_width(_cx + 5, 650, _cx + 30, 640, 2);

        // 2. Tubuh & Gaun Atas
        draw_set_color(_c_dress);
        draw_ellipse(_cx - 42, 260, _cx + 42, 380, false);

        // Lengan & Tangan Menempel di Dada
        draw_set_color(_c_skin);
        draw_roundrect_ext(_cx - 45, 270, _cx - 20, 360, 8, 8, false);
        draw_roundrect_ext(_cx + 10, 290, _cx + 35, 340, 8, 8, false);

        // 3. Leher & Wajah Cantik
        draw_set_color(_c_skin);
        draw_ellipse(_cx - 32, 145, _cx + 32, 220, false);

        // Mata Anime Biru Lembut
        draw_set_color(_is_active ? make_color_rgb(70, 130, 210) : make_color_rgb(40, 75, 120));
        draw_circle(_cx - 12, 178, 4.5, false);
        draw_circle(_cx + 12, 178, 4.5, false);
        draw_set_color(c_black);
        draw_circle(_cx - 12, 178, 2, false);
        draw_circle(_cx + 12, 178, 2, false);

        // 4. Rambut Hitam/Navy Panjang Mengalir
        draw_set_color(_c_hair);
        draw_circle(_cx, 135, 46, false);
        draw_triangle(_cx - 45, 135, _cx - 85, _gh - 100, _cx - 10, 300, false);
        draw_triangle(_cx + 40, 135, _cx + 80, _gh - 100, _cx + 10, 300, false);
        // Hiasan Rambut Putih Kanan
        draw_set_color(c_white);
        draw_line_width(_cx + 32, 140, _cx + 45, 160, 3);
        draw_line_width(_cx + 38, 145, _cx + 25, 165, 2);
    }
};

// ==========================================
// 3. Render Karakter 2D di Sisi Hitam Kiri & Kanan
// ==========================================
if (_line.left_portrait != noone) {
    var _is_left_active = (_line.side_active == "left");
    _draw_full_standing_anime_character(_line.left_portrait, 210, _is_left_active, portrait_left_alpha, true, _gui_h);
}

if (_line.right_portrait != noone) {
    var _is_right_active = (_line.side_active == "right");
    _draw_full_standing_anime_character(_line.right_portrait, _gui_w - 210, _is_right_active, portrait_right_alpha, false, _gui_h);
}

// ==========================================
// 4. Box Dialog Utama (Aesthetic Curved Banner)
// ==========================================
var _box_x1 = 260;
var _box_y1 = _gui_h - 220;
var _box_x2 = _gui_w - 260;
var _box_y2 = _gui_h - 35;

// Curved Glassmorphism Dialogue Banner
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(42, 52, 78));
draw_roundrect_ext(_box_x1, _box_y1, _box_x2, _box_y2, 28, 28, false);

// Outer Blue Glow Border
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(120, 165, 235));
draw_roundrect_ext(_box_x1, _box_y1, _box_x2, _box_y2, 28, 28, true);

// ==========================================
// 5. Speaker Name Tab (Pill Tab Kiri Atas Box)
// ==========================================
if (_line.speaker != "") {
    var _tab_x1 = _box_x1 + 30;
    var _tab_y1 = _box_y1 - 32;
    var _tab_w = max(160, string_width(_line.speaker) + 50);
    var _tab_x2 = _tab_x1 + _tab_w;
    var _tab_y2 = _box_y1 + 10;

    // Tab Background
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(28, 38, 62));
    draw_roundrect_ext(_tab_x1, _tab_y1, _tab_x2, _tab_y2, 20, 20, false);
    
    // Tab Glow Border
    draw_set_color(make_color_rgb(130, 185, 255));
    draw_roundrect_ext(_tab_x1, _tab_y1, _tab_x2, _tab_y2, 20, 20, true);

    // Speaker Name Text
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((_tab_x1 + _tab_x2) / 2, (_tab_y1 + _tab_y2) / 2 - 2, _line.speaker);
}

// ==========================================
// 6. Tombol Kontrol VN di Kanan Atas Box (▶▶ ▍▍ ▤ ✖)
// ==========================================
var _btn_x = _box_x2 - 120;
var _btn_y = _box_y1 + 18;
draw_set_alpha(0.75);
draw_set_color(make_color_rgb(190, 215, 245));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_btn_x, _btn_y, "▶▶   ▍▍   ▤   ✖");

// ==========================================
// 7. Isi Teks Dialog Typewriter
// ==========================================
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(245, 250, 255));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _sub_text = string_copy(_line.text, 1, floor(char_index));
var _text_x = _box_x1 + 40;
var _text_y = _box_y1 + 45;
var _max_w = (_box_x2 - _box_x1) - 80;

draw_text_ext(_text_x, _text_y, _sub_text, 28, _max_w);

// ==========================================
// 8. Panah Indikator Lanjut di Tengah Bawah Box (▼)
// ==========================================
if (is_finished_typing) {
    var _arr_alpha = 0.5 + 0.5 * sin(blink_timer * 6);
    draw_set_alpha(_arr_alpha);
    draw_set_color(make_color_rgb(160, 205, 255));
    var _mid_x = (_box_x1 + _box_x2) / 2;
    var _arr_y = _box_y2 - 14 + sin(blink_timer * 6) * 3;
    draw_triangle(_mid_x - 8, _arr_y - 6, _mid_x + 8, _arr_y - 6, _mid_x, _arr_y + 4, false);
}

// Reset standard drawing properties
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
