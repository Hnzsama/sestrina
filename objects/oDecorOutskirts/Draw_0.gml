/// @description Draw Event oDecorOutskirts (Pelataran Hutan Kuil Purba - Full 1280x720)

var _x1 = 40;
var _y1 = 40;
var _x2 = 1240;
var _y2 = 680;
var _cx = 640;

// =========================================================================
// 1. HAMPARAN RUMPUT HIJAU SEAMLESS & BIOMA ALAMI (Lush Meadow Floor)
// =========================================================================
for (var _yy = 0; _yy < room_height; _yy += 32) {
    for (var _xx = 0; _xx < room_width; _xx += 32) {
        // Tile rumput utama 32x32 tanpa garis belang
        draw_sprite_part(sTile_Summer, 0, 16, 96, 32, 32, _xx, _yy);
        
        // Variasi flora alami (bunga liar, semanggi, serpihan batu lumut)
        var _h = ((_xx * 73856093) ^ (_yy * 19349663)) & 255;
        if (_h < 35) {
            draw_sprite_part(sTile_Summer, 0, 32, 96, 16, 16, _xx + 6, _yy + 6); // Bunga liar mekar
        } else if (_h < 65) {
            draw_sprite_part(sTile_Summer, 0, 0, 96, 16, 16, _xx + 4, _yy + 14); // Rumpun semanggi
        } else if (_h < 85) {
            draw_sprite_part(sTile_Summer, 0, 64, 96, 16, 16, _xx + 12, _yy + 8); // Kerikil alam berlumut
        }
    }
}

// =========================================================================
// 2. SUNGAI ALAMI & AIR BERKILAU DI SISI TIMUR (Eastern Forest River)
// =========================================================================
var _river_x1 = _x2 - 140;
var _river_x2 = _x2 - 20;

// Tepian pasir & kerikil sungai (River Bank)
for (var _ry = _y1; _ry < _y2; _ry += 16) {
    var _bank_x = _river_x1 + sin(_ry * 0.02) * 12;
    draw_sprite_part(sTile_Summer, 0, 32, 48, 16, 16, _bank_x - 16, _ry);
}

// Aliran air sungai
for (var _wy = _y1; _wy < _y2; _wy += 16) {
    var _cur_rx1 = _river_x1 + sin(_wy * 0.02) * 12;
    for (var _wx = _cur_rx1; _wx < _river_x2; _wx += 16) {
        draw_sprite_part(sTile_Summer, 0, 112, 128, 16, 16, _wx, _wy);
    }
}

// Efek Kilau Air Sungai Beranimasi (sWaterSparkles)
var _spk = (current_time div 160) mod 4;
draw_sprite(sWaterSparkles, _spk, _river_x1 + 40, 120);
draw_sprite(sWaterSparkles, (_spk + 1) mod 4, _river_x1 + 65, 260);
draw_sprite(sWaterSparkles, (_spk + 2) mod 4, _river_x1 + 35, 420);
draw_sprite(sWaterSparkles, (_spk + 3) mod 4, _river_x1 + 55, 560);

// =========================================================================
// 3. JALAN TANAH BATU BERLIKU (Winding Cobblestone Forest Path)
// =========================================================================
for (var _py = _y1 + 40; _py < _y2 - 20; _py += 16) {
    var _path_w = 76;
    var _path_cx = _cx + sin((_py - _y1) * 0.012) * 55;
    
    // Tepi jalan berkerikil
    for (var _px = _path_cx - _path_w / 2; _px <= _path_cx + _path_w / 2; _px += 16) {
        draw_sprite_part(sTile_Summer, 0, 32, 48, 16, 16, _px, _py);
    }
    
    // Batu tapak alami di tengah jalan
    if ((_py mod 48) == 0) {
        draw_set_color(make_color_rgb(105, 95, 80));
        draw_circle(_path_cx - 10, _py + 8, 3, false);
        draw_circle(_path_cx + 12, _py + 4, 2.5, false);
    }
}

// =========================================================================
// 4. PILAR RERUNTUHAN KUIL PURBA (Ancient Sanctum Pillars & Ruins)
// =========================================================================
// Pilar batu kuil kuno dengan lumut (sDungeon_Props)
draw_sprite_part(sDungeon_Props, 0, 0, 0, 32, 64, 240, 200);
draw_sprite_part(sDungeon_Props, 0, 0, 0, 32, 64, 330, 460);
draw_sprite_part(sDungeon_Props, 0, 0, 0, 32, 64, 910, 190);
draw_sprite_part(sDungeon_Props, 0, 0, 0, 32, 64, 990, 450);

