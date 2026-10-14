/// @description Draw Event oDecorPotionShop (Mana Seed RPG Elysia's Masterpiece Apothecary)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _cx = 640;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Kayu Bersih Mana Seed (dari sTile_Interior 0, 96)
for (var _yy = _y1 + 75; _yy < _y2; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, _y2 - _yy);
        draw_sprite_part(sTile_Interior, 0, 0, 96, _tw, _th, _xx, _yy);
    }
}

// Karpet Beludru Ungu Mistik Menuju Meja Kasir (Royal Purple Runner)
var _rw = 36;
draw_set_color(make_color_rgb(195, 160, 60)); // Tepi Emas
draw_rectangle(_cx - _rw - 3, 275, _cx + _rw + 3, _y2 - 12, false);
draw_set_color(make_color_rgb(70, 30, 80));   // Beludru Ungu Mistik
draw_rectangle(_cx - _rw, 275, _cx + _rw, _y2 - 12, false);

// 3. Dinding Kayu Timber Bersih Utara (dari sTile_Interior 272, 192)
for (var _wx = _x1; _wx < _x2; _wx += 32) {
    var _ww = min(32, _x2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 75, _wx, _y1);
}
// Balok Penahan Dinding & Lis Plafon
draw_set_color(make_color_rgb(45, 28, 35));
draw_rectangle(_x1, _y1 + 72, _x2, _y1 + 76, false);

// Ikatan Daun Herbal Kering Menggantung di Plafon (Lavender, Chamomile, Mint)
var _draw_herb = function(_hx, _hy, _col_leaf, _col_flower) {
    draw_set_color(make_color_rgb(140, 115, 75)); // Tali rami
    draw_line(_hx, _hy - 8, _hx, _hy);
    draw_set_color(_col_leaf); // Daun
    draw_triangle(_hx, _hy, _hx - 7, _hy + 18, _hx + 7, _hy + 18, false);
    draw_set_color(_col_flower); // Bunga
    draw_circle(_hx - 2, _hy + 15, 2.5, false);
    draw_circle(_hx + 2, _hy + 17, 2.5, false);
};
_draw_herb(_x1 + 65, _y1 + 22, make_color_rgb(45, 95, 60), make_color_rgb(195, 120, 240)); // Lavender
_draw_herb(_x1 + 115, _y1 + 25, make_color_rgb(60, 110, 80), make_color_rgb(255, 230, 110)); // Chamomile
_draw_herb(_x2 - 115, _y1 + 25, make_color_rgb(40, 85, 55), make_color_rgb(245, 90, 120)); // Nightshade
_draw_herb(_x2 - 65, _y1 + 22, make_color_rgb(50, 105, 90), make_color_rgb(120, 240, 210)); // Mint

// 4. Kuali Alkimia Mistis (Arcane Cauldron) di Belakang Elysia
var _cldx = _cx;
var _cldy = _y1 + 52;

// Bayangan Kuali
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(_cldx - 44, _cldy + 12, _cldx + 44, _cldy + 44, false);
draw_set_alpha(1.0);

// Api Biru Mistik Pembakar Kuali
draw_set_alpha(0.85);
draw_set_color(make_color_rgb(80, 140, 255));
draw_ellipse(_cldx - 16, _cldy + 30, _cldx + 16, _cldy + 42, false);
draw_set_color(make_color_rgb(170, 235, 255));
draw_ellipse(_cldx - 9, _cldy + 32, _cldx + 9, _cldy + 40, false);
draw_set_alpha(1.0);

// Badan Kuali Perunggu Antik
draw_set_color(make_color_rgb(38, 42, 50));
draw_ellipse(_cldx - 40, _cldy - 2, _cldx + 40, _cldy + 34, false);
draw_set_color(make_color_rgb(190, 150, 65));
draw_ellipse(_cldx - 38, _cldy - 7, _cldx + 38, _cldy + 11, false);

