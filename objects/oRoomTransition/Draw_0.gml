/// @description Draw Event oRoomTransition - Dynamic Day/Night World Lighting & Ambient Glow

var _time_str = variable_global_exists("time_of_day") ? global.time_of_day : "Daytime";

// =========================================================================
// 1. NIGHTTIME AMBIENT OVERLAY & LIGHT SOURCES (Reference: night outdoor bar.png)
// =========================================================================
if (_time_str == "Nighttime") {
    var _rname = room_get_name(room);
    
    // Lapisan Gelap Biru Malam (Deep Night Ambient Tint)
    draw_set_alpha(0.48);
    draw_set_color(make_color_rgb(8, 14, 32));
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1.0);
    
    // Sistem Pencahayaan Additive (Lanterns, Fireplaces, Torches, Player Halo)
    gpu_set_blendmode(bm_add);
    
    // A. Cahaya Obor / Lentera Pribadi Karakter Utama (Player Halo)
    if (instance_exists(oPlayer)) {
        var _px = oPlayer.x;
        var _py = oPlayer.y;
        var _hflick = sin(current_time * 0.008) * 3;
        
        draw_set_alpha(0.24);
        draw_set_color(make_color_rgb(255, 180, 80));
        draw_circle(_px, _py - 10, 85 + _hflick, false);
        
        draw_set_alpha(0.38);
        draw_set_color(make_color_rgb(255, 220, 130));
        draw_circle(_px, _py - 10, 45 + _hflick * 0.5, false);
    }
    
    // B. Cahaya Lentera & Perapian Berdasarkan Ruangan
    var _draw_light_source = function(_lx, _ly, _rad, _col_inner, _col_outer, _alpha_mult = 1.0) {
        var _lflick = sin(current_time * 0.006 + _lx) * 4;
        draw_set_alpha(0.22 * _alpha_mult);
        draw_set_color(_col_outer);
        draw_circle(_lx, _ly, _rad + _lflick, false);
        draw_set_alpha(0.42 * _alpha_mult);
        draw_set_color(_col_inner);
        draw_circle(_lx, _ly, _rad * 0.45 + _lflick * 0.5, false);
    };
    
    var _c_warm_inner = make_color_rgb(255, 235, 140);
    var _c_warm_outer = make_color_rgb(255, 140, 40);
    var _c_blue_inner = make_color_rgb(180, 230, 255);
    var _c_blue_outer = make_color_rgb(40, 140, 255);
    
    if (_rname == "rm_town_square") {
        // Lentera Alun-Alun Pusat Plaza
        _draw_light_source(1180, 620, 80, _c_warm_inner, _c_warm_outer);
        _draw_light_source(1380, 620, 80, _c_warm_inner, _c_warm_outer);
        _draw_light_source(1180, 820, 80, _c_warm_inner, _c_warm_outer);
        _draw_light_source(1380, 820, 80, _c_warm_inner, _c_warm_outer);

        // Distrik Pengrajin & Pasar Barat
        _draw_light_source(520, 390, 75, _c_warm_inner, _c_warm_outer);  // Toko Goran
        _draw_light_source(700, 560, 65, _c_warm_inner, _c_warm_outer);  // Kios Pasar Atas
        _draw_light_source(700, 680, 65, _c_warm_inner, _c_warm_outer);  // Kios Pasar Bawah

        // Distrik Apotek Elysia & Kebun Botani
        _draw_light_source(2040, 390, 75, _c_warm_inner, _c_warm_outer); // Apotek Elysia
        _draw_light_source(1840, 520, 65, _c_warm_inner, _c_warm_outer); // Kebun Botani

        // Teras Kafe / Outdoor Bar Barat Daya
        _draw_light_source(540, 1030, 65, _c_warm_inner, _c_warm_outer);
        _draw_light_source(680, 1030, 65, _c_warm_inner, _c_warm_outer);
        _draw_light_source(800, 1030, 65, _c_warm_inner, _c_warm_outer);

        // Dermaga Sungai Timur & Gerbang Kota
        _draw_light_source(2360, 1000, 75, _c_warm_inner, _c_warm_outer); // Dermaga Nelayan
        _draw_light_source(1280, 120, 85, _c_warm_inner, _c_warm_outer);   // Gerbang Utara
        _draw_light_source(1280, 1345, 95, _c_warm_inner, _c_warm_outer);  // Gerbang Selatan Benteng
    } else if (_rname == "Room1") {
        // Sayap Kiri: Ruang Tamu, Perapian & Dapur
        _draw_light_source(250, 115, 110, _c_warm_inner, _c_warm_outer); // Kobaran Perapian Kayu Hangat Dapur
        _draw_light_source(460, 290, 60, _c_warm_inner, _c_warm_outer);  // Lilin Meja Makan & Minum
        _draw_light_source(280, 480, 60, _c_warm_inner, _c_warm_outer);  // Lilin Meja Kerja Adventurer

        // Sayap Kanan: Kamar Pribadi Sestrina
        _draw_light_source(920, 200, 75, _c_warm_inner, _c_warm_outer);  // Lilin Herbal Penenang Dekat Kasur Adik
        _draw_light_source(990, 490, 50, _c_warm_inner, _c_warm_outer);  // Lilin Meja Rias Sestrina
    } else if (_rname == "rm_weapon_shop") {
        // Tungku Tempa Raksasa Goran
        _draw_light_source(640, 90, 130, _c_warm_inner, _c_warm_outer);
        _draw_light_source(82, 200, 60, _c_warm_inner, _c_warm_outer);
        _draw_light_source(1198, 200, 60, _c_warm_inner, _c_warm_outer);
    } else if (_rname == "rm_potion_shop") {
        // Lilin Riset & Lampu Alkemis Elysia
        _draw_light_source(640, 265, 75, _c_warm_inner, _c_warm_outer);
        _draw_light_source(82, 200, 60, _c_warm_inner, _c_warm_outer);
        _draw_light_source(1198, 200, 60, _c_warm_inner, _c_warm_outer);
    } else if (_rname == "rm_catacombs") {
        // Obor Api Jiwa Biru
        _draw_light_source(120, 90, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(360, 90, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(640, 90, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(920, 90, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(1160, 90, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(120, 360, 70, _c_blue_inner, _c_blue_outer);
        _draw_light_source(1160, 360, 70, _c_blue_inner, _c_blue_outer);
    } else if (_rname == "rm_boss_chamber") {
        // Altar The Lost Remedy & Pilar Arcane
        _draw_light_source(640, 344, 90, _c_blue_inner, _c_blue_outer);
        _draw_light_source(420, 220, 60, _c_blue_inner, _c_blue_outer);
        _draw_light_source(860, 220, 60, _c_blue_inner, _c_blue_outer);
    }
    
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