// Bayangan pilar
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(240, 256, 272, 268, false);
draw_ellipse(330, 516, 362, 528, false);
draw_ellipse(910, 246, 942, 258, false);
draw_ellipse(990, 506, 1022, 518, false);
draw_set_alpha(1.0);

// Formasi tebing tebing batu di barat
for (var _cy = 140; _cy < 310; _cy += 16) {
    draw_sprite_part(sTile_Summer, 0, 48, 160, 16, 16, 90, _cy);
    draw_sprite_part(sTile_Summer, 0, 64, 160, 16, 16, 106, _cy);
}

// =========================================================================
// 5. RIMBUNAN POHON OAK & PINUS ALAMI (Organic Forest Groves)
// =========================================================================
// Hutan Barat (West Grove)
draw_sprite_ext(sProp_Trees_Pine, 0, 15, 60, 1.15, 1.15, 0, c_white, 1.0);
draw_sprite(sProp_OakTree, 0, 140, 90);
draw_sprite_ext(sProp_Trees_Pine, 0, 10, 290, 1.1, 1.1, 0, c_white, 1.0);
draw_sprite(sProp_OakTree, 0, 220, 320);
draw_sprite_ext(sProp_Trees_Pine, 0, 25, 490, 1.15, 1.15, 0, c_white, 1.0);
draw_sprite(sProp_OakTree, 0, 130, 530);

// Hutan Tepi Sungai Timur (East River Grove - Bernafas & Alami)
draw_sprite_ext(sProp_Trees_Pine, 0, _river_x1 - 65, 70, 1.1, 1.1, 0, c_white, 1.0);
draw_sprite(sProp_OakTree, 0, _river_x1 - 40, 220);
draw_sprite_ext(sProp_Trees_Pine, 0, _river_x1 - 70, 390, 1.15, 1.15, 0, c_white, 1.0);
draw_sprite(sProp_OakTree, 0, _river_x1 - 45, 510);
draw_sprite_ext(sProp_Trees_Pine, 0, _river_x2 - 40, 600, 1.1, 1.1, 0, c_white, 1.0);

// Guci Hutan & Peti Misterius
draw_sprite(sBreakablePots, 0, 165, 420);
draw_sprite(sBreakablePots, 0, 185, 435);
draw_sprite(sTreasureChest, 0, 160, 230);

// =========================================================================
// =========================================================================
// 6. GERBANG UTARA: PINTU MASUK KATAKOMBE PURBA (Floor 1 Ancient Portal)
// =========================================================================
var _gate_x = _cx;
var _gate_y = _y1 + 22;

// Pelataran Batu Berundak Kuil Kuno
for (var _gy = _gate_y - 10; _gy <= _gate_y + 42; _gy += 16) {
    for (var _gx = _gate_x - 72; _gx <= _gate_x + 72; _gx += 16) {
        draw_sprite_part(sTile_Summer, 0, 48, 48, 16, 16, _gx, _gy);
    }
}

// Relung Pintu Masuk Katakombe Hitam Gelap Menuju Bawah Tanah
draw_set_color(make_color_rgb(10, 12, 18));
draw_roundrect_ext(_gate_x - 34, _gate_y - 8, _gate_x + 34, _gate_y + 36, 14, 14, false);

// Anak Tangga Turun ke Kegelapan Bawah Tanah
draw_set_color(make_color_rgb(35, 38, 48));
draw_line_width(_gate_x - 26, _gate_y + 10, _gate_x + 26, _gate_y + 10, 3);
draw_line_width(_gate_x - 22, _gate_y + 18, _gate_x + 22, _gate_y + 18, 3);
draw_line_width(_gate_x - 18, _gate_y + 26, _gate_x + 18, _gate_y + 26, 3);

// Lengkungan Kubah Portal Batu Kuno (Floor 1 Wall Arch Asset)
draw_sprite_ext(sDungeon_Wall_Arch, 0, _gate_x, _gate_y - 6, 0.72, 0.72, 0, c_white, 1.0);

// Sepasang Pilar Batu Kuno Pengapit Portal (Floor 1 Stone Pillars)
draw_sprite_ext(sDungeon_Pillar_Stone, 0, _gate_x - 52, _gate_y + 6, 0.65, 0.65, 0, c_white, 1.0);
draw_sprite_ext(sDungeon_Pillar_Stone, 0, _gate_x + 52, _gate_y + 6, 0.65, 0.65, 0, c_white, 1.0);

