/// @description Draw Event oDecorTown (Kota Altdorf - Terstruktur, Rapi, Jelas: Jalan, Taman, Rumah Sesuai Referensi)

var _cx = 1280;
var _cy = 720;
var _w = room_width;
var _h = room_height;

// =========================================================================
// 1. HAMPARAN RUMPUT KOTA BERSIH & SUBUR (Clean Lush Lawn Base)
// =========================================================================
draw_set_color(make_color_rgb(116, 174, 66));
draw_rectangle(0, 0, _w, _h, false);

// Aksen variasi tekstur rumput alami lembut
for (var _yy = 0; _yy < _h; _yy += 48) {
    for (var _xx = 0; _xx < _w; _xx += 48) {
        var _hash = ((_xx * 73856093) ^ (_yy * 19349663)) & 255;
        if (_hash < 20) {
            draw_set_color(make_color_rgb(106, 162, 58));
            draw_circle(_xx + 16, _yy + 16, 12, false);
        } else if (_hash < 38) {
            draw_set_color(make_color_rgb(126, 184, 76));
            draw_circle(_xx + 20, _yy + 20, 9, false);
        } else if (_hash < 48) {
            draw_sprite_part(sTile_Summer, 0, 0, 96, 16, 16, _xx + 12, _yy + 12);
        }
    }
}


// =========================================================================
// 2. SISTEM JARINGAN JALAN UTAMA & BOULEVARD KOTA (Paved Roads & Curbs)
// =========================================================================

// --- A. Boulevard Utama Vertikal (Utara <-> Alun-Alun <-> Gerbang Selatan) ---
// Lebar 96px (x: 1232..1328)
scr_draw_cobblestone_road(_cx - 48, 60, _cx + 48, 380, true, false, true, true);        // Segmen Utara
scr_draw_cobblestone_road(_cx - 48, 380, _cx + 48, 440, false, false, false, false);    // Persimpangan Avenue Utara (terbuka 4 arah)
scr_draw_cobblestone_road(_cx - 48, 440, _cx + 48, 600, false, false, true, true);       // Menuju Alun-Alun
scr_draw_cobblestone_road(_cx - 48, 840, _cx + 48, 1400, false, true, true, true);      // Dari Alun-Alun ke Gerbang Selatan

// --- B. Boulevard Utama Horizontal (Barat <-> Alun-Alun <-> Timur) ---
// Lebar 80px (y: 680..760)
scr_draw_cobblestone_road(380, _cy - 40, _cx - 120, _cy + 40, true, true, true, false);  // Barat ke Plaza
scr_draw_cobblestone_road(_cx + 120, _cy - 40, 2260, _cy + 40, true, true, false, true); // Plaza ke Timur

// --- C. Jalan Horizontal Utara (Artisan & Scholar Avenue di y: 380..440) ---
// Sisi Barat: Depan Bengkel Tempa Goran & Pemukiman Utara-Barat menuju Boulevard
scr_draw_cobblestone_road(440, 380, _cx - 48, 440, true, true, false, false);

// Sisi Timur: Boulevard menuju Depan Apotek Elysia
scr_draw_cobblestone_road(_cx + 48, 380, 2120, 440, true, true, false, false);

// --- D. Jalan Vertikal Distrik Barat (x: 480..560) ---
// Terhubung dari Jalan Horizontal Utara ke Bazaar dan Kedai Tavern
scr_draw_cobblestone_road(480, 440, 560, 560, false, false, true, true);
scr_draw_cobblestone_road(480, 560, 560, 640, false, false, true, false); // Terbuka ke pintu Bazaar
scr_draw_cobblestone_road(480, 640, 560, _cy - 40, false, false, true, true);

// Jalan Akses Pintu Masuk Pasar Bazaar Barat (x: 560..580, y: 560..640)
scr_draw_cobblestone_road(560, 560, 580, 640, true, true, false, false);

// --- E. Jalan Akses Distrik Pemukiman Tenggara ---
// Jalan Penghubung Vertikal dari Boulevard ke Pemukiman (x: 1540..1600, y: 760..920)
scr_draw_cobblestone_road(1540, 760, 1600, 920, false, false, true, true);

