/// @description Inisialisasi Medieval RPG Bedroom Layout (Center Pillar 9:16)

depth = 10; // Pastikan berada di depan background layer

var _gx1 = 440;
var _gy1 = 40;
var _gx2 = 840;
var _gy2 = 680;

// Bersihkan solid boundaries lama jika ada
if (instance_exists(oSolidParent)) {
    with (oSolidParent) instance_destroy();
}

// ==========================================
// 1. Dinding Luar Keliling Kamar
// ==========================================
// Dinding Luar Atas
var _s = instance_create_depth(_gx1, _gy1, 0, oSolidParent);
_s.image_xscale = (_gx2 - _gx1) / 32; _s.image_yscale = 2.0;

// Dinding Luar Kiri
_s = instance_create_depth(_gx1 - 32, _gy1, 0, oSolidParent);
_s.image_xscale = 1; _s.image_yscale = (_gy2 - _gy1) / 32;

// Dinding Luar Kanan
_s = instance_create_depth(_gx2, _gy1, 0, oSolidParent);
_s.image_xscale = 1; _s.image_yscale = (_gy2 - _gy1) / 32;

// Dinding Luar Bawah (Menyisakan pintu keluar di tengah)
_s = instance_create_depth(_gx1, _gy2, 0, oSolidParent);
_s.image_xscale = 4.0; _s.image_yscale = 1;

_s = instance_create_depth(_gx2 - 130, _gy2, 0, oSolidParent);
_s.image_xscale = 4.1; _s.image_yscale = 1;

// ==========================================
// 2. Rintangan Perabotan Medieval RPG (Furniture Collisions)
// ==========================================
// Perapian Batu Purba Kiri Atas
_s = instance_create_depth(_gx1 + 18, _gy1 + 12, 0, oSolidParent);
_s.image_xscale = 2.4; _s.image_yscale = 2.2;

// Meja Peta Taktik & Alkemis Kiri
_s = instance_create_depth(_gx1 + 20, 125, 0, oSolidParent);
_s.image_xscale = 3.3; _s.image_yscale = 2.0;

// Kasur Ksatria Kakak (Kanan Atas)
_s = instance_create_depth(_gx2 - 100, 100, 0, oSolidParent);
_s.image_xscale = 2.5; _s.image_yscale = 2.5;

// Kasur Adik Sestrina (Kanan Tengah)
_s = instance_create_depth(_gx2 - 100, 220, 0, oSolidParent);
_s.image_xscale = 2.5; _s.image_yscale = 2.5;

// Meja Lentera & Obat Adik
_s = instance_create_depth(_gx2 - 165, 220, 0, oSolidParent);
_s.image_xscale = 1.5; _s.image_yscale = 1.5;

// Rak Senjata Kiri Bawah
_s = instance_create_depth(_gx1 + 20, 520, 0, oSolidParent);
_s.image_xscale = 2.0; _s.image_yscale = 2.2;

// Peti Besi Kiri Bawah
_s = instance_create_depth(_gx1 + 95, 535, 0, oSolidParent);
_s.image_xscale = 1.8; _s.image_yscale = 1.5;

// Rak Grimoire & Buku Sihir Kanan Bawah
_s = instance_create_depth(_gx2 - 110, 515, 0, oSolidParent);
_s.image_xscale = 2.8; _s.image_yscale = 2.2;
