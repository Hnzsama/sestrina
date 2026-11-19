/// @description Draw GUI Event - Render Main Menu, Settings, Controls & Credits

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// 1. Latar Belakang Gradien Langit Malam Fantasi
draw_set_alpha(1.0);
draw_rectangle_color(0, 0, _gw, _gh, 
    make_color_rgb(12, 16, 32), 
    make_color_rgb(12, 16, 32), 
    make_color_rgb(26, 36, 68), 
    make_color_rgb(26, 36, 68), 
    false);

// 2. Partikel Bintang Melayang
for (var _i = 0; _i < array_length(particles); _i++) {
    var _p = particles[_i];
    draw_set_alpha(_p.alpha * (0.6 + sin(anim_time * 2 + _i) * 0.4));
    draw_set_color(_p.col);
    draw_circle(_p.x, _p.y, _p.size, false);
}
draw_set_alpha(1.0);

// =========================================================================
// STATE: MAIN MENU UTAMA
// =========================================================================
if (menu_state == "main") {
    // A. Logo & Judul Game "SESTRINA"
    var _title_y = 135 + sin(anim_time * 1.5) * 4;
    
    // Glow Aura Emas di Belakang Judul
    draw_set_alpha(0.25);
    draw_set_color(make_color_rgb(255, 200, 70));
    draw_ellipse(_gw / 2 - 260, _title_y - 45, _gw / 2 + 260, _title_y + 45, false);
    
    // Drop Shadow Judul
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(10, 14, 25));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(_gw / 2 + 3, _title_y + 3, "S E S T R I N A", 2.8, 2.8, 0);
    
    // Teks Utama Judul
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 232, 140));
    draw_text_transformed(_gw / 2, _title_y, "S E S T R I N A", 2.8, 2.8, 0);
    
    // Subjudul
    draw_set_color(make_color_rgb(160, 215, 255));
    draw_text_transformed(_gw / 2, _title_y + 46, "✦ THE LOST REMEDY ✦", 1.25, 1.25, 0);
    
    draw_set_color(make_color_rgb(180, 195, 225));
    draw_text_transformed(_gw / 2, _title_y + 74, "~ Sebuah Kisah Perjuangan Demi Adik Tercinta ~", 0.9, 0.9, 0);

    // B. Garis Hiasan Pembatas Emas
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_line_width(_gw / 2 - 220, _title_y + 98, _gw / 2 + 220, _title_y + 98, 2);
    draw_circle(_gw / 2, _title_y + 98, 4, false);

    // C. Opsi Menu
    var _options = [
        "✦  MULAI PETUALANGAN BARU  ✦",
        has_save ? ("⚔  LANJUTKAN" + save_info_str + "  ⚔") : "⚔  LANJUTKAN (Belum Ada Simpanan)  ⚔",
        "⚙  PENGATURAN (Settings)  ⚙",
        "📜  KREDIT PENGEMBANG (Credits)  📜",
        "✕  KELUAR KE DESKTOP  ✕"
    ];

    var _start_y = 310;
    var _spacing = 64;
    var _btn_w = 520;
    var _btn_h = 48;

    for (var _i = 0; _i < array_length(_options); _i++) {
        var _by = _start_y + (_i * _spacing);
        var _bx1 = (_gw - _btn_w) / 2;
        var _bx2 = _bx1 + _btn_w;
        var _by1 = _by - _btn_h / 2;
        var _by2 = _by + _btn_h / 2;
        
        var _is_sel = (selected_option == _i);
        var _is_disabled = (_i == 1 && !has_save);
        
        // Kotak Tombol Frosted Glass
        draw_set_alpha(_is_sel ? 0.95 : 0.65);
        draw_set_color(_is_sel ? make_color_rgb(32, 45, 80) : make_color_rgb(18, 24, 45));
        draw_roundrect_ext(_bx1, _by1, _bx2, _by2, 16, 16, false);
        
        // Border Neon Emas / Perak
        draw_set_alpha(_is_sel ? 1.0 : 0.45);
        var _border_col = _is_sel ? make_color_rgb(255, 215, 90) : make_color_rgb(80, 110, 160);
        if (_is_disabled) _border_col = make_color_rgb(60, 65, 80);
        draw_set_color(_border_col);
        draw_roundrect_ext(_bx1, _by1, _bx2, _by2, 16, 16, true);
        
        if (_is_sel) {
            // Indikator Panah Kiri & Kanan
            draw_set_color(make_color_rgb(255, 235, 140));
            var _bob = sin(anim_time * 5) * 4;
            draw_text(_bx1 - 25 + _bob, _by, "▶");
            draw_text(_bx2 + 25 - _bob, _by, "◀");
        }
        
        // Teks Opsi
        draw_set_alpha(1.0);
        var _text_col = _is_sel ? make_color_rgb(255, 245, 210) : make_color_rgb(200, 215, 240);
        if (_is_disabled) _text_col = make_color_rgb(110, 115, 130);
        draw_set_color(_text_col);
        draw_text_transformed(_gw / 2, _by - 1, _options[_i], _is_sel ? 1.05 : 0.98, _is_sel ? 1.05 : 0.98, 0);
    }

    // Panduan Navigasi Bawah
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(150, 175, 215));
    draw_text(_gw / 2, _gh - 45, "[↑/↓/W/S] Pilih Menu    •    [Z / ENTER / SPACE] Konfirmasi");
}