// Jalan Utama Pemukiman Tenggara (x: 1540..2280, y: 920..980)
scr_draw_cobblestone_road(1540, 920, 2280, 980, true, true, true, false);

// --- F. Jalan Akses Teras Tavern Barat Daya ---
scr_draw_cobblestone_road(480, 760, 560, 1060, false, true, true, true);
scr_draw_cobblestone_road(340, 980, 480, 1040, true, true, false, false); // Akses ke teras kafe


// =========================================================================
// 3. ALUN-ALUN PUSAT & AIR MANCUR MEGAH (Central Cobblestone Plaza)
// =========================================================================
// Dasar bundar batu paving bersih radius 120px
draw_set_color(make_color_rgb(195, 200, 208));
draw_circle(_cx, _cy, 120, false);

// Pola batu paving plaza
var _step = 16;
for (var _py = _cy - 120; _py < _cy + 120; _py += _step) {
    var _row = (_py - (_cy - 120)) div _step;
    var _xoff = (_row mod 2 == 1) ? 8 : 0;
    for (var _px = _cx - 120 + _xoff; _px < _cx + 120; _px += _step) {
        if (point_distance(_px + 8, _py + 8, _cx, _cy) < 116) {
            var _c_val = 190 + (((_px * 37) ^ (_py * 67)) mod 14);
            draw_set_color(make_color_rgb(_c_val, _c_val + 4, _c_val + 8));
            draw_rectangle(_px, _py, _px + _step - 2, _py + _step - 2, false);
            draw_set_color(make_color_rgb(228, 232, 240));
            draw_point(_px + 1, _py + 1);
        }
    }
}

// Cincin trotoar batu timbul di sekeliling lingkaran plaza
draw_set_color(make_color_rgb(55, 60, 68));
draw_circle(_cx, _cy, 122, true);
draw_set_color(make_color_rgb(222, 226, 235));
draw_circle(_cx, _cy, 120, true);
draw_circle(_cx, _cy, 118, true);

// Air Mancur Kota Altdorf di Tengah-Tengah Alun-Alun (Origin 0,0 ukuran 128x128)
// Posisi (1216, 656) menghasilkan titik tengah persis di (1280, 720)
draw_sprite(sProp_Fountain, 0, _cx - 64, _cy - 64);

// 4 Bangku Taman Kayu Mengelilingi Alun-Alun
scr_draw_park_bench(_cx - 68, _cy - 72, 44);  // Barat Laut
scr_draw_park_bench(_cx + 68, _cy - 72, 44);  // Timur Laut
scr_draw_park_bench(_cx - 68, _cy + 72, 44);  // Barat Daya
scr_draw_park_bench(_cx + 68, _cy + 72, 44);  // Timur Daya

// 4 Lentera Jalan di 4 Sudut Plaza
scr_draw_street_lamp(_cx - 100, _cy - 80);
scr_draw_street_lamp(_cx + 100, _cy - 80);
scr_draw_street_lamp(_cx - 100, _cy + 80);
scr_draw_street_lamp(_cx + 100, _cy + 80);

// Papan Pengumuman Kerajaan (Notice Board di x=1140, y=615)
draw_sprite(sProp_NoticeBoard, 0, 1140, 615);


// =========================================================================
// 4. TAMAN KOTA & KEBUN BOTANI INDAH (Persis Referensi Gambar 1 & 2!)
// =========================================================================
// Kotak trotoar batu pelindung taman kota (x: 1400..1920, y: 450..670)
scr_draw_curb_box(1400, 450, 1920, 670);
draw_set_color(make_color_rgb(112, 170, 62));
draw_rectangle(1402, 452, 1918, 668, false);

// --- A. Barisan 6 Pohon Rindang di Atas Taman (Sesuai Referensi Gambar 2!) ---
var _tree_x = [1410, 1500, 1590, 1680, 1770, 1855];
for (var _t = 0; _t < array_length(_tree_x); _t++) {
    scr_draw_tree_with_shadow(_tree_x[_t], 380);
}

