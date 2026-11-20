/// @description Draw Event oRoomTransition - Dynamic Day/Night World Lighting & Ambient Glow

if (room == rm_main_menu) exit;

var _time_str = variable_global_exists("time_of_day") ? global.time_of_day : "Daytime";

// =========================================================================
// 1. NIGHTTIME AMBIENT OVERLAY & LIGHT SOURCES (JRPG Soft Mood Lighting)
// =========================================================================
if (_time_str == "Nighttime") {
    var _rname = room_get_name(room);
    
    // Lapisan Gelap Biru Malam (Deep Moody Twilight Blue - Nyaman & Tidak Buta)
    draw_set_alpha(0.38);
    draw_set_color(make_color_rgb(14, 18, 42));
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1.0);
    
    // Sistem Pencahayaan Additive Lembut & Natural (Multi-Step Soft Radial Falloff)
    gpu_set_blendmode(bm_add);
    
    // Fungsi Pendaran Cahaya Lentera Hangat (Amber/Warm Glow)
    var _draw_lantern_glow = function(_lx, _ly, _rad = 54, _intensity = 1.0) {
        var _flick = sin(current_time * 0.005 + _lx) * 1.5;
        var _r = _rad + _flick;
        var _col_amber = make_color_rgb(255, 160, 60);
        
        // Ring 1: Pendaran terluar sangat tipis & berbaur lembut dengan malam
        draw_set_alpha(0.04 * _intensity);
        draw_set_color(_col_amber);
        draw_circle(_lx, _ly, _r, false);
        
        // Ring 2: Pendaran hangat sekunder
        draw_set_alpha(0.09 * _intensity);
        draw_circle(_lx, _ly, _r * 0.62, false);
        
        // Ring 3: Pendaran dekat sumber cahaya
        draw_set_alpha(0.18 * _intensity);
        draw_circle(_lx, _ly, _r * 0.32, false);
        
        // Ring 4: Titik fokus lentera hangat
        draw_set_alpha(0.35 * _intensity);
        draw_set_color(make_color_rgb(255, 240, 190));
        draw_circle(_lx, _ly, max(2, _r * 0.12), false);
    };

    // Fungsi Pendaran Cahaya Mistis Biru (Soul Fire / Arcane Glow)
    var _draw_blue_glow = function(_lx, _ly, _rad = 50, _intensity = 1.0) {
        var _flick = sin(current_time * 0.006 + _lx) * 1.5;
        var _r = _rad + _flick;
        var _col_blue = make_color_rgb(45, 140, 255);
        
        draw_set_alpha(0.04 * _intensity);
        draw_set_color(_col_blue);
        draw_circle(_lx, _ly, _r, false);
        
        draw_set_alpha(0.10 * _intensity);
        draw_circle(_lx, _ly, _r * 0.58, false);
        
        draw_set_alpha(0.24 * _intensity);
        draw_set_color(make_color_rgb(180, 235, 255));
        draw_circle(_lx, _ly, max(2, _r * 0.15), false);
    };
    
    // A. Cahaya Lembut Sekitar Pemain (Ambient Self-Presence, bukan spotlight bulat tajam)
    if (instance_exists(oPlayer)) {
        var _px = oPlayer.x;
        var _py = oPlayer.y - 12;
        var _hflick = sin(current_time * 0.005) * 1.0;
        
        draw_set_alpha(0.03);
        draw_set_color(make_color_rgb(255, 210, 140));
        draw_circle(_px, _py, 45 + _hflick, false);
        
        draw_set_alpha(0.06);
        draw_circle(_px, _py, 22 + _hflick * 0.5, false);
    }
    
    // B. Cahaya Titik Spesifik per Ruangan (HANYA pada Lentera/Obor yang Nyata)
    if (_rname == "rm_town_square") {
        var _cx = 1280;
        var _cy = 720;
        
        // 1. Empat Lentera Tiang di Sudut Alun-Alun Plaza
        _draw_lantern_glow(_cx - 130, _cy - 128, 55);
        _draw_lantern_glow(_cx + 110, _cy - 128, 55);
        _draw_lantern_glow(_cx - 130, _cy + 32, 55);
        _draw_lantern_glow(_cx + 110, _cy + 32, 55);
        
        // 2. Lentera Tiang Boulevard Utama (Jalan Utara & Selatan)
        _draw_lantern_glow(_cx - 68, 352, 52);
        _draw_lantern_glow(_cx + 52, 352, 52);
        _draw_lantern_glow(_cx - 68, 832, 52);
        _draw_lantern_glow(_cx + 52, 832, 52);
        
        // 3. Lentera Persimpangan Jalan Lingkungan
        _draw_lantern_glow(460, 412, 50);
        _draw_lantern_glow(1380, 412, 50);
        _draw_lantern_glow(2110, 412, 50);
        
        // 4. Cahaya Hangat Jendela Toko yang Masih Buka di Malam Hari
        _draw_lantern_glow(520, 235, 48, 0.7);   // Bengkel Goran
        _draw_lantern_glow(2040, 235, 48, 0.7);  // Apotek Elysia
        _draw_lantern_glow(1680, 235, 42, 0.6);  // Toko Roti
        
        // 5. Lentera Gerbang Benteng Utara & Selatan
        _draw_lantern_glow(_cx - 65, 145, 46, 0.8);
        _draw_lantern_glow(_cx + 65, 145, 46, 0.8);
        
    } else if (_rname == "Room1") {
        // Pondok Sestrina: Perapian hangat & lilin kamar
        _draw_lantern_glow(250, 115, 85, 1.2); // Perapian Dapur
        _draw_lantern_glow(460, 290, 45, 0.8); // Lilin Meja Tengah
        _draw_lantern_glow(920, 200, 48, 0.9); // Lilin Ranjang Sestrina
        _draw_lantern_glow(990, 490, 38, 0.6); // Meja Rias
        
    } else if (_rname == "rm_weapon_shop") {
        _draw_lantern_glow(640, 90, 90, 1.3); // Tungku Tempa Bara Besi Goran
        _draw_lantern_glow(82, 200, 45, 0.7);
        _draw_lantern_glow(1198, 200, 45, 0.7);
        
    } else if (_rname == "rm_potion_shop") {
        _draw_lantern_glow(640, 265, 55, 0.9); // Meja Ramuan Alkemis Elysia
        _draw_blue_glow(380, 180, 42, 0.8);    // Botol Eliksir Berpendar
        _draw_blue_glow(900, 180, 42, 0.8);
        
    } else if (_rname == "rm_catacombs") {
        // Obor Jiwa Biru di Sepanjang Dinding Utara Katakombe
        _draw_blue_glow(160, 85, 55);
        _draw_blue_glow(440, 85, 55);
        _draw_blue_glow(640, 85, 55);
        _draw_blue_glow(840, 85, 55);
        _draw_blue_glow(1120, 85, 55);
        
        // Tungku Api Katakombe
        _draw_lantern_glow(520, 240, 46);
        _draw_lantern_glow(760, 240, 46);
        
    } else if (_rname == "rm_dungeon_floor2") {
        // 4 Pilar Lentera Tambang Purba Lantai 2
        _draw_lantern_glow(380, 220, 60, 1.1);
        _draw_lantern_glow(900, 220, 60, 1.1);
        _draw_lantern_glow(380, 420, 60, 1.1);
        _draw_lantern_glow(900, 420, 60, 1.1);
        
        // Pendaran Kristal Biru Kereta Tambang & Suaka Runic
        _draw_blue_glow(230, 240, 50, 0.9);
        _draw_blue_glow(1080, 220, 55, 1.0);
    } else if (_rname == "rm_boss_chamber") {
        _draw_blue_glow(640, 344, 75, 1.2);
        _draw_blue_glow(420, 220, 50, 0.8);
        _draw_blue_glow(860, 220, 50, 0.8);
    }
    
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
