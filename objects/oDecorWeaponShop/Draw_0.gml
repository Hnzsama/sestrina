/// @description Draw Event oDecorWeaponShop (Mana Seed RPG Goran's Masterpiece Forge)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _cx = 640;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Toko (Area Kerja Batu Tahan Api & Area Pelanggan Kayu Hangat)
// Area Kerja Pandai Besi (Utara: Flagstone Batu Hitam dari sTile_Autumn 192, 192)
for (var _yy = _y1 + 75; _yy < 275; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, 275 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// Area Depan Pelanggan (Selatan: Lantai Kayu Bersih dari sTile_Interior 0, 96)
for (var _yy = 275; _yy < _y2; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, _y2 - _yy);
        draw_sprite_part(sTile_Interior, 0, 0, 96, _tw, _th, _xx, _yy);
    }
}

// Karpet Merah Megah Menuju Meja Kasir (Royal Crimson Runner)
var _rw = 36;
draw_set_color(make_color_rgb(180, 140, 50)); // Tepi Emas
draw_rectangle(_cx - _rw - 3, 275, _cx + _rw + 3, _y2 - 12, false);
draw_set_color(make_color_rgb(130, 32, 45));  // Beludru Merah
draw_rectangle(_cx - _rw, 275, _cx + _rw, _y2 - 12, false);
// Pola Tenun Emas di Tengah Karpet
draw_set_color(make_color_rgb(175, 135, 50));
for (var _ky = 300; _ky < _y2 - 30; _ky += 36) {
    draw_rectangle(_cx - 14, _ky, _cx + 14, _ky + 18, true);
}

// Efek Panas Bara Api Melingkar di Sekitar Tungku
var _flicker = sin(current_time * 0.008) * 6;
draw_set_alpha(0.28);
draw_set_color(make_color_rgb(255, 95, 20));
draw_ellipse(_cx - 100, _y1 + 55, _cx + 100, _y1 + 185, false);
draw_set_alpha(1.0);

// 3. Dinding Kayu Timber Bersih Utara (dari sTile_Interior 272, 192)
for (var _wx = _x1; _wx < _x2; _wx += 32) {
    var _ww = min(32, _x2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 75, _wx, _y1);
}
// Balok Penahan Dinding
draw_set_color(make_color_rgb(45, 30, 18));
draw_rectangle(_x1, _y1 + 72, _x2, _y1 + 76, false);

// 4. Tungku Tempa Raksasa (Giant Stone Forge & Chimney)
// Struktur Batu Cerobong & Tungku
draw_set_color(make_color_rgb(52, 48, 56));
draw_roundrect_ext(_cx - 52, _y1 + 8, _cx + 52, _y1 + 75, 8, 8, false);
draw_set_color(make_color_rgb(32, 28, 36));
draw_roundrect_ext(_cx - 40, _y1 + 22, _cx + 40, _y1 + 73, 6, 6, false);
// Lis Besi Penjepit Tungku
draw_set_color(make_color_rgb(85, 80, 95));
draw_rectangle(_cx - 52, _y1 + 18, _cx + 52, _y1 + 22, false);

// Api Berkobar & Bara Emas di Dalam Tungku
draw_set_color(make_color_rgb(255, 110, 25));
draw_circle(_cx, _y1 + 50 + _flicker, 16, false);
draw_set_color(make_color_rgb(255, 220, 60));
draw_circle(_cx, _y1 + 50 + _flicker, 9, false);
draw_set_color(c_white);
draw_circle(_cx, _y1 + 49 + _flicker, 4, false);

// 5. Peralatan Tempa di Belakang Meja (Area Goran)
// Landasan Tempa Baja (Anvil) di Kiri Goran
draw_set_color(make_color_rgb(70, 75, 85));
draw_roundrect_ext(_cx - 65, 190, _cx - 35, 212, 4, 4, false);
draw_set_color(make_color_rgb(40, 42, 50));
draw_rectangle(_cx - 58, 212, _cx - 42, 225, false); // Kaki tunggul kayu
// Palu Tempa di Atas Anvil
draw_set_color(make_color_rgb(180, 140, 80));
draw_line_width(_cx - 56, 196, _cx - 44, 206, 2);

// Bak Pendingin Air Baja (Quenching Basin) di Kanan Goran
draw_set_color(make_color_rgb(85, 60, 40));
draw_roundrect_ext(_cx + 35, 190, _cx + 70, 225, 6, 6, false);
draw_set_color(make_color_rgb(45, 130, 185)); // Air pendingin
draw_roundrect_ext(_cx + 39, 194, _cx + 66, 221, 4, 4, false);

// Tumpukan Batubara & Kayu Bakar di Kiri
draw_set_color(make_color_rgb(24, 24, 28));
draw_circle(_x1 + 35, 130, 8, false);
draw_circle(_x1 + 45, 134, 9, false);
draw_circle(_x1 + 40, 124, 7, false);

// Tumpukan Balok Besi Tempa (Iron Ingots) di Kanan
for (var _ig = 0; _ig < 3; _ig++) {
    draw_set_color(make_color_rgb(110, 115, 130));
    draw_rectangle(_x2 - 55, 125 + _ig * 9, _x2 - 30, 132 + _ig * 9, false);
    draw_set_color(make_color_rgb(60, 65, 75));
    draw_rectangle(_x2 - 55, 125 + _ig * 9, _x2 - 30, 132 + _ig * 9, true);
}