// --- B. Kolam Taman Barat dengan Teratai (x: 1415..1495, y: 495..575) ---
scr_draw_park_pond(1415, 495, 1495, 575);

// --- C. Kolam Panjang Selatan & Jembatan Kayu (Sesuai Referensi Gambar 2!) ---
// Kolam memanjang di bagian bawah taman (x: 1510..1810, y: 620..660)
scr_draw_park_pond(1510, 620, 1810, 660);

// Jembatan Penyeberangan Kayu Artistik Melintasi Kolam Panjang (x: 1640..1680, y: 614..666)
scr_draw_wooden_bridge(1640, 614, 1680, 666);

// --- D. Jalan Setapak Paving Bersih di Dalam Taman ---
scr_draw_cobblestone_road(1500, 460, 1820, 490, true, true, false, false); // Jalan atas taman
scr_draw_cobblestone_road(1640, 490, 1680, 614, false, false, true, true);  // Jalan poros tengah menuju jembatan

// --- E. Petak Bunga Manicured Berpagar Batu (Sesuai Referensi Gambar 1 & 2!) ---
scr_draw_flowerbed(1510, 500, 1630, 545, 1); // Petak Bunga Lili Putih Murni (Kiri Poros)
scr_draw_flowerbed(1690, 500, 1810, 545, 0); // Petak Bunga Calendula Emas (Kanan Poros)
scr_draw_flowerbed(1830, 495, 1910, 595, 2); // Petak Lavender Ungu Harum (Sisi Timur)

// --- F. Courtyard Bangku Santai Tempat Duduk Pengunjung Taman (Story NPC Lily di 1840, 520) ---
scr_draw_park_bench(1570, 570, 48); // Bangku barat
scr_draw_park_bench(1750, 570, 48); // Bangku timur
scr_draw_park_bench(1870, 615, 40); // Bangku samping lavender

// Lentera Taman
scr_draw_street_lamp(1500, 460);
scr_draw_street_lamp(1820, 460);
scr_draw_street_lamp(1630, 614);
scr_draw_street_lamp(1690, 614);


// =========================================================================
// 5. DISTRIK PENGRAJIN & BENGKEL TEMPA GORAN (North-West Artisan Quarter)
// =========================================================================
// Toko & Bengkel Tempa Goran (Pintu presisi di x: 520, y: 380)
draw_sprite_ext(sBuilding_Blacksmith, 0, 440, 200, 0.85, 0.85, 0, c_white, 1.0);

// Halaman Khusus Bengkel Tempa Goran (Paved Forge Courtyard)
scr_draw_cobblestone_road(310, 270, 456, 380, true, false, true, false);

// Peralatan Bengkel Tempa Goran di Dalam Halaman Paving
draw_sprite_part_ext(sStation_Furnace, 0, 0, 0, 64, 80, 320, 275, 1.0, 1.0, c_white, 1.0); // Tungku Bara
draw_sprite_part_ext(sStation_Anvil, 0, 0, 0, 64, 48, 395, 320, 0.95, 0.95, c_white, 1.0);   // Anvil
draw_sprite(sTreasureChest, 0, 325, 350);                                                        // Peti Material Besi

// Pagar Pembatas Rendah Rapi di Tepi Barat Bengkel
for (var _fy = 270; _fy < 360; _fy += 32) {
    draw_sprite_part(sProp_Fences, 0, 0, 0, 32, 32, 304, _fy);
}

// Rumah Tukang Kayu / Carpenter di Sisi Paling Barat Berjarak Lega & Rapi
draw_sprite_ext(sBuilding_House_Amber, 0, 70, 140, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 70, 400, 0.85, 0.85, 0, c_white, 1.0);
scr_draw_tree_with_shadow(100, 320); // Pohon pelindung di antara 2 rumah


// =========================================================================
// 6. DISTRIK ALKEMIS & APOTEK ELYSIA (North-East Scholar Quarter)
// =========================================================================
// Toko Roti / Bakery di Sisi Kiri Apotek Elysia
draw_sprite_ext(sBuilding_Bakery, 0, 1740, 195, 0.82, 0.82, 0, c_white, 1.0);

