/// @description Draw Event oDecorTown (Kota Altdorf - Masterpiece Medieval Fantasy Layout)

var _cx = 1280;
var _cy = 720;
var _w = room_width;
var _h = room_height;

// =========================================================================
// 1. HAMPARAN RUMPUT KOTA & FLORA ALAMI (Velvety Natural Grass & Flora)
// =========================================================================
// Dasar Rumput Hijau Alami Subur Altdorf (RGB 112, 168, 62 - Bersih, Mulus & Nyaman Dipandang)
draw_set_color(make_color_rgb(112, 168, 62));
draw_rectangle(0, 0, _w, _h, false);

// Aksen Rumput Alami di Area Terbuka Terpilih
var _lawn_patches = [
    [120, 220], [240, 480], [380, 160], [580, 210], [920, 220], [1120, 210],
    [2180, 210], [2240, 420], [2230, 680], [2220, 890],
    [150, 720], [220, 840], [280, 1120], [420, 1180], [680, 1180], [920, 1190],
    [1420, 1180], [1680, 1190], [1920, 1180], [2140, 1190]
];

for (var _lp = 0; _lp < array_length(_lawn_patches); _lp++) {
    var _lx = _lawn_patches[_lp][0];
    var _ly = _lawn_patches[_lp][1];
    if (_lp mod 2 == 0) {
        draw_sprite_ext(sTown_GrassTuftPatch, 0, _lx, _ly, 0.9, 0.9, 0, c_white, 0.85);
    } else {
        draw_sprite_ext(sTown_GrassFlowerPatch, 0, _lx, _ly, 0.88, 0.88, 0, c_white, 0.85);
    }
}

// Bunga Liar & Rerumputan di Pinggir Halaman & Batas Lingkungan
var _flora_spots = [
    [220, 360, sTown_FloraGrass1], [270, 260, sTown_FloraGrass2], [315, 365, sTown_FloraClover],
    [410, 260, sTown_FloraFlowers], [160, 480, sTown_FloraGrass1], [80, 560, sTown_FloraGrass2],
    [_cx - 165, _cy - 145, sTown_FloraFlowers], [_cx + 155, _cy - 145, sTown_FloraGrass1],
    [_cx - 165, _cy + 145, sTown_FloraClover], [_cx + 155, _cy + 145, sTown_FloraFlowers],
    [_cx - 75, 360, sTown_FloraGrass1], [_cx + 60, 360, sTown_FloraGrass2],
    [_cx - 75, 860, sTown_FloraGrass2], [_cx + 60, 860, sTown_FloraClover],
    [1450, 750, sTown_FloraClover], [1820, 750, sTown_FloraLavender],
    [1620, 850, sTown_FloraGrass2], [2220, 850, sTown_FloraFlowers],
    [1420, 960, sTown_FloraGrass1], [1460, 960, sTown_FloraLavender],
    [2270, 960, sTown_FloraClover], [2260, 1080, sTown_FloraGrass2]
];

for (var _fs = 0; _fs < array_length(_flora_spots); _fs++) {
    var _fx = _flora_spots[_fs][0];
    var _fy = _flora_spots[_fs][1];
    var _fspr = _flora_spots[_fs][2];
    draw_sprite_ext(_fspr, 0, _fx, _fy, 0.85, 0.85, 0, c_white, 0.95);
}


// =========================================================================
// 2. SUNGAI TIMUR (Canal River & Stone Embankment)
// =========================================================================
var _river_x = 2360;
draw_set_color(make_color_rgb(26, 75, 105));
draw_rectangle(_river_x, 0, _w, _h, false);

// Tanggul Batu Alami
draw_set_color(make_color_rgb(75, 70, 62));
draw_rectangle(_river_x - 18, 0, _river_x, _h, false);
draw_set_color(make_color_rgb(145, 138, 126));
for (var _ty = 0; _ty < _h; _ty += 24) {
    draw_rectangle(_river_x - 16, _ty, _river_x - 2, _ty + 20, false);
}

