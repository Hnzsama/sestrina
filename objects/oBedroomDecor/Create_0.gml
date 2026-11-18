/// @description Inisialisasi Bedroom Decor & Collisions (Medieval Fantasy Bedroom Asset Sheet - Refined)

depth = 50; // Behind player, above room background

// Bersihkan solid boundaries lama jika ada
if (instance_exists(oSolidParent)) {
    with (oSolidParent) instance_destroy();
}

// 1. Dinding Atas / Utara (y = 0..185)
var _s = instance_create_depth(200, 0, 0, oSolidParent);
_s.image_xscale = (1080 - 200) / 32; _s.image_yscale = 185 / 32;

// 2. Dinding Samping Kiri / Barat
_s = instance_create_depth(0, 0, 0, oSolidParent);
_s.image_xscale = 200 / 32; _s.image_yscale = 720 / 32;

// 3. Dinding Samping Kanan / Timur
_s = instance_create_depth(1080, 0, 0, oSolidParent);
_s.image_xscale = (1280 - 1080) / 32; _s.image_yscale = 720 / 32;

// 4. Dinding Bawah Kiri Pintu
_s = instance_create_depth(200, 645, 0, oSolidParent);
_s.image_xscale = (590 - 200) / 32; _s.image_yscale = (720 - 645) / 32;

// 5. Dinding Bawah Kanan Pintu
_s = instance_create_depth(690, 645, 0, oSolidParent);
_s.image_xscale = (1080 - 690) / 32; _s.image_yscale = (720 - 645) / 32;

// ==========================================
// Rintangan Perabotan (Furniture Collisions - Spacious Layout)
// ==========================================
// 1. Nakas Ramuan Sestrina (Sayap Barat, x: 260..298, y = 220..270)
_s = instance_create_depth(260, 220, 0, oSolidParent);
_s.image_xscale = (298 - 260) / 32; _s.image_yscale = (270 - 220) / 32;

// 2. Ranjang Sestrina & Peti Ujung Ranjang (x: 310..370, y = 220..370)
_s = instance_create_depth(310, 220, 0, oSolidParent);
_s.image_xscale = (370 - 310) / 32; _s.image_yscale = (370 - 220) / 32;

// 3. Kursi Beludru & Bunga Aster Kakak (x: 395..440, y = 280..370)
_s = instance_create_depth(395, 280, 0, oSolidParent);
_s.image_xscale = (440 - 395) / 32; _s.image_yscale = (370 - 280) / 32;

// 4. Gantungan Mantel & Pot Tanaman Barat (x: 250..295, y = 295..410)
_s = instance_create_depth(250, 295, 0, oSolidParent);
_s.image_xscale = (295 - 250) / 32; _s.image_yscale = (410 - 295) / 32;

// 5. Rak Buku & Dresser Lilin Barat (x: 250..305, y = 430..570)
_s = instance_create_depth(250, 430, 0, oSolidParent);
_s.image_xscale = (305 - 250) / 32; _s.image_yscale = (570 - 430) / 32;

// 6. Tanaman Ficus Sudut Barat Daya (x: 250..295, y = 590..645)
_s = instance_create_depth(250, 590, 0, oSolidParent);
_s.image_xscale = (295 - 250) / 32; _s.image_yscale = (645 - 590) / 32;

// 7. Meja Belajar Utama, Astrolabe & Kursi (Tengah, y = 195..265)
_s = instance_create_depth(570, 195, 0, oSolidParent);
_s.image_xscale = (710 - 570) / 32; _s.image_yscale = (265 - 195) / 32;

// 8. Wardrobe, Bookshelf, Curio Cabinet & Cermin (Dinding Timur, y = 140..245)
_s = instance_create_depth(745, 140, 0, oSolidParent);
_s.image_xscale = (1015 - 745) / 32; _s.image_yscale = (245 - 140) / 32;

// 9. Rak Buku Timur, Patung Zirah & Tongkat Sihir (x: 965..1030, y = 270..440)
_s = instance_create_depth(965, 270, 0, oSolidParent);
_s.image_xscale = (1030 - 965) / 32; _s.image_yscale = (440 - 270) / 32;

// 10. Peti Harta, Peti Kayu & Hydrangea (Tenggara, x: 800..960, y = 470..545)
_s = instance_create_depth(800, 470, 0, oSolidParent);
_s.image_xscale = (960 - 800) / 32; _s.image_yscale = (545 - 470) / 32;

// 11. Tanaman Ficus Tenggara (x: 970..1020, y = 580..645)
_s = instance_create_depth(970, 580, 0, oSolidParent);
_s.image_xscale = (1020 - 970) / 32; _s.image_yscale = (645 - 580) / 32;
