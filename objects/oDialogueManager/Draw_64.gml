/// @description Draw GUI Event - VN Full-Height Standing Characters & JRPG Indigo Frosted Glass Dialogue UI

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
// 1. Helper Render Full-Height Standing 2D Anime Character
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
        // PANDAI BESI GORAN (Goran Blacksmith Masterpack Portrait)
        // ==========================================
        var _spr = sPortrait_Goran;
        if (variable_struct_exists(_curr, "emote") && _curr.emote == "exclamation") {
            _spr = sPortrait_Goran_Confident;
        }
        var _p_scale = 1.85;
        var _pw = 128 * _p_scale;
        var _ph = 128 * _p_scale;
        var _px = _cx - _pw / 2;
        var _py = 145;
        
        // Bayangan lembut potret
        draw_set_alpha(0.35);
        draw_set_color(c_black);
        draw_ellipse(_px - 10, _py + _ph - 20, _px + _pw + 10, _py + _ph + 15, false);
        draw_set_alpha(1.0);
        
        // Gambar sprite potret VN asli Goran
        var _col = _is_active ? c_white : make_color_rgb(140, 145, 160);
        draw_sprite_ext(_spr, 0, _px, _py, _p_scale, _p_scale, 0, _col, 1.0);
        
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
        draw_rectangle(_cx - 30, 175, _cx + 30, 185, false);
        
        // Bulu Helm Merah
        draw_set_color(_c_red);
        draw_triangle(_cx - 15, 130, _cx + 15, 130, _cx, 60, false);
        
    } else {
        // ==========================================
        // ==========================================
        // KARAKTER KANAN: ADIK SESTRINA (White Hair, Red Ribbons & Pinafore Dress)
        // ==========================================
        var _c_blouse = _is_active ? make_color_rgb(248, 248, 255) : make_color_rgb(170, 175, 185);
        var _c_dress  = _is_active ? make_color_rgb(52, 38, 54) : make_color_rgb(32, 22, 34);
        var _c_ribbon = _is_active ? make_color_rgb(215, 30, 50) : make_color_rgb(130, 20, 32);
        var _c_hair   = _is_active ? make_color_rgb(235, 238, 248) : make_color_rgb(160, 165, 180);
        var _c_skin   = _is_active ? make_color_rgb(255, 238, 232) : make_color_rgb(180, 160, 155);
        var _c_eye    = _is_active ? make_color_rgb(220, 25, 45) : make_color_rgb(120, 15, 25);

        // 1. Rok Lipit Plum Tua (Pleated Pinafore Skirt)
        draw_set_color(_c_dress);
        draw_triangle(_cx - 65, 340, _cx - 120, _gh, _cx + 100, _gh, false);
        draw_triangle(_cx + 45, 340, _cx + 130, _gh, _cx - 45, _gh, false);

        // Korset Pinggang Tinggi (High Corset Waist)
        draw_set_color(_c_dress);
        draw_roundrect_ext(_cx - 42, 310, _cx + 42, 370, 8, 8, false);
        // Kancing Ganda Mawar
        draw_set_color(make_color_rgb(245, 180, 195));
        draw_circle(_cx - 16, 330, 3, false);
        draw_circle(_cx + 16, 330, 3, false);
        draw_circle(_cx - 16, 350, 3, false);
        draw_circle(_cx + 16, 350, 3, false);

        // 2. Blus Putih Berenda & Tali Suspender Ruffle
        draw_set_color(_c_blouse);
        draw_ellipse(_cx - 40, 250, _cx + 40, 330, false);
        // Tali Suspender Gaun
        draw_set_color(_c_dress);
        draw_line_width(_cx - 24, 250, _cx - 20, 320, 6);
        draw_line_width(_cx + 24, 250, _cx + 20, 320, 6);

        // Pita Merah Besar di Leher
        draw_set_color(_c_ribbon);
        draw_triangle(_cx - 30, 235, _cx, 248, _cx - 15, 260, false);
        draw_triangle(_cx + 30, 235, _cx, 248, _cx + 15, 260, false);
        draw_circle(_cx, 246, 6, false);
        draw_line_width(_cx - 10, 250, _cx - 18, 280, 3);
        draw_line_width(_cx + 10, 250, _cx + 18, 280, 3);

        // Lengan Putih Mengembang & Tangan Menempel di Depan
        draw_set_color(_c_blouse);
        draw_roundrect_ext(_cx - 55, 260, _cx - 25, 350, 10, 10, false);
        draw_roundrect_ext(_cx + 25, 260, _cx + 55, 350, 10, 10, false);
        draw_set_color(_c_skin);
        draw_circle(_cx - 15, 345, 7, false);
        draw_circle(_cx + 15, 345, 7, false);

        // 3. Leher & Wajah Cantik Melankolis
        draw_set_color(_c_skin);
        draw_ellipse(_cx - 32, 145, _cx + 32, 225, false);

        // Mata Anime Merah Rubi (Ruby Eyes)
        draw_set_color(_c_eye);
        draw_circle(_cx - 13, 178, 5.5, false);
        draw_circle(_cx + 13, 178, 5.5, false);
        draw_set_color(c_black);
        draw_circle(_cx - 13, 178, 2.5, false);
        draw_circle(_cx + 13, 178, 2.5, false);
        draw_set_color(c_white);
        draw_circle(_cx - 11, 176, 1.8, false); // kilau mata
        draw_circle(_cx + 15, 176, 1.8, false);

        // Rona Pipi Lembut
        draw_set_color(make_color_rgb(255, 170, 180));
        draw_ellipse(_cx - 24, 188, _cx - 10, 196, false);
        draw_ellipse(_cx + 10, 188, _cx + 24, 196, false);

        // 4. Rambut Perak Putih & Kuncir Kuda Kembar (Twintails)
        // Kuncir Kiri
        draw_set_color(_c_hair);
        draw_triangle(_cx - 35, 140, _cx - 95, _gh - 50, _cx - 30, 320, false);
        // Kuncir Kanan
        draw_triangle(_cx + 35, 140, _cx + 95, _gh - 50, _cx + 30, 320, false);

        // Kubah Rambut Atas & Poni
        draw_circle(_cx, 135, 46, false);
        // Poni Tengah & Samping dengan Aksen Merah di Ujung Dalam
        draw_triangle(_cx - 30, 135, _cx - 36, 195, _cx - 15, 150, false);
        draw_triangle(_cx + 30, 135, _cx + 36, 195, _cx + 15, 150, false);
        draw_set_color(_c_ribbon);
        draw_circle(_cx - 33, 192, 3, false); // aksen merah ujung poni
        draw_circle(_cx + 33, 192, 3, false);

        // Pita Merah Kuncir Kiri & Kanan
        draw_set_color(_c_ribbon);
        draw_ellipse(_cx - 44, 130, _cx - 28, 148, false);
        draw_line_width(_cx - 38, 144, _cx - 52, 175, 3);
        draw_ellipse(_cx + 28, 130, _cx + 44, 148, false);
        draw_line_width(_cx + 38, 144, _cx + 52, 175, 3);
    }
};