// Sparkle Air Kanal Mengalir
var _spk_f = floor(water_anim) mod 4;
draw_sprite(sWaterSparkles, _spk_f, 2400, 240);
draw_sprite(sWaterSparkles, (_spk_f + 1) mod 4, 2460, 480);
draw_sprite(sWaterSparkles, (_spk_f + 2) mod 4, 2410, 820);
draw_sprite(sWaterSparkles, (_spk_f + 3) mod 4, 2450, 1150);


// =========================================================================
// 3. 5 OFFICIAL ATLAS TERRAIN: TANAH HUMUS (095) & LANTAI KAYU (097)
// =========================================================================

// --- A. Area Tanah Humus (095 DIRT / EARTH) ---
// 1. Bengkel Tempa Goran
scr_draw_tiled_terrain(sTown_TerrainDirt, 380, 260, 560, 375, 0.85, 0.95);
// 2. Kebun Botani & Bunga
scr_draw_tiled_terrain(sTown_TerrainDirt, 1700, 480, 1950, 610, 0.85, 0.95);
// 3. Pekarangan Bangsal Pertanian Tenggara
scr_draw_tiled_terrain(sTown_TerrainDirt, 1760, 800, 1960, 916, 0.85, 0.95);

// --- B. Area Lantai Kayu (097 WOODEN PLANKS / TIMBER DECK) ---
// 1. Dermaga Nelayan Sungai Timur
scr_draw_tiled_terrain(sTown_TerrainWood, 2270, 970, 2440, 1060, 0.85, 1.0);
// 2. Teras Terbuka Kafe Tavern Barat Daya
scr_draw_tiled_terrain(sTown_TerrainWood, 440, 920, 630, 1022, 0.85, 1.0);


// =========================================================================
// 4. SISTEM JARINGAN JALAN UTAMA (093 Clean Cobble & 094 Mossy Stone)
// =========================================================================

// Radius dan Titik Temu Geometris Plaza
var _r_plaza = 155;
var _y_int = 145; // sqrt(155^2 - 55^2)
var _x_int = 148; // sqrt(155^2 - 45^2)

// --- A. Boulevard Vertikal Utama (The Royal Way: x: CX-55..CX+55) ---
// Bagian Utara (Gerbang Istana -> Alun-Alun)
scr_draw_cobblestone_road(_cx - 55, 60, _cx + 55, _cy - _y_int, true, false, true, true);
// Bagian Selatan (Alun-Alun -> Gerbang Selatan)
scr_draw_cobblestone_road(_cx - 55, _cy + _y_int, _cx + 55, 1400, false, true, true, true);

// Overlay Tekstur Paving Atlas di Boulevard Vertikal
for (var _pvy = 100; _pvy < _cy - _y_int - 40; _pvy += 90) {
    draw_sprite_ext(sTown_PathCobble, 0, _cx - 45, _pvy, 0.9, 0.85, 0, c_white, 0.35);
}
for (var _pvy2 = _cy + _y_int + 20; _pvy2 < 1360; _pvy2 += 90) {
    draw_sprite_ext(sTown_PathCobble, 0, _cx - 45, _pvy2, 0.9, 0.85, 0, c_white, 0.35);
}

// --- B. Boulevard Horizontal Utama (The Grand Market Way: y: CY-45..CY+45) ---
// Bagian Barat (Distrik Barat -> Alun-Alun)
scr_draw_cobblestone_road(200, _cy - 45, _cx - _x_int, _cy + 45, true, true, true, false);
// Bagian Timur (Alun-Alun -> Kanal Sungai)
scr_draw_cobblestone_road(_cx + _x_int, _cy - 45, 2260, _cy + 45, true, true, false, true);

