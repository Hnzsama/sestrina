/// @description Draw Event oDecorBossChamber (Mana Seed RPG Altar Suci Bunga Cahaya Abadi)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _acx = 640;
var _acy = 360;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Kuil Suci Mana Seed (dari sTile_Autumn 192, 192)
var _tile_s = 32;
for (var _yy = _y1; _yy < _y2; _yy += _tile_s) {
    for (var _xx = _x1; _xx < _x2; _xx += _tile_s) {
        var _tw = min(_tile_s, _x2 - _xx);
        var _th = min(_tile_s, _y2 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// 3. Lingkaran Runic Arena Bos Purba (Concentric Runic Circles)
draw_set_color(make_color_rgb(45, 40, 58));
draw_circle(_acx, _acy, 175, false);
draw_set_color(make_color_rgb(75, 65, 95));
draw_circle(_acx, _acy, 175, true);

// Pendaran Emas & Cyan Suci
var _glow = 0.65 + sin(rune_glow) * 0.35;
draw_set_alpha(0.35 * _glow);
draw_set_color(make_color_rgb(255, 205, 80));
draw_circle(_acx, _acy, 140, false);

draw_set_alpha(0.9);
draw_set_color(make_color_rgb(255, 225, 115));
draw_circle(_acx, _acy, 140, true);
draw_circle(_acx, _acy, 100, true);
draw_circle(_acx, _acy, 60, true);

// Simbol Arcane di Sepanjang Lingkaran
for (var _a = 0; _a < 12; _a++) {
    var _rad = degtorad(_a * 30 + rune_glow * 10);
    var _rx = _acx + cos(_rad) * 120;
    var _ry = _acy + sin(_rad) * 120;
    draw_circle(_rx, _ry, 3, false);
}
draw_set_alpha(1.0);

// 4. Pilar Marmer Suci di 4 Sudut Arena
var _draw_sanctuary_pillar = function(_px, _py) {
    draw_set_color(make_color_rgb(85, 80, 105));
    draw_circle(_px, _py, 18, false);
    draw_set_color(make_color_rgb(135, 130, 160));
    draw_circle(_px, _py - 12, 15, false);
    // Inti Kristal Arcane Bercahaya
    draw_set_color(make_color_rgb(255, 215, 85));
    draw_circle(_px, _py - 12, 4, false);
};

_draw_sanctuary_pillar(_x1 + 45, _y1 + 75);
_draw_sanctuary_pillar(_x2 - 45, _y1 + 75);
_draw_sanctuary_pillar(_x1 + 45, _y2 - 75);
_draw_sanctuary_pillar(_x2 - 45, _y2 - 75);

// 5. Guci Upacara & Peti Harta Karun Emas Mana Seed
draw_sprite(sBreakablePots, 0, _acx - 85, _acy - 30);
draw_sprite(sBreakablePots, 0, _acx + 85, _acy - 30);

// Peti Emas Kerajaan (sTreasureChest frame 2 = gold closed)
draw_sprite(sTreasureChest, 2, _acx + 105, _acy + 15);

// 6. Altar Sentral Bunga Cahaya Abadi (The Lost Remedy)
// Pedestal Altar Suci
draw_set_color(make_color_rgb(60, 50, 78));
draw_roundrect_ext(_acx - 28, _acy - 28, _acx + 28, _acy + 28, 8, 8, false);
draw_set_color(make_color_rgb(240, 200, 80));
draw_roundrect_ext(_acx - 28, _acy - 28, _acx + 28, _acy + 28, 8, 8, true);

// Pendaran Cahaya Bunga Abadi
var _f_glow = 0.8 + sin(flower_anim * 2.0) * 0.2;
draw_set_alpha(0.5 * _f_glow);
draw_set_color(make_color_rgb(120, 230, 255));
draw_circle(_acx, _acy - 14, 24, false);

// Kelopak Bunga Berkilau
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(160, 240, 255));
draw_circle(_acx - 6, _acy - 14, 6, false);
draw_circle(_acx + 6, _acy - 14, 6, false);
draw_circle(_acx, _acy - 20, 6, false);
draw_circle(_acx, _acy - 8, 6, false);

// Inti Sari Bunga Emas
draw_set_color(make_color_rgb(255, 245, 130));
draw_circle(_acx, _acy - 14, 4, false);

// Partikel Motes Terbang dari Bunga
draw_set_color(c_white);
for (var _p = 0; _p < 4; _p++) {
    var _px = _acx + sin(flower_anim + _p * 1.5) * 16;
    var _py = _acy - 14 - ((flower_anim * 10 + _p * 8) mod 22);
    draw_circle(_px, _py, 1.5, false);
}

// Teks Pedestal & Status Quest
draw_set_color(make_color_rgb(255, 235, 140));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_acx, _acy + 34, "✧ Bunga Cahaya Abadi (Didapatkan!) ✧");

draw_set_color(make_color_rgb(180, 240, 255));
draw_text(_acx, _acy + 52, "▶ Berjalan ke Selatan [Bawah] Menuju Portal Suci!");

// 7. Portal Suci Kembali ke Kamar Sestrina (South Exit)
var _ptx = _acx;
var _pty = _y2 - 25;
var _p_glow = 0.8 + sin(rune_glow * 3.0) * 0.2;

draw_set_alpha(0.4 * _p_glow);
draw_set_color(make_color_rgb(100, 200, 255));
draw_ellipse(_ptx - 45, _pty - 12, _ptx + 45, _pty + 12, false);

draw_set_alpha(0.85);
draw_set_color(make_color_rgb(255, 220, 120));
draw_ellipse(_ptx - 38, _pty - 8, _ptx + 38, _pty + 8, true);
draw_ellipse(_ptx - 24, _pty - 5, _ptx + 24, _pty + 5, true);

// Banner Petunjuk Portal
draw_set_color(make_color_rgb(24, 40, 65));
draw_roundrect_ext(_ptx - 85, _pty - 36, _ptx + 85, _pty - 18, 4, 4, false);
draw_set_color(make_color_rgb(120, 220, 255));
draw_roundrect_ext(_ptx - 85, _pty - 36, _ptx + 85, _pty - 18, 4, 4, true);

draw_set_color(make_color_rgb(255, 240, 180));
draw_set_valign(fa_middle);
draw_text(_ptx, _pty - 27, "▼ PORTAL KE KAMAR");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