// ==========================================
// 2. Render Standing Character Portraits di Kiri & Kanan
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
// 2B. Render Emotion Reaction Bubble di atas Karakter Aktif (Reference: reactionbubble.png)
// ==========================================
var _draw_emotion_bubble = function(_bx, _by, _emote_type, _scale, _timer) {
    if (_emote_type == "" || _scale <= 0.05) return;
    
    var _bounce = _scale;
    if (_bounce < 1.0) {
        _bounce = _scale * 1.15;
    }
    
    var _rad = 24 * _bounce;
    var _bob = sin(_timer * 3) * 3;
    var _cy = _by + _bob;
    
    // Bayangan Balon
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(10, 15, 30));
    draw_circle(_bx, _cy + 5, _rad + 2, false);
    
    // Latar Putih Balon Bulat
    draw_set_alpha(0.96);
    draw_set_color(c_white);
    draw_circle(_bx, _cy, _rad, false);
    
    // Ekor Balon Segitiga Menunjuk ke Kepala
    draw_triangle(_bx - 6 * _bounce, _cy + _rad - 4, _bx + 6 * _bounce, _cy + _rad - 4, _bx - 3 * _bounce, _cy + _rad + 14 * _bounce, false);
    
    // Outline Balon Gelap Bersih
    draw_set_color(make_color_rgb(45, 55, 75));
    draw_circle(_bx, _cy, _rad, true);
    draw_line(_bx - 6 * _bounce, _cy + _rad - 4, _bx - 3 * _bounce, _cy + _rad + 14 * _bounce);
    draw_line(_bx + 6 * _bounce, _cy + _rad - 4, _bx - 3 * _bounce, _cy + _rad + 14 * _bounce);
    
    // Ikon Emosi
    draw_set_alpha(1.0);
    if (_emote_type == "sweat") {
        // Tetesan Air Keringat Biru Segar dengan Kilau (Reference: reactionbubble.png)
        var _sx = _bx;
        var _sy = _cy + 2;
        draw_set_color(make_color_rgb(40, 150, 245));
        draw_triangle(_sx, _sy - 13 * _bounce, _sx - 9 * _bounce, _sy + 6 * _bounce, _sx + 9 * _bounce, _sy + 6 * _bounce, false);
        draw_circle(_sx, _sy + 5 * _bounce, 8.5 * _bounce, false);
        // Kilau Putih Lengkung
        draw_set_color(c_white);
        draw_ellipse(_sx - 5 * _bounce, _sy - 2 * _bounce, _sx - 1 * _bounce, _sy + 5 * _bounce, false);
    } else if (_emote_type == "exclamation") {
        // Tanda Seru Merah Menyala (!)
        var _ex = _bx;
        var _ey = _cy;
        draw_set_color(make_color_rgb(235, 45, 55));
        draw_roundrect_ext(_ex - 3.5 * _bounce, _ey - 13 * _bounce, _ex + 3.5 * _bounce, _ey + 3 * _bounce, 4, 4, false);
        draw_circle(_ex, _ey + 9 * _bounce, 3.5 * _bounce, false);
        draw_set_color(make_color_rgb(255, 230, 140));
        draw_circle(_ex, _ey - 10 * _bounce, 2 * _bounce, false);
    } else if (_emote_type == "dots") {
        // Tiga Titik Hening Berdenyut (...)
        var _dx = _bx;
        var _dy = _cy;
        draw_set_color(make_color_rgb(60, 75, 110));
        for (var _d = -1; _d <= 1; _d++) {
            var _wave = sin(_timer * 4 + _d * 1.5) * 3 * _bounce;
            draw_circle(_dx + _d * 10 * _bounce, _dy + _wave, 3.2 * _bounce, false);
        }
    } else if (_emote_type == "question") {
        // Tanda Tanya Indigo (?)
        draw_set_color(make_color_rgb(65, 80, 200));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(_bx, _cy - 2, "?", 1.6 * _bounce, 1.6 * _bounce, 0);
    }
};

