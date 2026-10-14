/// @description Draw Event oBedroomDecor (Mana Seed RPG Masterpiece Bedroom)

var _gx1 = 440;
var _gy1 = 40;
var _gx2 = 840;
var _gy2 = 680;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Kayu Timber Bersih Mana Seed (dari sTile_Interior 0, 96)
var _floor_tile_w = 32;
var _floor_tile_h = 32;
for (var _fy = _gy1 + 60; _fy < _gy2; _fy += _floor_tile_h) {
    for (var _fx = _gx1; _fx < _gx2; _fx += _floor_tile_w) {
        var _tw = min(_floor_tile_w, _gx2 - _fx);
        var _th = min(_floor_tile_h, _gy2 - _fy);
        draw_sprite_part(sTile_Interior, 0, 0, 96, _tw, _th, _fx, _fy);
    }
}

// 3. Karpet Rajut Beludru Kerajaan (Royal Crimson Rug)
var _rug_x1 = _gx1 + 75;
var _rug_y1 = 200;
var _rug_x2 = _gx2 - 75;
var _rug_y2 = 470;

// Rumbai Tepi Emas Karpet
draw_set_color(make_color_rgb(195, 155, 60));
draw_roundrect_ext(_rug_x1 - 4, _rug_y1 - 4, _rug_x2 + 4, _rug_y2 + 4, 10, 10, false);
// Kain Beludru Merah Anggur
draw_set_color(make_color_rgb(135, 35, 48));
draw_roundrect_ext(_rug_x1, _rug_y1, _rug_x2, _rug_y2, 8, 8, false);
// Pola Tenun Runic Emas di Tengah Karpet
draw_set_color(make_color_rgb(175, 135, 50));
draw_roundrect_ext(_rug_x1 + 14, _rug_y1 + 14, _rug_x2 - 14, _rug_y2 - 14, 6, 6, true);
draw_circle((_rug_x1 + _rug_x2) / 2, (_rug_y1 + _rug_y2) / 2, 24, true);

// 4. Dinding Kayu Timber Bersih Utara (dari sTile_Interior 272, 192)
for (var _wx = _gx1; _wx < _gx2; _wx += 32) {
    var _ww = min(32, _gx2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 60, _wx, _gy1);
}
// Balok Kayu Atas & Pembatas Dinding
draw_set_color(make_color_rgb(46, 32, 18));
draw_rectangle(_gx1, _gy1 + 56, _gx2, _gy1 + 60, false);

// 5. Jendela Kaca Kastil dengan Sinar Mentari Pagi (Sunbeams)
var _draw_window = function(_wx, _wy) {
    draw_set_color(make_color_rgb(35, 25, 15));
    draw_roundrect_ext(_wx - 14, _wy - 26, _wx + 14, _wy + 14, 6, 6, false);
    draw_set_color(make_color_rgb(170, 225, 255));
    draw_roundrect_ext(_wx - 11, _wy - 23, _wx + 11, _wy + 11, 4, 4, false);
    draw_set_color(make_color_rgb(45, 32, 20));
    draw_line_width(_wx, _wy - 23, _wx, _wy + 11, 2);
    draw_line_width(_wx - 11, _wy - 6, _wx + 11, _wy - 6, 2);
    
    // Cahaya Mentari Lembut (Sunbeam)
    draw_set_alpha(0.09);
    draw_set_color(make_color_rgb(255, 245, 200));
    draw_triangle(_wx - 10, _wy + 12, _wx + 10, _wy + 12, _wx + 60, _wy + 220, false);
    draw_triangle(_wx - 10, _wy + 12, _wx + 60, _wy + 220, _wx + 40, _wy + 220, false);
    draw_set_alpha(1.0);
};

_draw_window(_gx1 + 175, _gy1 + 28);
_draw_window(_gx2 - 175, _gy1 + 28);

// 6. Perabotan Kayu Alami Mana Seed (dari sFurnishings)
// Lemari Buku Oak Tinggi di Kiri Atas
draw_sprite_part(sFurnishings, 0, 96, 0, 32, 80, _gx1 + 25, _gy1 + 45);

// Meja Belajar Kayu & Kursi di Kiri
draw_sprite_part(sFurnishings, 0, 64, 0, 32, 48, _gx1 + 25, 175);
// Buku & Lilin di Atas Meja
draw_set_color(make_color_rgb(255, 230, 150));
draw_circle(_gx1 + 40, 185, 2.5, false);

// Lemari Jam / Wardrobe Besar di Utara
draw_sprite_part(sFurnishings, 0, 128, 0, 32, 78, _gx1 + 105, _gy1 + 42);

// Meja Samping / Nakas di Samping Ranjang
draw_sprite_part(sFurnishings, 0, 0, 0, 32, 48, _gx2 - 75, _gy1 + 55);

// Guci Penyimpan Obat dari sBreakablePots
draw_sprite(sBreakablePots, 0, _gx1 + 40, 245);

// Peti Perlengkapan Ksatria dari sTreasureChest
draw_sprite(sTreasureChest, 0, _gx1 + 40, 520);

// 7. Pintu Keluar ke Altdorf Square (Selatan)
var _door_x = 640;
var _door_y = _gy2 - 10;
draw_set_color(make_color_rgb(60, 42, 24));
draw_roundrect_ext(_door_x - 30, _door_y - 20, _door_x + 30, _door_y + 10, 6, 6, false);
draw_set_color(make_color_rgb(180, 140, 80));
draw_line_width(_door_x - 26, _door_y + 8, _door_x + 26, _door_y + 8, 3);
// Karpet Pintu Selamat Datang
draw_set_color(make_color_rgb(160, 45, 55));
draw_roundrect_ext(_door_x - 22, _door_y - 6, _door_x + 22, _door_y + 4, 3, 3, false);
draw_set_color(c_white);