// Cairan Ramuan Zamrud Berbuih
draw_set_color(make_color_rgb(45, 225, 150));
draw_ellipse(_cldx - 32, _cldy - 4, _cldx + 32, _cldy + 8, false);

// Pendaran Cahaya Hijau-Toska Kuali
var _c_glow = 0.85 + sin(cauldron_bubble * 1.5) * 0.15;
draw_set_alpha(0.25 * _c_glow);
draw_set_color(make_color_rgb(60, 255, 180));
draw_circle(_cldx, _cldy + 10, 68, false);

// Gelembung Ramuan Mendidih
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(180, 255, 220));
for (var _b = 0; _b < 6; _b++) {
    var _bx = _cldx + sin(cauldron_bubble * 1.8 + _b * 1.4) * 24;
    var _by = _cldy + 4 - ((cauldron_bubble * 14 + _b * 7) mod 28);
    draw_circle(_bx, _by, 2.5, false);
}
draw_set_alpha(1.0);

// 5. Peralatan Laboratorium di Belakang Elysia
// Alat Distilasi Kaca Alembic di Kiri
var _dst_x = _cx - 65;
var _dst_y = 190;
draw_set_color(make_color_rgb(75, 48, 32));
draw_roundrect_ext(_dst_x - 16, _dst_y + 16, _dst_x + 16, _dst_y + 34, 4, 4, false);
// Labu Ungu & Selang Spiral
draw_set_color(make_color_rgb(190, 95, 245));
draw_circle(_dst_x - 5, _dst_y + 10, 7, false);
draw_set_color(make_color_rgb(120, 240, 210));
draw_circle(_dst_x + 8, _dst_y + 14, 4, false);

// Rak Buku Grimoire Ramuan di Kanan Belakang
draw_sprite_part(sFurnishings, 0, 96, 0, 32, 80, _cx + 45, 150);

// 6. Meja Kasir Apotek (Apothecary Service Counter) di Depan Elysia
var _c_left = _cx - 125;
var _c_right = _cx + 125;
// Badan Meja Konter
draw_set_color(make_color_rgb(95, 55, 70));
draw_roundrect_ext(_c_left, 260, _c_right, 288, 4, 4, false);
// Atas Meja Konter Polesan Halus
draw_set_color(make_color_rgb(145, 85, 105));
draw_roundrect_ext(_c_left, 260, _c_right, 272, 3, 3, false);
// Tiang Penyangga Meja
draw_set_color(make_color_rgb(65, 35, 48));
for (var _px = _c_left + 15; _px < _c_right; _px += 38) {
    draw_line_width(_px, 272, _px, 288, 3);
}

// Timbangan Apotek Kuningan (Brass Scales) di Atas Konter Kiri
var _sc_x = _cx - 60;
var _sc_y = 265;
draw_set_color(make_color_rgb(230, 195, 75));
draw_line_width(_sc_x, _sc_y - 8, _sc_x, _sc_y, 2);
draw_line_width(_sc_x - 8, _sc_y - 8, _sc_x + 8, _sc_y - 8, 2);
draw_ellipse(_sc_x - 10, _sc_y - 4, _sc_x - 4, _sc_y - 2, false);
draw_ellipse(_sc_x + 4, _sc_y - 4, _sc_x + 10, _sc_y - 2, false);

// Botol Ramuan Sampel Merah & Biru di Atas Konter Kanan
draw_set_color(make_color_rgb(255, 60, 80)); // Healing
draw_roundrect_ext(_cx + 45, 262, _cx + 53, 270, 2, 2, false);
draw_set_color(make_color_rgb(60, 160, 255)); // Mana
draw_roundrect_ext(_cx + 57, 262, _cx + 65, 270, 2, 2, false);