if (variable_struct_exists(_line, "emote") && _line.emote != "") {
    if (_line.side_active == "left") {
        _draw_emotion_bubble(210 + 50, 75, _line.emote, emote_scale, emote_timer);
    } else {
        _draw_emotion_bubble(_gui_w - 210 - 50, 75, _line.emote, emote_scale, emote_timer);
    }
}

// Jika mode sembunyikan UI sedang aktif [H], jangan gambar kotak teks
if (variable_instance_exists(id, "ui_hidden") && ui_hidden) {
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(180, 210, 255));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_gui_w / 2, _gui_h - 40, "✦ Antarmuka Tersembunyi (Tekan [H] atau [Space] untuk kembali) ✦");
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    exit;
}

// ==========================================
// 3. Box Dialog Utama (Curved Pill Deep Indigo Glass - Reference: importantNPCdialog.png)
// ==========================================
var _box_x1 = 250;
var _box_y1 = _gui_h - 225;
var _box_x2 = _gui_w - 250;
var _box_y2 = _gui_h - 32;

// Curved Frosted Glass Dialogue Banner
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(22, 32, 60));
draw_roundrect_ext(_box_x1, _box_y1, _box_x2, _box_y2, 30, 30, false);

// Double Neon Lavender Glow Border
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(145, 175, 255));
draw_roundrect_ext(_box_x1, _box_y1, _box_x2, _box_y2, 30, 30, true);
draw_set_color(make_color_rgb(60, 80, 140));
draw_roundrect_ext(_box_x1 + 2, _box_y1 + 2, _box_x2 - 2, _box_y2 - 2, 28, 28, true);

