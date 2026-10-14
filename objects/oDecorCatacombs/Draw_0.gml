/// @description Draw Event oDecorCatacombs (Mana Seed RPG Ancient Catacombs Crypt)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _cx = 640;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Flagstone Hitam Kuno (dari sTile_Autumn 192, 192)
var _tile_s = 32;
for (var _yy = _y1 + 75; _yy < _y2; _yy += _tile_s) {
    for (var _xx = _x1; _xx < _x2; _xx += _tile_s) {
        var _tw = min(_tile_s, _x2 - _xx);
        var _th = min(_tile_s, _y2 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// 3. Dinding Batu Katakombe Purba Utara (dari sTile_Interior 272, 192)
for (var _wx = _x1; _wx < _x2; _wx += 32) {
    var _ww = min(32, _x2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 75, _wx, _y1);
}
// Bayangan Gelap & Balok Dinding Bawah Tanah
draw_set_color(make_color_rgb(25, 28, 36));
draw_rectangle(_x1, _y1 + 72, _x2, _y1 + 76, false);
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(15, 18, 25));
draw_rectangle(_x1, _y1, _x2, _y1 + 75, false);
draw_set_alpha(1.0);

// 4. Obor Dinding Api Biru Mistis (Soul-Fire Torches)
var _draw_blue_torch = function(_tx, _ty) {
    var _glow = 0.75 + sin(torch_blue_flame + _tx) * 0.25;
    
    // Pendaran Cahaya Biru Mistis
    draw_set_alpha(0.24 * _glow);
    draw_set_color(make_color_rgb(60, 160, 255));
    draw_circle(_tx, _ty - 6, 38, false);
    
    // Braket Obor Besi Hitam
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(24, 25, 32));
    draw_rectangle(_tx - 3, _ty, _tx + 3, _ty + 14, false);
    draw_rectangle(_tx - 6, _ty - 4, _tx + 6, _ty, false);
    
    // Kobaran Api Biru Berkobar
    draw_set_color(make_color_rgb(45, 145, 255));
    draw_ellipse(_tx - 5, _ty - 16, _tx + 5, _ty - 4, false);
    draw_set_color(make_color_rgb(180, 235, 255));
    draw_ellipse(_tx - 3, _ty - 14, _tx + 3, _ty - 6, false);
};

_draw_blue_torch(_x1 + 45, _y1 + 50);
_draw_blue_torch(_x2 - 45, _y1 + 50);
_draw_blue_torch(_x1 + 45, 360);
_draw_blue_torch(_x2 - 45, 360);

// 5. Sarkofagus Kuno & Tulang Belulang
// Peti Sarkofagus Batu
draw_set_color(make_color_rgb(52, 56, 68));
draw_roundrect_ext(_x1 + 30, 150, _x1 + 85, 270, 8, 8, false);
draw_set_color(make_color_rgb(80, 86, 102));
draw_roundrect_ext(_x1 + 33, 153, _x1 + 82, 267, 6, 6, true);
// Simbol Tengkorak Purba
draw_set_color(make_color_rgb(30, 32, 40));
draw_circle(_x1 + 57, 185, 8, false);

// 6. Guci & Peti Harta Karun Mana Seed di Katakombe
// Guci Kuno dari sBreakablePots
draw_sprite(sBreakablePots, 0, _x1 + 45, 320);
draw_sprite(sBreakablePots, 0, _x1 + 65, 335);
draw_sprite(sBreakablePots, 0, _x2 - 50, 480);
draw_sprite(sBreakablePots, 0, _x2 - 70, 495);

// Peti Logam Rahasia Katakombe dari sTreasureChest
draw_sprite(sTreasureChest, 0, _x1 + 50, 520);

// 7. Efek Tetesan Air Bawah Tanah (Drip Puddles)
var _puddle_radius = 6 + sin(drip_timer * 1.5) * 2;
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(70, 140, 180));
draw_ellipse(580 - _puddle_radius, 280 - _puddle_radius / 2, 580 + _puddle_radius, 280 + _puddle_radius / 2, false);
draw_ellipse(720 - _puddle_radius, 460 - _puddle_radius / 2, 720 + _puddle_radius, 460 + _puddle_radius / 2, false);
draw_set_alpha(1.0);

// 8. Gerbang Besi Masuk Ruang Boss (Sanctum Gate) di Selatan
var _gtx = _cx;
var _gty = _y2 - 35;

draw_set_color(make_color_rgb(65, 70, 85));
draw_roundrect_ext(_gtx - 55, _gty - 45, _gtx + 55, _y2, 16, 16, false);
draw_set_color(c_black);
draw_roundrect_ext(_gtx - 40, _gty - 30, _gtx + 40, _y2, 12, 12, false);

// Kisi-kisi Gerbang Besi
draw_set_color(make_color_rgb(140, 150, 170));
for (var _gx = _gtx - 30; _gx <= _gtx + 30; _gx += 12) {
    draw_line_width(_gx, _gty - 25, _gx, _y2, 3);
}

// Teks Indikator Ruang Boss
draw_set_color(make_color_rgb(255, 95, 95));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_gtx, _gty - 50, "☠ RUANG BOSS GOLEM");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
