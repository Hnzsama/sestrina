/// @description Draw GUI Event - Render Main Menu, Settings, Controls & Credits with Pixel Art UI Assets

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// 1. Latar Belakang Pemandangan Istana Kristal (sTitle_Background 905x455 -> 1280x720)
draw_set_alpha(1.0);
draw_sprite_stretched(sTitle_Background, 0, 0, 0, _gw, _gh);

// Vignette Atas & Bawah untuk Fokus UI
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(10, 12, 26));
draw_rectangle(0, 0, _gw, 130, false);
draw_rectangle(0, _gh - 80, _gw, _gh, false);
draw_set_alpha(1.0);

// 2. Partikel Bintang Melayang di Angkasa
for (var _i = 0; _i < array_length(particles); _i++) {
    var _p = particles[_i];
    draw_set_alpha(_p.alpha * (0.6 + sin(anim_time * 2 + _i) * 0.4));
    draw_set_color(_p.col);
    draw_circle(_p.x, _p.y, _p.size, false);
}
draw_set_alpha(1.0);

// 3. Ornamen Klaster Kristal Ungu di Kedua Sudut Bawah
draw_sprite_ext(sTitle_Crystal_Cluster, 0, 95, _gh + 10, 1.25, 1.25, 0, c_white, 0.92);
draw_sprite_ext(sTitle_Crystal_Cluster, 0, _gw - 95, _gh + 10, -1.25, 1.25, 0, c_white, 0.92);

// =========================================================================
// STATE: MAIN MENU UTAMA
// =========================================================================
if (menu_state == "main") {
    // A. Logo Resmi "SESTRINA: THE LOST REMEDY" (sTitle_Logo 721x295)
    var _logo_y = 125 + sin(anim_time * 1.5) * 4;
    
    // Pendaran Ungu Halus di Belakang Logo
    draw_set_alpha(0.28);
    draw_set_color(make_color_rgb(180, 80, 255));
    draw_ellipse(_gw / 2 - 250, _logo_y - 40, _gw / 2 + 250, _logo_y + 40, false);
    draw_set_alpha(1.0);
    
    // Gambar Logo
    draw_sprite_ext(sTitle_Logo, 0, _gw / 2, _logo_y, 0.68, 0.68, 0, c_white, 1.0);
    
    // Garis Pembatas Kristal di Bawah Logo
    draw_sprite_ext(sTitle_Divider, 0, _gw / 2, _logo_y + 108, 1.2, 1.0, 0, c_white, 0.85);

    // B. Tombol Menu Pixel Art
    var _btn_sprites = [
        sTitle_Btn_NewGame,
        sTitle_Btn_Continue,
        sTitle_Btn_Settings,
        sTitle_Btn_Credits,
        sTitle_Btn_Exit
    ];

    // Skala dasar agar lebar visual setiap tombol seimbang (~420px)
    var _base_scales = [
        0.75, // New Game (563px * 0.75 = 422px)
        0.98, // Continue (427px * 0.98 = 418px)
        0.98, // Settings (425px * 0.98 = 416px)
        0.98, // Credits (425px * 0.98 = 416px)
        0.98  // Exit (426px * 0.98 = 417px)
    ];

    var _start_y = 305;
    var _spacing = 62;

    for (var _i = 0; _i < array_length(_btn_sprites); _i++) {
        var _by = _start_y + (_i * _spacing);
        var _is_sel = (selected_option == _i);
        var _is_disabled = (_i == 1 && !has_save);
        
        var _sc = _base_scales[_i];
        var _alpha = 0.85;
        var _col = c_white;
        
        if (_is_sel) {
            // Animasi Berdenyut Halus saat Terpilih
            var _pulse = 1.0 + sin(anim_time * 6) * 0.04;
            _sc *= _pulse;
            _alpha = 1.0;
            
            // Pendaran Emas di Belakang Tombol Terpilih
            draw_set_alpha(0.35);
            draw_set_color(make_color_rgb(255, 205, 80));
            draw_ellipse(_gw / 2 - 210, _by - 18, _gw / 2 + 210, _by + 18, false);
            draw_set_alpha(1.0);
            
            // Kursor Kristal Intan Berkilau di Sisi Kiri & Kanan
            var _cur_offset = 225 + sin(anim_time * 5) * 4;
            draw_sprite_ext(sTitle_Icon_Cursor, 0, _gw / 2 - _cur_offset, _by, 0.75, 0.75, 0, c_white, 1.0);
            draw_sprite_ext(sTitle_Icon_Cursor, 0, _gw / 2 + _cur_offset, _by, -0.75, 0.75, 0, c_white, 1.0);
        } else if (_is_disabled) {
            _alpha = 0.45;
            _col = make_color_rgb(130, 130, 140);
        }

        draw_sprite_ext(_btn_sprites[_i], _is_sel ? 1 : 0, _gw / 2, _by, _sc, _sc, 0, _col, _alpha);
    }

    // Info Simpanan Save File (Muncul Elegan di Atas Footer saat Opsi Lanjutkan Dipilih)
    if (selected_option == 1 && has_save) {
        draw_set_alpha(0.92);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(make_color_rgb(255, 235, 140));
        draw_text(_gw / 2, _gh - 58, "📁 " + save_info_str);
    }

    // Panduan Navigasi Bawah
    draw_set_alpha(0.85);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(180, 205, 245));
    draw_text(_gw / 2, _gh - 34, "[W/S / Up/Down] Pilih Menu    •    [Z / ENTER / SPACE] Konfirmasi");
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

    // Panel Window Frosted Glass
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
    draw_sprite_ext(sTitle_Divider, 0, _gw / 2, _py1 + 68, 1.1, 0.8, 0, c_white, 0.8);

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
    draw_sprite_ext(sTitle_Divider, 0, _gw / 2, _py1 + 60, 1.2, 0.8, 0, c_white, 0.8);

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
        "SUTRADARA & TIM PENGEMBANG",
        "Luqman • Pileyo • Elvira",
        "------------------------------------",
        "",
        "DESAIN CERITA & SKENARIO",
        "Kisah Penyelamatan Adik Sestrina",
        "The Overclock Mana Leak Incident",
        "",
        "------------------------------------",
        "SISTEM GAMEPLAY & ARPG",
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