// Obor Api Jiwa Biru di Pilar Gerbang (Floor 1 Soul Torches)
var _flick = sin(current_time * 0.008) * 1.5;
draw_sprite_ext(sDungeon_Decor_WallTorch, 0, _gate_x - 52, _gate_y - 16, 0.55, 0.55, 0, c_white, 1.0);
draw_sprite_ext(sDungeon_Decor_WallTorch, 0, _gate_x + 52, _gate_y - 16, 0.55, 0.55, 0, c_white, 1.0);
draw_sprite_ext(sDungeon_Magic_SoulFlame, 0, _gate_x - 52, _gate_y - 30, 0.45, 0.45, 0, c_white, 0.9);
draw_sprite_ext(sDungeon_Magic_SoulFlame, 0, _gate_x + 52, _gate_y - 30, 0.45, 0.45, 0, c_white, 0.9);

// Pendaran Cahaya Biru Portal
draw_set_alpha(0.22);
draw_set_color(make_color_rgb(80, 180, 255));
draw_circle(_gate_x - 52, _gate_y - 30, 24 + _flick, false);
draw_circle(_gate_x + 52, _gate_y - 30, 24 - _flick, false);
draw_set_alpha(1.0);

// Label Pintu Masuk Katakombe
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(130, 220, 255));
draw_text(_gate_x, _gate_y + 42, "▲ MASUK KATAKOMBE PURBA (DUNGEON F1)");

// =========================================================================
// 7. GERBANG SELATAN: JALAN KELUAR MENUJU KOTA ALTDORF (South Altdorf Exit)
// =========================================================================
var _exit_x = _cx;
var _exit_y = _y2 - 20;

// Pelataran Cobblestone Pintu Keluar
for (var _sy = _exit_y - 24; _sy <= _exit_y + 16; _sy += 16) {
    for (var _sx = _exit_x - 64; _sx <= _exit_x + 64; _sx += 16) {
        draw_sprite_part(sTile_Summer, 0, 32, 48, 16, 16, _sx, _sy);
    }
}

// Tiang Gapura Kayu & Batu Perbatasan Kota Altdorf
draw_set_color(make_color_rgb(62, 45, 30)); // Kayu jati gelap
draw_roundrect_ext(_exit_x - 52, _exit_y - 28, _exit_x - 40, _exit_y + 12, 4, 4, false);
draw_roundrect_ext(_exit_x + 40, _exit_y - 28, _exit_x + 52, _exit_y + 12, 4, 4, false);
// Palang Balok Kayu Atas
draw_roundrect_ext(_exit_x - 56, _exit_y - 32, _exit_x + 56, _exit_y - 24, 4, 4, false);

// Lentera Jalan Perbatasan Emas Berpendar Hangat
draw_set_color(make_color_rgb(255, 205, 80));
draw_circle(_exit_x - 46, _exit_y - 18, 3.2, false);
draw_circle(_exit_x + 46, _exit_y - 18, 3.2, false);
draw_set_color(c_white);
draw_circle(_exit_x - 46, _exit_y - 18, 1.5, false);
draw_circle(_exit_x + 46, _exit_y - 18, 1.5, false);

// Garis Peringatan Kuning-Emas
draw_set_color(make_color_rgb(230, 190, 90));
draw_line_width(_exit_x - 38, _exit_y + 6, _exit_x + 38, _exit_y + 6, 2.5);

// Label Pintu Keluar Kota
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(255, 235, 150));
draw_text(_exit_x, _exit_y - 38, "▼ KEMBALI KE KOTA ALTDORF");

// =========================================================================
// 8. PARTIKEL AMBIENT MANA WISPS & KABUT RIMBA (Atmosphere & Forest Wisps)
// =========================================================================
// Partikel Mana Wisps Biru Mengambang Halus
for (var _w = 0; _w < array_length(wisps); _w++) {
    var _wp = wisps[_w];
    var _w_alpha = 0.45 + sin(tree_sway + _wp.phase) * 0.25;
    draw_set_alpha(_w_alpha);
    draw_set_color(make_color_rgb(140, 225, 255));
    draw_circle(_wp.xx, _wp.yy, _wp.rad, false);
    draw_set_color(c_white);
    draw_circle(_wp.xx, _wp.yy, _wp.rad * 0.45, false);
}

// Lapisan Kabut Hutan Lembut (Forest Mist)
draw_set_alpha(0.08);
draw_set_color(make_color_rgb(215, 235, 255));
for (var _m = 0; _m < 4; _m++) {
    var _my = _y1 + 80 + _m * 145 + sin(mist_anim + _m) * 18;
    draw_ellipse(_x1, _my - 40, _x2, _my + 40, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
