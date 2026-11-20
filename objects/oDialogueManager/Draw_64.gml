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
// 1. Cek Apakah Percakapan Khusus Main Char & Sestrina
// Sesuai Permintaan User: Tampilkan karakter 2D HANYA saat komunikasi Main Char sama Sestrina
// Dialog dengan Bos, NPC (Goran, Elysia, Alden, Warga Kota) TIDAK menampilkan karakter 2D
// ==========================================
var _is_main_and_sestrina = false;
if (current_dialogue != noone && variable_struct_exists(current_dialogue, "lines")) {
    var _has_mc = false;
    var _has_ses = false;
    var _has_other = false;
    for (var _k = 0; _k < array_length(current_dialogue.lines); _k++) {
        var _l = current_dialogue.lines[_k];
        var _spk = _l.speaker;
        if (_spk == "Protagonis" || _spk == "Protagonist") {
            _has_mc = true;
        } else if (_spk == "Sestrina") {
            _has_ses = true;
        } else if (_spk != "") {
            _has_other = true;
        }
        if (_l.left_portrait != "protagonist" && _l.left_portrait != "sestrina" && _l.left_portrait != noone) _has_other = true;
        if (_l.right_portrait != "protagonist" && _l.right_portrait != "sestrina" && _l.right_portrait != noone) _has_other = true;
    }
    _is_main_and_sestrina = (_has_mc && _has_ses && !_has_other);
}

var _draw_full_standing_anime_character = function(_type, _cx, _is_active, _alpha, _is_left, _gh) {
    if (_type != "protagonist" && _type != "sestrina") return;
    
    // Pilih Sprite Sesuai Karakter dan Sisi Berdiri (Kiri / Kanan agar SALING BERHADAPAN)
    // Karakter di sisi KIRI (_is_left == true) menghadap ke KANAN (ke arah lawan bicaranya)
    // Karakter di sisi KANAN (_is_left == false) menghadap ke KIRI (ke arah lawan bicaranya)
    var _spr = noone;
    if (_type == "protagonist") {
        _spr = _is_left ? sVN_Protagonist_Right : sVN_Protagonist_Left;
    } else if (_type == "sestrina") {
        _spr = _is_left ? sVN_Sestrina_Right : sVN_Sestrina_Left;
    }
    if (_spr == noone || !sprite_exists(_spr)) return;

    var _sc = _is_active ? 1.02 : 0.95;
    var _blend = _is_active ? c_white : make_color_rgb(160, 165, 185);
    var _final_alpha = _is_active ? min(1.0, _alpha * 1.05) : (_alpha * 0.85);

    // Glow Aura di belakang karakter aktif
    if (_is_active) {
        var _glow_col = (_type == "protagonist") ? make_color_rgb(180, 45, 65) : make_color_rgb(255, 175, 205);
        draw_set_alpha(0.28 * _alpha);
        draw_set_color(_glow_col);
        draw_ellipse(_cx - 150, 60, _cx + 150, _gh, false);
    }

    // Gambar Sprite Karakter 2D Resmi Beresolusi Tinggi
    draw_sprite_ext(_spr, 0, _cx, _gh, _sc, _sc, 0, _blend, _final_alpha);
};

// ==========================================
// 2. Render Standing Character Portraits di Kiri & Kanan (Hanya untuk Main Char & Sestrina)
// ==========================================
if (_is_main_and_sestrina) {
    if (_line.left_portrait != noone) {
        var _is_left_active = (_line.side_active == "left");
        _draw_full_standing_anime_character(_line.left_portrait, 220, _is_left_active, portrait_left_alpha, true, _gui_h);
    }

    if (_line.right_portrait != noone) {
        var _is_right_active = (_line.side_active == "right");
        _draw_full_standing_anime_character(_line.right_portrait, _gui_w - 220, _is_right_active, portrait_right_alpha, false, _gui_h);
    }
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

if (variable_struct_exists(_line, "emote") && _line.emote != "" && _is_main_and_sestrina) {
    var _active_port = (_line.side_active == "left") ? _line.left_portrait : _line.right_portrait;
    if (_active_port == "protagonist" || _active_port == "sestrina") {
        if (_line.side_active == "left") {
            _draw_emotion_bubble(220 + 50, 75, _line.emote, emote_scale, emote_timer);
        } else {
            _draw_emotion_bubble(_gui_w - 220 - 50, 75, _line.emote, emote_scale, emote_timer);
        }
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