// Rak Senjata Dinding (Pedang & Perisai Dipajang di Tembok)
draw_set_color(make_color_rgb(120, 85, 50));
draw_rectangle(_x1 + 75, _y1 + 25, _x1 + 135, _y1 + 55, false);
draw_rectangle(_x2 - 135, _y1 + 25, _x2 - 75, _y1 + 55, false);
// Siluet Pedang Perak & Perisai
draw_set_color(make_color_rgb(200, 205, 220));
draw_line_width(_x1 + 85, _y1 + 50, _x1 + 125, _y1 + 30, 2);
draw_line_width(_x1 + 85, _y1 + 30, _x1 + 125, _y1 + 50, 2);
draw_set_color(make_color_rgb(180, 140, 60));
draw_circle(_x2 - 105, _y1 + 40, 10, false);
draw_set_color(make_color_rgb(60, 80, 110));
draw_circle(_x2 - 105, _y1 + 40, 7, false);

// 6. Meja Kasir Kayu Pelayanan (Shop Counter) di Depan Goran
// Counter membentang di y = 260..288
var _c_left = _cx - 125;
var _c_right = _cx + 125;
// Badan Meja Konter
draw_set_color(make_color_rgb(115, 80, 48));
draw_roundrect_ext(_c_left, 260, _c_right, 288, 4, 4, false);
// Atas Meja Konter Polesan Halus
draw_set_color(make_color_rgb(165, 115, 68));
draw_roundrect_ext(_c_left, 260, _c_right, 272, 3, 3, false);
// Tiang Penyangga Meja
draw_set_color(make_color_rgb(75, 50, 30));
for (var _px = _c_left + 15; _px < _c_right; _px += 38) {
    draw_line_width(_px, 272, _px, 288, 3);
}

// Kotak Kaca Pajangan Senjata di Atas Meja Konter
draw_set_color(make_color_rgb(140, 215, 255));
draw_set_alpha(0.6);
draw_roundrect_ext(_cx - 85, 262, _cx - 25, 270, 2, 2, false);
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(255, 215, 90));
draw_line(_cx - 80, 266, _cx - 30, 266); // Pedang emas contoh

// Buku Catatan & Lilin di Konter Kanan
draw_set_color(make_color_rgb(240, 235, 215));
draw_rectangle(_cx + 45, 263, _cx + 65, 270, false);
draw_set_color(make_color_rgb(255, 220, 120));
draw_circle(_cx + 80, 265, 3, false);

// 7. Area Pajangan & Ruang Tunggu Pelanggan (South Showroom)
// Lemari Perkakas Besar di Barat (West Wall)
draw_sprite_part(sFurnishings, 0, 96, 0, 32, 80, _x1 + 25, 330);
draw_sprite_part(sFurnishings, 0, 160, 0, 32, 78, _x1 + 25, 430);

// Meja Display Zirah & Perisai di Timur (East Wall)
draw_sprite_part(sFurnishings, 0, 64, 0, 32, 48, _x2 - 65, 330);
draw_sprite_part(sFurnishings, 0, 128, 0, 32, 78, _x2 - 65, 410);

// Tong Kayu Berisi Tombak & Senjata Latihan
draw_set_color(make_color_rgb(110, 75, 45));
draw_ellipse(_x1 + 45, 530, _x1 + 75, 555, false);
draw_set_color(make_color_rgb(190, 170, 140));
draw_line_width(_x1 + 60, 532, _x1 + 52, 505, 3);
draw_line_width(_x1 + 62, 532, _x1 + 70, 502, 3);
draw_line_width(_x1 + 58, 532, _x1 + 60, 498, 3);

// Peti Penyimpan Bahan Logam dari sTreasureChest
draw_sprite(sTreasureChest, 0, _x2 - 50, 525);

// Guci Pendingin dari sBreakablePots
draw_sprite(sBreakablePots, 0, _x1 + 40, 295);
draw_sprite(sBreakablePots, 0, _x2 - 40, 295);

// Obor Dinding Berpendar Hangat (Wall Sconces)
var _draw_torch = function(_tx, _ty) {
    var _tglow = 0.75 + sin(current_time * 0.009 + _tx) * 0.25;
    draw_set_alpha(0.22 * _tglow);
    draw_set_color(make_color_rgb(255, 140, 40));
    draw_circle(_tx, _ty, 36, false);
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(45, 45, 50));
    draw_rectangle(_tx - 3, _ty, _tx + 3, _ty + 12, false);
    draw_set_color(make_color_rgb(255, 130, 20));
    draw_circle(_tx, _ty - 4, 5, false);
    draw_set_color(make_color_rgb(255, 230, 80));
    draw_circle(_tx, _ty - 4, 2.5, false);
};

_draw_torch(_x1 + 18, 200);
_draw_torch(_x2 - 18, 200);
_draw_torch(_x1 + 18, 480);
_draw_torch(_x2 - 18, 480);

// 8. Pintu Keluar Selatan (ke Town Square)
var _door_x = _cx;
var _door_y = _y2 - 10;
draw_set_color(make_color_rgb(55, 38, 24));
draw_roundrect_ext(_door_x - 30, _door_y - 20, _door_x + 30, _door_y + 10, 6, 6, false);
draw_set_color(make_color_rgb(180, 140, 80));
draw_line_width(_door_x - 26, _door_y + 8, _door_x + 26, _door_y + 8, 3);

draw_set_color(c_white);