// Apotek Herbal & Lab Alkimia Elysia (Pintu presisi di x: 2040, y: 380)
draw_sprite_ext(sBuilding_Apothecary, 0, 1960, 200, 0.85, 0.85, 0, c_white, 1.0);

// Kincir Angin Batu di Area Perbukitan Timur Laut
draw_sprite_ext(sBuilding_Windmill, 0, 2220, 110, 0.85, 0.85, 0, c_white, 1.0);

// Teras Samping Lab Alkimia Luar Elysia (x: 2104..2220, y: 280..380)
scr_draw_cobblestone_road(2104, 280, 2220, 380, true, false, false, true);
draw_sprite_part_ext(sStation_Alchemy, 0, 0, 0, 64, 64, 2125, 290, 1.0, 1.0, c_white, 1.0); // Meja Racik
draw_sprite_part(sProp_OutdoorDecor, 0, 0, 64, 32, 32, 2130, 348);                           // Pot Herbal


// =========================================================================
// 7. PEMUKIMAN WARGA UTARA & TENGGARA (Assets dari Fantasy RPG Town Collection)
// =========================================================================

// --- A. Rumah Deret Utara-Barat (x: 690..1180, y: 130) ---
draw_sprite_ext(sBuilding_House_Red, 0, 690, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 860, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1030, 130, 0.82, 0.82, 0, c_white, 1.0);

// Jalan Setapak Rumah ke Trotoar Avenue (y: 300..380)
scr_draw_cobblestone_road(748, 300, 780, 380, false, false, true, true);
scr_draw_cobblestone_road(918, 300, 950, 380, false, false, true, true);
scr_draw_cobblestone_road(1088, 300, 1120, 380, false, false, true, true);

// --- B. Rumah Deret Utara-Timur (x: 1440..1760, y: 130) ---
draw_sprite_ext(sBuilding_House_Amber, 0, 1440, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1610, 130, 0.82, 0.82, 0, c_white, 1.0);

// Pohon rindang pelindung alami di antara pemukiman dan Bakery
scr_draw_tree_with_shadow(1820, 180);

// Jalan Setapak Rumah ke Trotoar Avenue (y: 300..380)
scr_draw_cobblestone_road(1488, 300, 1520, 380, false, false, true, true);
scr_draw_cobblestone_road(1668, 300, 1700, 380, false, false, true, true);

// --- C. Kompleks Perumahan Tenggara (Baris Atas, Jalan Tengah, Baris Bawah) ---
// 1. Baris Rumah Atas (y: 730)
draw_sprite_ext(sBuilding_House_Blue, 0, 1660, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 1820, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Red, 0, 1980, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 2140, 730, 0.80, 0.80, 0, c_white, 1.0);

// Jalan Setapak Rumah Baris Atas ke Jalan Pemukiman
scr_draw_cobblestone_road(1710, 890, 1734, 920, false, false, true, true);
scr_draw_cobblestone_road(1870, 890, 1894, 920, false, false, true, true);
scr_draw_cobblestone_road(2030, 890, 2054, 920, false, false, true, true);
scr_draw_cobblestone_road(2190, 890, 2214, 920, false, false, true, true);

// 2. Baris Rumah Bawah (y: 990)
draw_sprite_ext(sBuilding_House_Amber, 0, 1660, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Red, 0, 1820, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1980, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 2140, 990, 0.80, 0.80, 0, c_white, 1.0);

// Jalan Setapak Rumah Baris Bawah dari Jalan Pemukiman
scr_draw_cobblestone_road(1710, 980, 1734, 1010, false, false, true, true);
scr_draw_cobblestone_road(1870, 980, 1894, 1010, false, false, true, true);
scr_draw_cobblestone_road(2030, 980, 2054, 1010, false, false, true, true);
scr_draw_cobblestone_road(2190, 980, 2214, 1010, false, false, true, true);