// Overlay Tekstur Paving Atlas di Boulevard Horizontal
for (var _pvx = 380; _pvx < _cx - _x_int - 40; _pvx += 95) {
    draw_sprite_ext(sTown_PathFlagstone, 0, _pvx, _cy - 38, 0.92, 0.72, 0, c_white, 0.35);
}
for (var _pvx2 = _cx + _x_int + 20; _pvx2 < 2220; _pvx2 += 95) {
    draw_sprite_ext(sTown_PathFlagstone, 0, _pvx2, _cy - 38, 0.92, 0.72, 0, c_white, 0.35);
}

// --- C. Jalan Pertokoan Utara (Artisan & Shop Street di y: 375..455) ---
// Jalur Katedral Kuno (094 MOSSY STONE)
scr_draw_cobblestone_road(160, 375, 420, 455, true, true, true, false);
scr_draw_tiled_terrain(sTown_TerrainMossy, 160, 375, 420, 455, 0.85, 0.65);

// Jalan Pertokoan Utama (093 CLEAN STONE)
scr_draw_cobblestone_road(420, 375, 2260, 455, true, true, false, true);

// --- D. Jalan Vertikal Distrik Barat (x: 460..540, y: 455..1025) ---
scr_draw_cobblestone_road(460, 455, 540, _cy - 45, false, false, true, true);
scr_draw_cobblestone_road(460, _cy + 45, 540, 1025, false, false, true, true);

// --- E. Jalan Akses Pemukiman Tenggara & Tavern ---
// Jalan Pemukiman Tengah (y: 916..980)
scr_draw_cobblestone_road(1400, 916, 2260, 980, true, true, true, true);
// Jalan Pemukiman Bawah (y: 1240..1305)
scr_draw_cobblestone_road(1400, 1240, 2260, 1305, true, true, true, true);
// Jalan Tavern Barat Daya (y: 1022..1090)
scr_draw_cobblestone_road(130, 1022, 650, 1090, true, true, true, false);


// =========================================================================
// 5. ALUN-ALUN PUSAT & AIR MANCUR (Masterpiece Circular Plaza & Props)
// =========================================================================
// Gambar Alun-Alun Melingkar Sempurna dengan 4 Busur Curb Halus (Bebas Gerigi!)
scr_draw_circular_plaza(_cx, _cy, _r_plaza, 55, 45);

// Air Mancur di Pusat Alun-Alun (Berdiri Bebas, Terbuka & TANPA PAGAR!)
draw_sprite(sProp_Fountain, 0, _cx - 64, _cy - 64);

// 2 Bangku Batu Taman di Sisi Luar Plaza (Menghadap Air Mancur)
draw_sprite_ext(sTown_PropStoneBench, 0, _cx - 115, _cy - 35, 0.55, 0.55, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStoneBench, 0, _cx + 65,  _cy - 35, 0.55, 0.55, 0, c_white, 1.0);

// Papan Pengumuman Kerajaan (Notice Board Atlas) di Sudut Kiri Atas Plaza
draw_sprite_ext(sTown_PropNoticeBoard, 0, _cx - 120, _cy - 125, 0.85, 0.85, 0, c_white, 1.0);

// 4 Lentera Tiang Klasik Membingkai 4 Sudut Plaza
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 130, _cy - 100, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 110, _cy - 100, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 130, _cy + 60,  0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 110, _cy + 60,  0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 6. DISTRIK UTARA: ARSITEKTUR KOTA VARIATIF (Baseline Sejajar Rapi Y = 372)
// =========================================================================
var _yn = 372;

// 1. Katedral Suci Altdorf (Ancient Cathedral)
draw_sprite_ext(sBuilding_Cathedral, 0, 160, _yn - 215, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 135, 340, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 335, 340, 0.82, 0.82, 0, c_white, 1.0);

// 2. Bengkel Tempa Goran (Blacksmith Shop - Pintu pas di x: 520)
draw_sprite_ext(sBuilding_Blacksmith, 0, 420, _yn - 202, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 360, 340, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCrateStack, 0, 385, 330, 0.8, 0.8, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 560, 335, 0.75, 0.75, 0, c_white, 1.0);