// 7. Area Ruang Tamu & Riset Pelanggan (South Parlor)
// Lingkaran Transmutasi Astral di Tengah Karpet (Pulsating Rune Circle)
var _mcx = _cx;
var _mcy = 430;
var _glow = 0.75 + sin(magic_glow * 2.0) * 0.25;

draw_set_alpha(0.25 * _glow);
draw_set_color(make_color_rgb(180, 120, 255));
draw_circle(_mcx, _mcy, 58, false);

draw_set_alpha(0.8 * _glow);
draw_set_color(make_color_rgb(230, 190, 255));
draw_circle(_mcx, _mcy, 55, true);
draw_circle(_mcx, _mcy, 42, true);
draw_triangle(_mcx, _mcy - 36, _mcx + 30, _mcy + 18, _mcx - 30, _mcy + 18, true);
draw_triangle(_mcx, _mcy + 36, _mcx + 30, _mcy - 18, _mcx - 30, _mcy - 18, true);
draw_set_alpha(1.0);

// Lemari Terrarium Tanaman Kristal Bercahaya di Dinding Timur
draw_sprite_part(sFurnishings, 0, 128, 0, 32, 78, _x2 - 65, 340);
draw_set_color(make_color_rgb(140, 240, 255));
draw_circle(_x2 - 50, 375, 4, false); // Bunga bersinar di dalam
draw_set_color(make_color_rgb(255, 140, 210));
draw_circle(_x2 - 46, 395, 3.5, false);

// Meja Belajar Riset & Grimoire Herbal Terbuka di Dinding Barat
draw_sprite_part(sFurnishings, 0, 64, 0, 32, 48, _x1 + 25, 350);
// Kitab Terbuka di Meja
draw_set_color(make_color_rgb(240, 230, 205));
draw_rectangle(_x1 + 32, 356, _x1 + 48, 368, false);

// Guci-guci Ramuan & Peti Bahan Herbal Langka
draw_sprite(sBreakablePots, 0, _x1 + 40, 295);
draw_sprite(sBreakablePots, 0, _x2 - 40, 295);
draw_sprite(sBreakablePots, 0, _x1 + 45, 520);
draw_sprite(sTreasureChest, 0, _x2 - 50, 520);

// Keranjang Daun Kering di Kiri Bawah
draw_set_color(make_color_rgb(120, 85, 50));
draw_ellipse(_x1 + 45, 540, _x1 + 75, 565, false);
draw_set_color(make_color_rgb(90, 215, 120));
draw_circle(_x1 + 55, 545, 5, false);
draw_circle(_x1 + 65, 548, 6, false);

// Lentera Dinding Mistis Berpendar Toska
var _draw_mystic_lantern = function(_lx, _ly) {
    var _lglow = 0.75 + sin(magic_glow * 2.5 + _lx) * 0.25;
    draw_set_alpha(0.24 * _lglow);
    draw_set_color(make_color_rgb(120, 255, 215));
    draw_circle(_lx, _ly, 36, false);
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(190, 155, 65));
    draw_rectangle(_lx - 4, _ly - 6, _lx + 4, _ly + 6, false);
    draw_set_color(make_color_rgb(160, 255, 230));
    draw_circle(_lx, _ly, 3, false);
};

_draw_mystic_lantern(_x1 + 18, 200);
_draw_mystic_lantern(_x2 - 18, 200);
_draw_mystic_lantern(_x1 + 18, 480);
_draw_mystic_lantern(_x2 - 18, 480);

// 8. Pintu Keluar Selatan (ke Town Square)
var _door_x = _cx;
var _door_y = _y2 - 10;
draw_set_color(make_color_rgb(60, 28, 65));
draw_roundrect_ext(_door_x - 30, _door_y - 20, _door_x + 30, _door_y + 10, 6, 6, false);
draw_set_color(make_color_rgb(225, 185, 70));
draw_line_width(_door_x - 26, _door_y + 8, _door_x + 26, _door_y + 8, 3);

draw_set_color(c_white);