// =========================================================================
// STATE: SETTINGS MENU
// =========================================================================
else if (menu_state == "settings") {
    var _pw = 620;
    var _ph = 480;
    var _px1 = (_gw - _pw) / 2;
    var _py1 = (_gh - _ph) / 2;
    var _px2 = _px1 + _pw;
    var _py2 = _py1 + _ph;

    // Panel Window
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(18, 25, 48));
    draw_roundrect_ext(_px1, _py1, _px2, _py2, 20, 20, false);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_roundrect_ext(_px1, _py1, _px2, _py2, 20, 20, true);

    // Header Panel
    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_text_transformed(_gw / 2, _py1 + 24, "⚙ PENGATURAN PERMAINAN ⚙", 1.4, 1.4, 0);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_line_width(_px1 + 40, _py1 + 68, _px2 - 40, _py1 + 68, 1.5);

    // Setting Rows
    var _items = [
        { label: "Volume Musik (BGM)", val: string(round(global.bgm_volume * 100)) + " %" },
        { label: "Volume Efek Suara (SFX)", val: string(round(global.sfx_volume * 100)) + " %" },
        { label: "Mode Layar", val: global.is_fullscreen ? "[ Layar Penuh ]" : "[ Jendela (Windowed) ]" },
        { label: "Panduan Tombol Kontrol", val: "[ Tekan ENTER ]" },
        { label: "Kembali ke Menu Utama", val: "[ Selesai ]" }
    ];

    var _sy = _py1 + 100;
    var _row_h = 58;

    for (var _i = 0; _i < array_length(_items); _i++) {
        var _ry = _sy + (_i * _row_h);
        var _is_sel = (setting_selected == _i);
        
        if (_is_sel) {
            draw_set_alpha(0.35);
            draw_set_color(make_color_rgb(80, 140, 240));
            draw_roundrect_ext(_px1 + 20, _ry - 6, _px2 - 20, _ry + 38, 10, 10, false);
            draw_set_alpha(1.0);
            draw_set_color(make_color_rgb(255, 215, 90));
            draw_roundrect_ext(_px1 + 20, _ry - 6, _px2 - 20, _ry + 38, 10, 10, true);
        }
        
        draw_set_alpha(1.0);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(_is_sel ? make_color_rgb(255, 240, 190) : make_color_rgb(210, 225, 250));
        draw_text(_px1 + 40, _ry + 16, (_is_sel ? "▶ " : "  ") + _items[_i].label);

        draw_set_halign(fa_right);
        draw_set_color(_is_sel ? make_color_rgb(255, 215, 90) : make_color_rgb(160, 200, 245));
        
        if (_i < 2) {
            draw_text(_px2 - 40, _ry + 16, "◀  " + _items[_i].val + "  ▶");
        } else {
            draw_text(_px2 - 40, _ry + 16, _items[_i].val);
        }
    }

    // Nav Help
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(160, 185, 220));
    draw_text(_gw / 2, _py2 - 20, "[A/D/←/→] Atur Nilai    •    [Z / ENTER] Pilih    •    [ESC / X] Kembali");
}

