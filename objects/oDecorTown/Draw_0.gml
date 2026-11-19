/// @description Draw Event oDecorTown (Kota Altdorf - Tata Letak Artistik & Alami Medieval Fantasy)

var _cx = 1280;
var _cy = 720;
var _w = room_width;
var _h = room_height;

// =========================================================================
// 1. HAMPARAN RUMPUT KOTA & FLORA ALAMI (Pixel Art Atlas Terrain & Flora)
// =========================================================================
// Dasar Rumput Hijau Subur Altdorf
draw_set_color(make_color_rgb(112, 168, 62));
draw_rectangle(0, 0, _w, _h, false);

// Aksen Hamparan Rumput Alami dari Asset Atlas di Area Terbuka
var _lawn_patches = [
    [120, 220], [240, 480], [380, 160], [580, 210], [920, 220], [1120, 210],
    [1420, 220], [1780, 220], [2180, 210], [2240, 420], [2230, 680], [2220, 890],
    [150, 720], [220, 840], [280, 1120], [420, 1180], [680, 1180], [920, 1190],
    [1420, 1180], [1680, 1190], [1920, 1180], [2140, 1190], [1520, 680], [1760, 680]
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
    // Distrik Pengrajin & Barat
    [220, 360, sTown_FloraGrass1], [270, 260, sTown_FloraGrass2], [315, 365, sTown_FloraClover],
    [410, 260, sTown_FloraFlowers], [160, 480, sTown_FloraGrass1], [80, 560, sTown_FloraGrass2],
    // Sekitar Alun-Alun Plaza & Boulevard
    [_cx - 150, _cy - 130, sTown_FloraFlowers], [_cx + 135, _cy - 130, sTown_FloraGrass1],
    [_cx - 150, _cy + 130, sTown_FloraClover], [_cx + 135, _cy + 130, sTown_FloraFlowers],
    [_cx - 75, 360, sTown_FloraGrass1], [_cx + 60, 360, sTown_FloraGrass2],
    [_cx - 75, 860, sTown_FloraGrass2], [_cx + 60, 860, sTown_FloraClover],
    // Pemukiman & Taman
    [1360, 440, sTown_FloraGrass1], [1930, 440, sTown_FloraFlowers],
    [1450, 660, sTown_FloraClover], [1820, 660, sTown_FloraLavender],
    [1620, 740, sTown_FloraGrass2], [2220, 740, sTown_FloraFlowers],
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
// 2. SISTEM JARINGAN JALAN UTAMA & PATHWAY (Cobblestone & Flagstone Atlas)
// =========================================================================

// --- A. Boulevard Utama Vertikal (Utara <-> Alun-Alun <-> Gerbang Selatan) ---
scr_draw_cobblestone_road(_cx - 48, 60, _cx + 48, 380, true, false, true, true);
scr_draw_cobblestone_road(_cx - 48, 380, _cx + 48, 440, false, false, false, false);
scr_draw_cobblestone_road(_cx - 48, 440, _cx + 48, 600, false, false, true, true);
scr_draw_cobblestone_road(_cx - 48, 840, _cx + 48, 1400, false, true, true, true);

// Overlay Tekstur Paving Atlas di Boulevard Vertikal (Lembut & Menyatu)
for (var _pvy = 100; _pvy < 360; _pvy += 90) {
    draw_sprite_ext(sTown_PathCobble, 0, _cx - 45, _pvy, 0.9, 0.85, 0, c_white, 0.35);
}
for (var _pvy2 = 860; _pvy2 < 1360; _pvy2 += 90) {
    draw_sprite_ext(sTown_PathCobble, 0, _cx - 45, _pvy2, 0.9, 0.85, 0, c_white, 0.35);
}

// --- B. Boulevard Utama Horizontal (Barat <-> Alun-Alun <-> Timur) ---
scr_draw_cobblestone_road(380, _cy - 40, _cx - 120, _cy + 40, true, true, true, false);
scr_draw_cobblestone_road(_cx + 120, _cy - 40, 2260, _cy + 40, true, true, false, true);

// Overlay Tekstur Paving Atlas di Boulevard Horizontal
for (var _pvx = 420; _pvx < _cx - 140; _pvx += 95) {
    draw_sprite_ext(sTown_PathFlagstone, 0, _pvx, _cy - 38, 0.92, 0.72, 0, c_white, 0.35);
}
for (var _pvx2 = _cx + 130; _pvx2 < 2220; _pvx2 += 95) {
    draw_sprite_ext(sTown_PathFlagstone, 0, _pvx2, _cy - 38, 0.92, 0.72, 0, c_white, 0.35);
}

// --- C. Jalan Horizontal Utara (Artisan & Scholar Avenue di y: 380..440) ---
scr_draw_cobblestone_road(440, 380, _cx - 48, 440, true, true, false, false);
scr_draw_cobblestone_road(_cx + 48, 380, 2120, 440, true, true, false, false);

// --- D. Jalan Vertikal Distrik Barat (x: 480..560) ---
scr_draw_cobblestone_road(480, 440, 560, 560, false, false, true, true);
scr_draw_cobblestone_road(480, 560, 560, 640, false, false, true, false);
scr_draw_cobblestone_road(480, 640, 560, _cy - 40, false, false, true, true);
scr_draw_cobblestone_road(560, 560, 580, 640, true, true, false, false);

// --- E. Jalan Akses Pemukiman Tenggara & Tavern ---
scr_draw_cobblestone_road(1540, 760, 1600, 920, false, false, true, true);
scr_draw_cobblestone_road(1540, 920, 2280, 980, true, true, true, false);
scr_draw_cobblestone_road(480, 760, 560, 1060, false, true, true, true);
scr_draw_cobblestone_road(340, 980, 480, 1040, true, true, false, false);


// =========================================================================
// 3. ALUN-ALUN PUSAT & AIR MANCUR (Central Cobblestone Plaza & Props)
// =========================================================================
// Dasar Paving Plaza Batu Hangat
draw_set_color(make_color_rgb(155, 146, 132));
draw_circle(_cx, _cy, 120, false);

// Paving radial Alun-Alun
var _step = 16;
for (var _py = _cy - 120; _py < _cy + 120; _py += _step) {
    var _row = (_py - (_cy - 120)) div _step;
    var _xoff = (_row mod 2 == 1) ? 8 : 0;
    for (var _px = _cx - 120 + _xoff; _px < _cx + 120; _px += _step) {
        if (point_distance(_px + 8, _py + 8, _cx, _cy) < 116) {
            var _c_val = 148 + (((_px * 37) ^ (_py * 67)) mod 14);
            draw_set_color(make_color_rgb(_c_val, _c_val - 4, _c_val - 12));
            draw_rectangle(_px, _py, _px + _step - 2, _py + _step - 2, false);
            draw_set_color(make_color_rgb(_c_val + 12, _c_val + 8, _c_val));
            draw_point(_px + 1, _py + 1);
        }
    }
}

// Cincin batas plaza batu hangat
draw_set_color(make_color_rgb(85, 78, 68));
draw_circle(_cx, _cy, 122, true);
draw_set_color(make_color_rgb(168, 160, 148));
draw_circle(_cx, _cy, 120, true);
draw_set_color(make_color_rgb(122, 114, 102));
draw_circle(_cx, _cy, 118, true);

// Air Mancur di Tengah-Tengah Alun-Alun
draw_sprite(sProp_Fountain, 0, _cx - 64, _cy - 64);

// 4 Bangku Kayu Taman Elegan Mengelilingi Alun-Alun (Rapi & Seimbang)
scr_draw_park_bench(_cx - 75, _cy - 50, 44);
scr_draw_park_bench(_cx + 75, _cy - 50, 44);
scr_draw_park_bench(_cx - 75, _cy + 50, 44);
scr_draw_park_bench(_cx + 75, _cy + 50, 44);

// Papan Pengumuman Kerajaan (Notice Board Atlas) di Sudut Alun-Alun
draw_sprite_ext(sTown_PropNoticeBoard, 0, _cx - 110, _cy - 115, 0.85, 0.85, 0, c_white, 1.0);

// 4 Lentera Tiang Klasik di Tepi Luar 4 Sudut Plaza
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 115, _cy - 90, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 95,  _cy - 90, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 115, _cy + 70, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 95,  _cy + 70, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 4. TAMAN KOTA & KEBUN BOTANI (Lush Organic Gardens & Serene Ponds)
// =========================================================================
// Pagar Semak Rapi di Tepi Atas Kebun
draw_sprite_ext(sTown_ShrubHedge, 0, 1405, 435, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_ShrubHedge, 0, 1500, 435, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_ShrubHedge, 0, 1730, 435, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_ShrubHedge, 0, 1825, 435, 0.85, 0.85, 0, c_white, 1.0);

// Barisan Pohon Oak Rindang Megah di Atas Taman
var _tree_x = [1420, 1515, 1610, 1705, 1800, 1865];
for (var _t = 0; _t < array_length(_tree_x); _t++) {
    draw_sprite_ext(sTown_TreeOak, 0, _tree_x[_t] - 30, 320, 0.82, 0.82, 0, c_white, 1.0);
}

// Kolam Teratai Atas & Kolam Panjang Bawah dengan Jembatan Kayu
scr_draw_park_pond(1415, 480, 1495, 560);
scr_draw_park_pond(1510, 610, 1810, 660);
scr_draw_wooden_bridge(1640, 604, 1680, 666);

// Petak Bunga Bergaya Kebun Raya Tertata Bersih
scr_draw_flowerbed(1510, 485, 1630, 535, 1); // Lili putih
scr_draw_flowerbed(1690, 485, 1810, 535, 0); // Marigold emas
scr_draw_flowerbed(1840, 480, 1910, 580, 2); // Lavender ungu

// Jalan Setapak Batu Pijakan Alami (Stepping Stones) di Selasar Taman
var _park_stepping = [
    [1510, 565], [1570, 565], [1630, 565], [1690, 565], [1750, 565], [1810, 565],
    [1650, 585], [1650, 550]
];
for (var _st = 0; _st < array_length(_park_stepping); _st++) {
    draw_sprite_ext(sTown_SteppingStones, 0, _park_stepping[_st][0], _park_stepping[_st][1], 0.85, 0.85, 0, c_white, 0.88);
}

// Bangku Santai Pengunjung Taman di Tepi Jalan Setapak (Bukan di Dalam Kolam!)
scr_draw_park_bench(1570, 575, 44);
scr_draw_park_bench(1750, 575, 44);

// Semak Bunga Mekar & Herbal di Sudut-Sudut Taman
draw_sprite_ext(sTown_ShrubFlowering, 0, 1420, 585, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_ShrubFlowering, 0, 1845, 595, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraLavender, 0, 1850, 450, 0.9, 0.9, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraFlowers, 0, 1715, 450, 0.9, 0.9, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraClover, 0, 1530, 450, 0.9, 0.9, 0, c_white, 1.0);


// =========================================================================
// 5. DISTRIK PENGRAJIN & BENGKEL TEMPA GORAN (Artisan Props & Wood Fence)
// =========================================================================
draw_sprite_ext(sBuilding_Blacksmith, 0, 440, 200, 0.85, 0.85, 0, c_white, 1.0);
scr_draw_cobblestone_road(310, 270, 456, 380, true, false, true, false);

// Peralatan Bengkel Tempa Goran
draw_sprite_part_ext(sStation_Furnace, 0, 0, 0, 64, 80, 320, 275, 1.0, 1.0, c_white, 1.0);
draw_sprite_part_ext(sStation_Anvil, 0, 0, 0, 64, 48, 395, 320, 0.95, 0.95, c_white, 1.0);

// Barang-Barang Atlas: Tumpukan Peti Besi, Tong Minyak & Pagar Kayu
draw_sprite_ext(sTown_PropCrateStack, 0, 325, 335, 0.8, 0.8, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 420, 335, 0.75, 0.75, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropFenceWood, 0, 305, 270, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropFenceWood, 0, 305, 315, 0.82, 0.82, 0, c_white, 1.0);

// Rumah Pengrajin Barat (Carpenter)
draw_sprite_ext(sBuilding_House_Amber, 0, 70, 140, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 70, 400, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreeOak, 0, 80, 280, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 6. DISTRIK ALKEMIS & APOTEK ELYSIA (Apothecary Herbs, Pottery & Bakery)
// =========================================================================
draw_sprite_ext(sBuilding_Bakery, 0, 1740, 195, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_Apothecary, 0, 1960, 200, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_Windmill, 0, 2220, 110, 0.85, 0.85, 0, c_white, 1.0);

// Teras Lab Alkimia Elysia
scr_draw_cobblestone_road(2104, 280, 2220, 380, true, false, false, true);
draw_sprite_part_ext(sStation_Alchemy, 0, 0, 0, 64, 64, 2125, 290, 1.0, 1.0, c_white, 1.0);

// Barang-Barang Atlas: Guci Tembikar Herbal, Keranjang Roti & Tanaman Lavender
draw_sprite_ext(sTown_PropPottery, 0, 2125, 345, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraLavender, 0, 2170, 345, 0.9, 0.9, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBreadBasket, 0, 1850, 335, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 7. PEMUKIMAN WARGA UTARA & TENGGARA (Bersih, Rapi, Alami Tanpa Paving Kaku)
// =========================================================================

// --- A. Rumah Deret Utara-Barat (x: 690..1180, y: 130) ---
draw_sprite_ext(sBuilding_House_Red, 0, 690, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 860, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1030, 130, 0.82, 0.82, 0, c_white, 1.0);

// Batu Pijakan Alami (Stepping Stones) Tepat di Depan Pintu
draw_sprite_ext(sTown_SteppingStones, 0, 750, 335, 0.85, 0.85, 0, c_white, 0.9);
draw_sprite_ext(sTown_SteppingStones, 0, 920, 335, 0.85, 0.85, 0, c_white, 0.9);
draw_sprite_ext(sTown_SteppingStones, 0, 1090, 335, 0.85, 0.85, 0, c_white, 0.9);

// Flora Cantik di Halaman Depan Rumah
draw_sprite_ext(sTown_FloraGrass1, 0, 715, 345, 0.8, 0.8, 0, c_white, 0.9);
draw_sprite_ext(sTown_FloraFlowers, 0, 885, 345, 0.8, 0.8, 0, c_white, 0.9);
draw_sprite_ext(sTown_FloraClover, 0, 1055, 345, 0.8, 0.8, 0, c_white, 0.9);

// --- B. Rumah Deret Utara-Timur (x: 1440..1760, y: 130) ---
draw_sprite_ext(sBuilding_House_Amber, 0, 1440, 130, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1610, 130, 0.82, 0.82, 0, c_white, 1.0);

draw_sprite_ext(sTown_SteppingStones, 0, 1500, 335, 0.85, 0.85, 0, c_white, 0.9);
draw_sprite_ext(sTown_SteppingStones, 0, 1670, 335, 0.85, 0.85, 0, c_white, 0.9);
draw_sprite_ext(sTown_FloraGrass2, 0, 1465, 345, 0.8, 0.8, 0, c_white, 0.9);
draw_sprite_ext(sTown_FloraFlowers, 0, 1635, 345, 0.8, 0.8, 0, c_white, 0.9);
draw_sprite_ext(sTown_TreeOak, 0, 1800, 140, 0.85, 0.85, 0, c_white, 1.0);

// --- C. Kompleks Perumahan Tenggara ---
// Baris Rumah Atas (y: 730)
draw_sprite_ext(sBuilding_House_Blue, 0, 1660, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 1820, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Red, 0, 1980, 730, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 2140, 730, 0.80, 0.80, 0, c_white, 1.0);

draw_sprite_ext(sTown_SteppingStones, 0, 1715, 890, 0.8, 0.8, 0, c_white, 0.85);
draw_sprite_ext(sTown_SteppingStones, 0, 1875, 890, 0.8, 0.8, 0, c_white, 0.85);
draw_sprite_ext(sTown_SteppingStones, 0, 2035, 890, 0.8, 0.8, 0, c_white, 0.85);
draw_sprite_ext(sTown_SteppingStones, 0, 2195, 890, 0.8, 0.8, 0, c_white, 0.85);

// Baris Rumah Bawah (y: 990)
draw_sprite_ext(sBuilding_House_Amber, 0, 1660, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Red, 0, 1820, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Blue, 0, 1980, 990, 0.80, 0.80, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_House_Amber, 0, 2140, 990, 0.80, 0.80, 0, c_white, 1.0);

// Sumur Batu Kuno Desa & Dekorasi Halaman
draw_sprite_ext(sBuilding_WaterWell, 0, 1445, 905, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 1415, 935, 0.75, 0.75, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCrateSingle, 0, 1500, 935, 0.75, 0.75, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraGrass1, 0, 1435, 950, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sTown_FloraClover, 0, 1475, 950, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 8. KEDAI TAVERN & TERAS KAFE LUAR RUANGAN (Parasol Umbrella & Kegs)
// =========================================================================
draw_sprite_ext(sBuilding_Tavern, 0, 130, 910, 0.85, 0.85, 0, c_white, 1.0);

// Teras Kafe Paving Batu Hangat yang Rapi
scr_draw_cobblestone_road(340, 960, 560, 1060, true, true, true, true);

// Meja Kafe Luar Ruangan dengan Payung Parasol Atlas
draw_sprite_ext(sTown_PropCafeParasol, 0, 360, 970, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCafeParasol, 0, 465, 970, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 345, 1025, 0.75, 0.75, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBarrelSingle, 0, 520, 1025, 0.75, 0.75, 0, c_white, 1.0);

// Pagar Pembatas Teras Tavern
for (var _tx = 340; _tx < 560; _tx += 32) {
    if (!(_tx >= 440 && _tx <= 480)) {
        draw_sprite_part(sProp_Fences, 0, 0, 0, 32, 32, _tx, 955);
    }
}


// =========================================================================
// 9. PASAR BAZAAR KOTA ALTDORF (Merchant Cart, Produce, Baskets & Cargo)
// =========================================================================
// Lantai Batu Hangat Pasar Bazaar
scr_draw_cobblestone_road(580, 550, 1060, 660, true, true, true, true);

// 4 Kios Pasar Bazaar Koleksi Pixel Art Fantasi
draw_sprite_ext(sBuilding_MarketStall, 0, 620, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 730, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 840, 545, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_MarketStall, 0, 950, 545, 0.85, 0.85, 0, c_white, 1.0);

// Gerobak Kayu Pedagang (Merchant Cart Atlas) Terparkir di Rumput Barat Pasar
draw_sprite_ext(sTown_PropCart, 0, 525, 575, 0.85, 0.85, 0, c_white, 1.0);

// Barang-Barang Pasar Atlas: Etalase Buah/Sayur, Peti, Karung Gandum, Keranjang
draw_sprite_ext(sTown_PropMarketProduce, 0, 640, 595, 0.8, 0.8, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropFruitBasket, 0, 750, 600, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropBreadBasket, 0, 860, 600, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropPottery, 0, 965, 600, 0.82, 0.82, 0, c_white, 1.0);

// Tumpukan Peti Kargo & Karung di Sudut Pasar
draw_sprite_ext(sTown_PropCrateStack, 0, 595, 620, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSacks, 0, 985, 620, 0.78, 0.78, 0, c_white, 1.0);


// =========================================================================
// 10. DERMAGA SUNGAI TIMUR (Canal & Fishing Cargo Atlas)
// =========================================================================
var _spk_f = (current_time div 180) mod 4;

// Aliran Sungai
draw_set_color(make_color_rgb(26, 75, 105));
draw_rectangle(2360, 0, _w, _h, false);

// Tanggul Batu Alami
draw_set_color(make_color_rgb(70, 65, 58));
draw_rectangle(2340, 0, 2360, _h, false);
draw_set_color(make_color_rgb(142, 134, 122));
for (var _ty = 0; _ty < _h; _ty += 24) {
    draw_rectangle(2342, _ty, 2358, _ty + 20, false);
}

// Dermaga Kayu Nelayan
draw_set_color(make_color_rgb(95, 62, 35));
draw_rectangle(2280, 970, 2440, 1050, false);
draw_set_color(make_color_rgb(145, 100, 60));
for (var _py = 974; _py < 1048; _py += 12) {
    draw_line_width(2282, _py, 2438, _py, 2);
}

// Barang-Barang Dermaga: Tong Ikan, Peti Kayu & Karung dari Atlas
draw_sprite_ext(sTown_PropBarrelSingle, 0, 2295, 985, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropCrateStack, 0, 2340, 995, 0.78, 0.78, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropSacks, 0, 2390, 1000, 0.78, 0.78, 0, c_white, 1.0);

draw_sprite(sWaterSparkles, _spk_f, 2400, 240);
draw_sprite(sWaterSparkles, (_spk_f + 1) mod 4, 2460, 480);
draw_sprite(sWaterSparkles, (_spk_f + 2) mod 4, 2410, 820);
draw_sprite(sWaterSparkles, (_spk_f + 3) mod 4, 2450, 1150);


// =========================================================================
// 11. GERBANG KOTA UTARA & SELATAN (City Gateways)
// =========================================================================
// Gerbang Utara
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

// 2 Banner Panji Kerajaan Megah Menghiasi Kiri & Kanan Gerbang Utara
draw_sprite_ext(sTown_PropStreetLamp, 0, _cx - 105, 45, 0.82, 0.82, 0, c_white, 1.0);
draw_sprite_ext(sTown_PropStreetLamp, 0, _cx + 65, 45, 0.82, 0.82, 0, c_white, 1.0);

// Gerbang Selatan
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
// 12. LENTERA JALAN KLASIK PERSIMPANGAN KOTA (Streetlamps)
// =========================================================================
// Tiang Penunjuk Arah & Lampu Vintage di Persimpangan Jalan
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 68, 380, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 52, 380, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx - 68, 840, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, _cx + 52, 840, 0.85, 0.85, 0, c_white, 1.0);

draw_sprite_ext(sBuilding_LampSignpost, 0, 460, 440, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 1400, 440, 0.85, 0.85, 0, c_white, 1.0);
draw_sprite_ext(sBuilding_LampSignpost, 0, 2110, 440, 0.85, 0.85, 0, c_white, 1.0);


// =========================================================================
// 13. PEPOHONAN LEBAT & PERIMETER HIASAN ALAMI (Grand Oak & Pine Atlas)
// =========================================================================
draw_sprite_ext(sTown_TreeOak, 0, 2240, 240, 0.88, 0.88, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreePine, 0, 2250, 500, 0.88, 0.88, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreeOak, 0, 2240, 760, 0.88, 0.88, 0, c_white, 1.0);
draw_sprite_ext(sTown_TreePine, 0, 2250, 1160, 0.88, 0.88, 0, c_white, 1.0);

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