// ==========================================
// 4. Speaker Name Pill Tab (Kiri Atas Box)
// ==========================================
if (_line.speaker != "") {
    var _tab_x1 = _box_x1 + 32;
    var _tab_y1 = _box_y1 - 32;
    var _tab_w = max(170, string_width(_line.speaker) + 54);
    var _tab_x2 = _tab_x1 + _tab_w;
    var _tab_y2 = _box_y1 + 10;

    // Tab Background Deep Indigo Glass
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(26, 38, 70));
    draw_roundrect_ext(_tab_x1, _tab_y1, _tab_x2, _tab_y2, 22, 22, false);
    
    // Tab Glow Border
    draw_set_color(make_color_rgb(145, 185, 255));
    draw_roundrect_ext(_tab_x1, _tab_y1, _tab_x2, _tab_y2, 22, 22, true);

    // Speaker Name Text
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((_tab_x1 + _tab_x2) / 2, (_tab_y1 + _tab_y2) / 2 - 2, _line.speaker);
}

// ==========================================
// 5. Tombol Kontrol VN di Kanan Atas Box (⏩ Fast, ▶ Auto, ≡ Log, ✖ Hide)
// ==========================================
var _btn_x = _box_x2 - 135;
var _btn_y = _box_y1 + 18;
draw_set_alpha(0.85);

var _auto_on = variable_instance_exists(id, "auto_mode") ? auto_mode : false;
var _vn_str = (_auto_on ? "⏩   ▶(ON)   ≡   ✖" : "⏩   ▶   ≡   ✖");

draw_set_color(_auto_on ? make_color_rgb(120, 240, 180) : make_color_rgb(195, 220, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_btn_x, _btn_y, _vn_str);

// Hotkey hint subtle
draw_set_alpha(0.5);
draw_set_color(make_color_rgb(150, 175, 215));
draw_text(_btn_x, _btn_y + 16, "[Tab] Skip  [A] Auto  [H] Hide");

// ==========================================
// 6. Isi Teks Dialog Typewriter
// ==========================================
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(245, 250, 255));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _sub_text = string_copy(_line.text, 1, floor(char_index));
var _text_x = _box_x1 + 44;
var _text_y = _box_y1 + 46;
var _max_w = (_box_x2 - _box_x1) - 88;

draw_text_ext(_text_x, _text_y, _sub_text, 28, _max_w);

// ==========================================
// 7. Panah Indikator Lanjut di Tengah Bawah Box (▼)
// ==========================================
if (is_finished_typing) {
    var _arr_alpha = 0.5 + 0.5 * sin(blink_timer * 6);
    draw_set_alpha(_arr_alpha);
    draw_set_color(make_color_rgb(160, 210, 255));
    var _mid_x = (_box_x1 + _box_x2) / 2;
    var _arr_y = _box_y2 - 15 + sin(blink_timer * 6) * 3;
    draw_triangle(_mid_x - 8, _arr_y - 6, _mid_x + 8, _arr_y - 6, _mid_x, _arr_y + 4, false);
}

// Reset standard drawing properties
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