// =========================================================================
// STATE: CONTROLS GUIDE
// =========================================================================
else if (menu_state == "controls") {
    var _pw = 680;
    var _ph = 520;
    var _px1 = (_gw - _pw) / 2;
    var _py1 = (_gh - _ph) / 2;
    var _px2 = _px1 + _pw;
    var _py2 = _py1 + _ph;

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(18, 24, 46));
    draw_roundrect_ext(_px1, _py1, _px2, _py2, 20, 20, false);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_roundrect_ext(_px1, _py1, _px2, _py2, 20, 20, true);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_text_transformed(_gw / 2, _py1 + 20, "🎮 PANDUAN KONTROL & TOMBOL AKSI 🎮", 1.3, 1.3, 0);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_line_width(_px1 + 40, _py1 + 60, _px2 - 40, _py1 + 60, 1.5);

    var _ctrls = [
        ["WASD / Tombol Arah", "Berjalan, Menjelajah & Navigasi Menu"],
        ["[Z] / Enter / Space", "Tebasan Pedang Kombo / Interaksi NPC & Peti"],
        ["[X]", "Tembakkan Sihir Terpilih (Fireball / Frost Nova)"],
        ["[C]", "Minum Ramuan Herbal Pemulih HP"],
        ["[Shift / Space]", "Dodge Roll (Roll Menghindar & Tangkis Parry)"],
        ["[P]", "Menu Status Atribut & Alokasi Poin Ksatria"],
        ["[M]", "Buka Peta Distrik Kota Altdorf & Kuil Purba"],
        ["[F5] / [F6]", "Simpan Cepat (Quick Save) / Muat (Quick Load)"],
        ["[ESC] / Tab", "Buka JRPG Menu Lengkap (Inventori & Simpanan)"]
    ];

    var _cy = _py1 + 82;
    for (var _i = 0; _i < array_length(_ctrls); _i++) {
        var _line_y = _cy + (_i * 38);
        draw_set_halign(fa_left);
        draw_set_color(make_color_rgb(255, 215, 90));
        draw_text(_px1 + 50, _line_y, _ctrls[_i][0]);

        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(220, 235, 255));
        draw_text(_px2 - 50, _line_y, _ctrls[_i][1]);
    }

    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(255, 230, 140));
    draw_text(_gw / 2, _py2 - 18, "▶ [Tekan SPACE / ENTER / Z / ESC untuk Kembali] ◀");
}

// =========================================================================
// STATE: CREDITS ROLL (ENDING CREDIT)
// =========================================================================
else if (menu_state == "credits") {
    var _lines = [
        "✧ S E S T R I N A ✧",
        "THE LOST REMEDY",
        "",
        "~ A Medieval Fantasy Action RPG ~",
        "",
        "------------------------------------",
        "SUTRADARA & PEMROGRAM UTAMA",
        "Luqman / Hnzsama",
        "------------------------------------",
        "",
        "DESAIN CERITA & SKENARIO",
        "Kisah Penyelamatan Adik Sestrina",
        "The Overclock Mana Leak Incident",
        "",
        "------------------------------------",
        "SISTEM GAMEPLAY & ARPG",
        "Antigravity GameMaker Engine",
        "Kombo Pedang 3-Hit & Dynamic Dodge Roll",
        "Sistem Sihir Elemen Api & Es",
        "Sistem Day/Night & Urgensi Batas Waktu",
        "------------------------------------",
        "",
        "SENI VISUAL & PIXEL ART",
        "Diorama Kamar: Medieval Blacksmith Studio",
        "Arsitektur Kota: Fantasy RPG Town Tileset",
        "Karakter & Potret Anime 2D: Sestrina Visual Team",
        "Monster Dungeon: Enemy & Boss Golem Atlas",
        "",
        "------------------------------------",
        "AUDIO & DESAIN SUARA",
        "Modular Category-Centric Sound Engine",
        "SFX Pertarungan, Sihir & Antarmuka UI",
        "------------------------------------",
        "",
        "✦ UCAPAN TERIMA KASIH KHUSUS ✦",
        "Untuk Anda yang telah bermain dan",
        "berjuang menembus kuil purba demi adik tercinta.",
        "",
        "Kasih persaudaraan melampaui segala takdir terkelam.",
        "",
        "✧ TAMAT ~ THE END ✧"
    ];

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _cur_y = credits_scroll_y;
    for (var _i = 0; _i < array_length(_lines); _i++) {
        var _txt = _lines[_i];
        if (_txt != "") {
            if (string_pos("✧", _txt) > 0 || string_pos("S E S T R I N A", _txt) > 0) {
                draw_set_color(make_color_rgb(255, 235, 140));
                draw_text_transformed(_gw / 2, _cur_y, _txt, 1.5, 1.5, 0);
            } else if (string_pos("---", _txt) > 0) {
                draw_set_color(make_color_rgb(120, 160, 220));
                draw_text(_gw / 2, _cur_y, _txt);
            } else if (string_pos("Luqman", _txt) > 0 || string_pos("SUTRADARA", _txt) > 0 || string_pos("KHUSUS", _txt) > 0) {
                draw_set_color(make_color_rgb(255, 215, 90));
                draw_text_transformed(_gw / 2, _cur_y, _txt, 1.15, 1.15, 0);
            } else {
                draw_set_color(make_color_rgb(220, 230, 250));
                draw_text(_gw / 2, _cur_y, _txt);
            }
        }
        _cur_y += 34;
    }

    // Tombol Cepat Kembali
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(18, 22, 40));
    draw_rectangle(0, _gh - 50, _gw, _gh, false);
    draw_set_color(make_color_rgb(255, 215, 90));
    draw_line_width(0, _gh - 50, _gw, _gh - 50, 1.5);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_text(_gw / 2, _gh - 25, "▶ [Tekan SPACE / ENTER / Z / ESC untuk Kembali ke Menu Utama] ◀");
}

// 5. Layar Fade Out saat Memulai Game
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
