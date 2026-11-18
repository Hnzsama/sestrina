/// @description Draw Event oDecorWeaponShop (Authentic Goran Masterpiece Blacksmith Workshop)

var _x1 = 64;
var _y1 = 40;
var _x2 = 1216;
var _y2 = 680;
var _cx = 640;

// 1. Latar Belakang Luar Bengkel (Outer Wall Frame)
draw_set_color(make_color_rgb(16, 18, 24));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Toko
// Area Kerja Pandai Besi (Utara: Flagstone Batu Hitam Tahan Api dari sTile_Autumn 192, 192)
for (var _yy = _y1 + 75; _yy < 270; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, 270 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// Area Depan Pelanggan (Selatan: Lantai Kayu Bersih dari sTile_Interior 0, 96)
for (var _yy = 270; _yy < _y2; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, _y2 - _yy);
        draw_sprite_part(sTile_Interior, 0, 0, 96, _tw, _th, _xx, _yy);
    }
}

// Karpet Merah Megah Menuju Meja Kasir (Royal Crimson Runner)
var _rw = 36;
draw_set_color(make_color_rgb(180, 140, 50)); // Tepi Emas
draw_rectangle(_cx - _rw - 3, 270, _cx + _rw + 3, _y2 - 12, false);
draw_set_color(make_color_rgb(130, 32, 45));  // Beludru Merah
draw_rectangle(_cx - _rw, 270, _cx + _rw, _y2 - 12, false);

// Pola Tenun Emas di Tengah Karpet
draw_set_color(make_color_rgb(175, 135, 50));
for (var _ky = 295; _ky < _y2 - 30; _ky += 36) {
    draw_rectangle(_cx - 14, _ky, _cx + 14, _ky + 18, true);
}

// 3. Dinding Kayu Timber Bersih Utara (dari sTile_Interior 272, 192)
for (var _wx = _x1; _wx < _x2; _wx += 32) {
    var _ww = min(32, _x2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 75, _wx, _y1);
}
// Balok Penahan Dinding
draw_set_color(make_color_rgb(45, 30, 18));
draw_rectangle(_x1, _y1 + 72, _x2, _y1 + 76, false);

// 4. DEKORASI BENGKEL PANDAI BESI RESMI (Goran Blacksmith Masterpack)
// Plakat Penghargaan Perang Veteran di Dinding Utara
draw_sprite(sDecor_TrophyPlaque, 0, _cx - 240, _y1 + 18);
draw_sprite(sDecor_TrophyPlaque, 0, _cx + 176, _y1 + 18);

// Pendaran Panas Bara Api Melingkar di Sekitar Tungku
var _flicker = sin(current_time * 0.007) * 8;
draw_set_alpha(0.32);
draw_set_color(make_color_rgb(255, 95, 20));
draw_ellipse(_cx - 110, _y1 + 25, _cx + 110, _y1 + 155, false);
draw_set_alpha(0.18);
draw_set_color(make_color_rgb(255, 180, 40));
draw_circle(_cx, _y1 + 70, 75 + _flicker, false);
draw_set_alpha(1.0);

// Tungku Tempa Raksasa Masterpiece (Grand Furnace Forge)
draw_sprite(sDecor_GrandFurnace, 0, _cx - 48, _y1 + 6);

// Percikan Bara Api Mikro Melayang
var _spark_t = current_time * 0.003;
for (var _sp = 0; _sp < 5; _sp++) {
    var _spx = _cx - 20 + ((_sp * 37 + floor(current_time * 0.05)) % 40);
    var _spy = _y1 + 55 - ((floor(current_time * 0.08) + _sp * 15) % 50);
    draw_set_color(make_color_rgb(255, 200, 80));
    draw_circle(_spx, _spy, 1.5, false);
}

// Master Anvil & Quenching Vat (Landasan Tempa Baja & Bak Pendingin)
draw_sprite(sDecor_MasterAnvil, 0, _cx - 160, 150);

// Bunker Batubara & Balok Logam Berharga (Precious Ingots & Coal Bunker)
draw_sprite(sDecor_CoalBunker, 0, _cx - 240, 185);

// Deluxe Workbench & Grindstone (Meja Kerja Perkakas & Batu Asah Berputar)
draw_sprite(sDecor_Workbench, 0, _cx + 96, 155);

// Meja Kasir / Pelayanan Goran (Merchant Service Counter)
draw_sprite(sDecor_ServiceCounter, 0, _cx - 128, 248);
draw_sprite(sDecor_ServiceCounter, 0, _cx, 248);

// 5. AREA SHOWROOM PERLENGKAPAN & SENJATA (South Showroom)
// Rak Senjata Dinding Megah (Grand Weapon Racks)
draw_sprite(sDecor_WeaponRacks, 0, _x1 + 20, 310);
draw_sprite(sDecor_WeaponRacks, 0, _x2 - 116, 310);

// Pajangan Baju Zirah Ksatria Barbar (Barbarian Armor Display)
draw_sprite(sDecor_ArmorDisplay, 0, _x1 + 44, 405);
draw_sprite(sDecor_ArmorDisplay, 0, _x2 - 92, 405);

// Peti Penyimpan Bahan Logam & Perisai Cadangan
draw_sprite(sTreasureChest, 0, _x2 - 75, 520);
draw_sprite(sTreasureChest, 0, _x1 + 40, 520);

// Obor Dinding Berpendar Hangat (Wall Sconces)
var _draw_torch = function(_tx, _ty) {
    var _tglow = 0.75 + sin(current_time * 0.009 + _tx) * 0.25;
    draw_set_alpha(0.25 * _tglow);
    draw_set_color(make_color_rgb(255, 140, 40));
    draw_circle(_tx, _ty, 40, false);
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

// 6. Pintu Keluar Selatan (ke Altdorf Town Square)
var _door_x = _cx;
var _door_y = _y2 - 10;
draw_set_color(make_color_rgb(55, 38, 24));
draw_roundrect_ext(_door_x - 30, _door_y - 20, _door_x + 30, _door_y + 10, 6, 6, false);
draw_set_color(make_color_rgb(180, 140, 80));
draw_line_width(_door_x - 26, _door_y + 8, _door_x + 26, _door_y + 8, 3);

draw_set_color(c_white);
draw_set_alpha(1.0);