// Sumur Batu Desa Kuno di Taman Samping Jalan Pemukiman (Aset Asli Stone Water Well)
draw_sprite_ext(sBuilding_WaterWell, 0, 1445, 905, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 8. KEDAI TAVERN & TERAS KAFE LUAR RUANGAN (Outdoor Tavern Terrace)
// =========================================================================
// Bangunan Penginapan / Kedai Tavern Baru (Aset Asli Inn & Tavern Building)
draw_sprite_ext(sBuilding_Tavern, 0, 130, 910, 0.85, 0.85, 0, c_white, 1.0);

// Teras Kafe Paving Batu Rapi (x: 340..560, y: 960..1060)
scr_draw_curb_box(340, 960, 560, 1060);
draw_set_color(make_color_rgb(192, 196, 204));
draw_rectangle(342, 962, 558, 1058, false);

// 3 Meja Kafe Luar Ruangan dengan Kursi Kayu & Minuman (Dekat Patron Finn di x: 570, y: 1030)
scr_draw_cafe_table(390, 1000);
scr_draw_cafe_table(470, 1000);
scr_draw_cafe_table(430, 1040);

// Pagar Kayu Pembatas Teras Tavern
for (var _tx = 340; _tx < 560; _tx += 32) {
    if (!(_tx >= 440 && _tx <= 480)) { // Bukaan pintu teras
        draw_sprite_part(sProp_Fences, 0, 0, 0, 32, 32, _tx, 955);
    }
}


// =========================================================================
// 9. PASAR BAZAAR KOTA ALTDORF (Paved Market Square & Stalls)
// =========================================================================
// Pelataran Paving Pasar Bazaar
scr_draw_curb_box(580, 550, 1060, 660);
draw_set_color(make_color_rgb(195, 200, 208));
draw_rectangle(582, 552, 1058, 658, false);

// Nat paving pasar
for (var _my = 552; _my < 658; _my += 16) {
    draw_set_color(make_color_rgb(165, 170, 178));
    draw_line(582, _my, 1058, _my);
}

// 4 Kios Pasar Bazaar Koleksi Pixel Art Fantasi
draw_sprite_ext(sBuilding_MarketStall, 0, 620, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 730, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 840, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 950, 545, 0.85, 0.85, 0, c_white, 1.0);

// Papan Nama BAZAAR Elegan Beratap Emas
draw_set_color(make_color_rgb(32, 34, 40));
draw_roundrect_ext(770, 520, 870, 540, 4, 4, false);
draw_set_color(make_color_rgb(255, 215, 80));
draw_roundrect_ext(770, 520, 870, 540, 4, 4, true);
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(820, 530, "BAZAAR");

// Peti & Karung Barang Dagangan
draw_sprite_part(sProp_OutdoorDecor, 0, 0, 0, 32, 32, 600, 615);
draw_sprite_part(sProp_OutdoorDecor, 0, 32, 0, 32, 32, 740, 615);
draw_sprite_part(sProp_OutdoorDecor, 0, 0, 0, 32, 32, 880, 615);
draw_sprite_part(sProp_OutdoorDecor, 0, 32, 32, 32, 32, 1010, 610);


// =========================================================================
// 10. DERMAGA SUNGAI TIMUR (River Canal & Fishing Dock)
// =========================================================================
var _spk_f = (current_time div 180) mod 4;

// Aliran Sungai Biru Bersih di Tepi Timur (x: 2360.._w)
draw_set_color(make_color_rgb(26, 75, 105));
draw_rectangle(2360, 0, _w, _h, false);

// Tanggul Dinding Batu Sungai (x: 2340..2360)
draw_set_color(make_color_rgb(70, 75, 85));
draw_rectangle(2340, 0, 2360, _h, false);
draw_set_color(make_color_rgb(185, 190, 200));
for (var _ty = 0; _ty < _h; _ty += 24) {
    draw_rectangle(2342, _ty, 2358, _ty + 20, false);
}

// Dermaga Kayu Nelayan Kakek Tobias (x: 2280..2440, y: 970..1050)
draw_set_color(make_color_rgb(95, 62, 35));
draw_rectangle(2280, 970, 2440, 1050, false);
draw_set_color(make_color_rgb(145, 100, 60));
for (var _py = 974; _py < 1048; _py += 12) {
    draw_line_width(2282, _py, 2438, _py, 2);
}
draw_sprite_part(sProp_OutdoorDecor, 0, 32, 0, 32, 32, 2300, 980);
draw_sprite_part(sProp_OutdoorDecor, 0, 0, 0, 32, 32, 2340, 1010);
draw_sprite(sWaterSparkles, _spk_f, 2400, 240);
draw_sprite(sWaterSparkles, (_spk_f + 1) mod 4, 2460, 480);
draw_sprite(sWaterSparkles, (_spk_f + 2) mod 4, 2410, 820);
draw_sprite(sWaterSparkles, (_spk_f + 3) mod 4, 2450, 1150);


// =========================================================================
// 11. GERBANG KOTA UTARA & SELATAN (City Gateways)
// =========================================================================
// --- Gerbang Utara ---
draw_set_color(make_color_rgb(52, 34, 18));
draw_roundrect_ext(_cx - 105, 20, _cx + 105, 38, 4, 4, false);
draw_set_color(make_color_rgb(215, 175, 80));
draw_line_width(_cx - 95, 34, _cx + 95, 34, 2);

draw_set_color(make_color_rgb(22, 32, 48));
draw_roundrect_ext(_cx - 120, 5, _cx + 120, 24, 4, 4, false);
draw_set_color(make_color_rgb(110, 185, 245));
draw_roundrect_ext(_cx - 120, 5, _cx + 120, 24, 4, 4, true);
draw_set_color(make_color_rgb(255, 235, 170));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_cx, 14, "▲ Menuju Rumah Sestrina (Hutan)");