// 3. Menara Lonceng Belfry (Asset Unik Baru - Jarak Lapang 80px)
draw_sprite_ext(sBuilding_Belfry, 0, 700, _yn - 157, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSignSquare, 0, 740, 345, 0.68, 0.68, 0, c_white, 1.0);

// 4. Rumah Pengrajin Kayu Merah
draw_sprite_ext(sBuilding_House_Red, 0, 940, _yn - 204, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 895, 340, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 1085, 340, 0.82, 0.82, 0, c_white, 1.0);

// 5. Rumah Warga Biru Timur
draw_sprite_ext(sBuilding_House_Blue, 0, 1380, _yn - 220, 0.82, 0.82, 0, c_white, 1.0);

// 6. Toko Roti Harum (Bakery)
draw_sprite_ext(sBuilding_Bakery, 0, 1580, _yn - 184, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBreadBasket, 0, 1675, 345, 0.85, 0.85, 0, c_white, 1.0);

// 7. Bangsal Kayu Pertanian (Farm Shed - Asset Unik Baru)
draw_sprite_ext(sBuilding_FarmShed, 0, 1770, _yn - 119, 0.85, 0.85, 0, c_white, 1.0);

// 8. Apotek Ramuan Elysia (Apothecary - Pintu pas di x: 2040)
draw_sprite_ext(sBuilding_Apothecary, 0, 1970, _yn - 196, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropPottery, 0, 1995, 345, 0.85, 0.85, 0, c_white, 1.0);

// 9. Kincir Angin Gandum (Windmill)
draw_sprite_ext(sBuilding_Windmill, 0, 2180, _yn - 197, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSacks, 0, 2210, 345, 0.78, 0.78, 0, c_white, 1.0);

// 10. Mercusuar Tepi Kanal (Lighthouse - Landmark Unik Tepi Air)
draw_sprite_ext(sBuilding_Lighthouse, 0, 2370, _yn - 194, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 7. PEMUKIMAN TENGGARA & SUMUR DESA (Spacious & Free Well)
// =========================================================================

// --- A. Baris Atas Rumah Tenggara (Baseline Y = 916) ---
draw_sprite_ext(sBuilding_House_Blue, 0, 1620, 916 - 214, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 1820, 916 - 204, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Red, 0, 2020, 916 - 199, 0.80, 0.80, 0, c_white, 1.0);

// Pagar Pembatas Pekarangan Pribadi Antar-Rumah (Tidak Menghalangi Fasilitas Publik)
draw_sprite_ext(sTown_FencePicket, 0, 1565, 885, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 1765, 885, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 1965, 885, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 2165, 885, 0.82, 0.82, 0, c_white, 1.0);

// --- B. Baris Bawah Rumah Tenggara (Baseline Y = 1240) ---
draw_sprite_ext(sBuilding_House_Red, 0, 1620, 1240 - 199, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 1820, 1240 - 204, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 2020, 1240 - 214, 0.80, 0.80, 0, c_white, 1.0);

draw_sprite_ext(sTown_FencePicket, 0, 1565, 1205, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 1765, 1205, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 1965, 1205, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 2165, 1205, 0.82, 0.82, 0, c_white, 1.0);

// --- C. Sumur Batu Kuno Desa (Terbuka Bebas & TANPA PAGAR PENGHALANG!) ---
draw_sprite_ext(sBuilding_WaterWell, 0, 1430, 810, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 1495, 840, 0.8, 0.8, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 1520, 855, 0.7, 0.7, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraGrass1, 0, 1415, 865, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 8. DISTRIK BARAT DAYA: KEDAI TAVERN & TERAS KAFE (Baseline Y = 1018)
// =========================================================================
var _ytav = 1018;

// Gedung Tavern Penginapan
draw_sprite_ext(sBuilding_Tavern, 0, 130, _ytav - 235, 0.85, 0.85, 0, c_white, 1.0);

// Teras Santai Kafe di Atas Lantai Kayu 097
draw_sprite_ext(sTown_PropCafeParasol, 0, 465, 930, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCafeParasol, 0, 565, 930, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStoneBench, 0, 470, 985, 0.55, 0.55, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 440, 955, 0.75, 0.75, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 600, 955, 0.75, 0.75, 0, c_white, 1.0);
// Pagar Kayu Picket 115 Membingkai Sisi Teras Kafe
draw_sprite_ext(sTown_FencePicket, 0, 450, 895, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_FencePicket, 0, 520, 895, 0.82, 0.82, 0, c_white, 1.0);


// =========================================================================
// 9. PASAR RAKYAT GRAND MARKET WAY (Market Stalls, Produce & Props)
// =========================================================================
// Toko Kelontong Pasar (Stalls)
draw_sprite_ext(sBuilding_MarketStall, 0, 620, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 730, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 840, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 950, 545, 0.85, 0.85, 0, c_white, 1.0);

// Gerobak Dagang & Komoditas Pasar
draw_sprite_ext(sTown_PropCart, 0, 525, 575, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropMarketProduce, 0, 640, 595, 0.8, 0.8, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropFruitBasket, 0, 750, 600, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBreadBasket, 0, 860, 600, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropPottery, 0, 965, 600, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCrateStack, 0, 595, 620, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSacks, 0, 985, 620, 0.78, 0.78, 0, c_white, 1.0);


// =========================================================================
// 10. GERBANG BENTENG UTARA & SELATAN (City Gateways)
// =========================================================================
// Gerbang Benteng Kerajaan Utara
draw_sprite_ext(sBuilding_Watchtower, 0, _cx - 185, 20, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_CastleGate, 0, _cx - 96, 20, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_Watchtower, 0, _cx + 95, 20, 0.85, 0.85, 0, c_white, 1.0);

// Gerbang Selatan
draw_set_color(make_color_rgb(50, 54, 64));
draw_roundrect_ext(_cx - 110, 1370, _cx - 50, 1438, 8, 8, false);
draw_roundrect_ext(_cx + 50, 1370, _cx + 110, 1438, 8, 8, false);
draw_sprite_ext(sBuilding_Watchtower, 0, _cx - 190, 1260, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_Watchtower, 0, _cx + 110, 1260, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStoneBench, 0, _cx - 110, 1320, 0.55, 0.55, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStoneBench, 0, _cx + 25,  1320, 0.55, 0.55, 0, c_white, 1.0);


// =========================================================================
// 11. DERMAGA KANAL & BARANG-BARANG TEPI AIR
// =========================================================================
draw_sprite_ext(sTown_PropBarrelSingle, 0, 2295, 985, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCrateStack, 0, 2340, 995, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSacks, 0, 2390, 1000, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStoneBench, 0, _river_x - 65, 1095, 0.55, 0.55, 0, c_white, 1.0);


// =========================================================================
// 12. LENTERA JALAN KLASIK & PEPOHONAN PERIMETER KOTA
// =========================================================================
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 68, 380, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 52, 380, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 68, 860, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 52, 860, 0.85, 0.85, 0, c_white, 1.0);

draw_sprite_ext(sBuilding_LampSignpost, 0, 460, 440, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 1380, 440, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 2110, 440, 0.85, 0.85, 0, c_white, 1.0);

// Pohon-Pohon Besar di Tepi Luar Kota
draw_sprite_ext(sTown_TreeOak, 0, 80, 360, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreePine, 0, 80, 680, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreeOak, 0, 80, 1020, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreeOak, 0, 2260, 380, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreePine, 0, 2260, 560, 0.85, 0.85, 0, c_white, 1.0);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