// --- Gerbang Selatan ---
draw_set_color(make_color_rgb(50, 54, 64));
draw_roundrect_ext(_cx - 110, 1340, _cx - 50, 1440, 8, 8, false);
draw_roundrect_ext(_cx + 50, 1340, _cx + 110, 1440, 8, 8, false);
draw_set_color(make_color_rgb(180, 140, 70));
draw_line_width(_cx - 100, 1370, _cx - 60, 1370, 3);
draw_line_width(_cx + 60, 1370, _cx + 100, 1370, 3);

draw_set_color(make_color_rgb(22, 32, 48));
draw_roundrect_ext(_cx - 135, 1320, _cx + 135, 1338, 4, 4, false);
draw_set_color(make_color_rgb(245, 110, 110));
draw_roundrect_ext(_cx - 135, 1320, _cx + 135, 1338, 4, 4, true);
draw_set_color(make_color_rgb(255, 235, 170));
draw_text(_cx, 1329, "▼ Gerbang Selatan (Kuil Purba)");


// =========================================================================
// 12. LENTERA JALAN UTAMA PERSIMPANGAN KOTA (Streetlamps)
// =========================================================================
scr_draw_street_lamp(_cx - 58, 120);
scr_draw_street_lamp(_cx + 58, 120);
scr_draw_street_lamp(_cx - 58, 410);
scr_draw_street_lamp(_cx + 58, 410);
scr_draw_street_lamp(_cx - 58, 1040);
scr_draw_street_lamp(_cx + 58, 1040);
scr_draw_street_lamp(_cx - 58, 1345);
scr_draw_street_lamp(_cx + 58, 1345);

scr_draw_street_lamp(430, 445);
scr_draw_street_lamp(570, 445);
scr_draw_street_lamp(1430, 445);
scr_draw_street_lamp(2115, 445);

// Tiang Penunjuk Arah & Lampu Jalan Vintage
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 68, 660, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 56, 660, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 545, 680, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 2025, 680, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 13. PEPOHONAN LEBAT & HIASAN ALAMI
// =========================================================================
scr_draw_tree_with_shadow(2260, 260);
scr_draw_tree_with_shadow(2270, 520);
scr_draw_tree_with_shadow(2260, 780);
scr_draw_tree_with_shadow(2270, 1180);

draw_set_alpha(1.0);
draw_set_color(c_white);
