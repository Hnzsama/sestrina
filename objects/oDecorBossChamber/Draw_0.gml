/// @description Draw Event oDecorBossChamber (The Forgotten Sanctum of the Guardian - Full 1280x720)

var _x1 = 40;
var _y1 = 40;
var _x2 = 1240;
var _y2 = 680;
var _acx = 640;
var _acy = 360;

// 1. Latar Belakang Luar Kuil Purba (Sanctuary Outer Void)
draw_set_color(make_color_rgb(12, 10, 18));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Kuil Suci Mana Seed Menutupi Seluruh Ruangan (dari sTile_Autumn 192, 192)
var _tile_s = 32;
for (var _yy = _y1; _yy < _y2; _yy += _tile_s) {
    for (var _xx = _x1; _xx < _x2; _xx += _tile_s) {
        var _tw = min(_tile_s, _x2 - _xx);
        var _th = min(_tile_s, _y2 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// 3. Lingkaran Runic Arena Bos Purba Megah (Concentric Grand Runic Circles)
draw_set_color(make_color_rgb(45, 40, 58));
draw_circle(_acx, _acy, 210, false);
draw_set_color(make_color_rgb(75, 65, 95));
draw_circle(_acx, _acy, 210, true);

// Pendaran Emas & Cyan Suci
var _glow = 0.65 + sin(rune_glow) * 0.35;
draw_set_alpha(0.35 * _glow);
draw_set_color(make_color_rgb(255, 205, 80));
draw_circle(_acx, _acy, 170, false);

draw_set_alpha(0.9);
draw_set_color(make_color_rgb(255, 225, 115));
draw_circle(_acx, _acy, 170, true);
draw_circle(_acx, _acy, 120, true);
draw_circle(_acx, _acy, 70, true);

// Simbol Arcane di Sepanjang Lingkaran Luar
for (var _a = 0; _a < 16; _a++) {
    var _rad = degtorad(_a * 22.5 + rune_glow * 10);
    var _rx = _acx + cos(_rad) * 150;
    var _ry = _acy + sin(_rad) * 150;
    draw_circle(_rx, _ry, 3.5, false);
}
draw_set_alpha(1.0);

// 4. Pilar Marmer Suci Kuil Purba dari sDungeon_Props di 4 Sudut Arena
var _draw_sanctuary_pillar = function(_px, _py) {
    draw_sprite_part(sDungeon_Props, 0, 0, 0, 32, 64, _px - 16, _py - 36);
    
    // Inti Kristal Arcane Bercahaya di Puncak Pilar
    var _pglow = 0.7 + sin(rune_glow + _px) * 0.3;
    draw_set_alpha(0.35 * _pglow);
    draw_set_color(make_color_rgb(100, 220, 255));
    draw_circle(_px, _py - 24, 28, false);
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_circle(_px, _py - 24, 5, false);
};

_draw_sanctuary_pillar(_acx - 220, _acy - 140);
_draw_sanctuary_pillar(_acx + 220, _acy - 140);
_draw_sanctuary_pillar(_acx - 220, _acy + 140);
_draw_sanctuary_pillar(_acx + 220, _acy + 140);

// 5. Ornamen Kuil & Guci Relik di Tepi Ruangan
draw_sprite(sBreakablePots, 0, 160, 200);
draw_sprite(sBreakablePots, 0, 190, 220);
draw_sprite(sBreakablePots, 0, 1080, 200);
draw_sprite(sBreakablePots, 0, 1110, 220);

// Peti Emas Kerajaan (sTreasureChest frame 2 = gold closed)
draw_sprite(sTreasureChest, 2, _acx + 180, _acy + 15);

// 6. Altar Sentral Penawar Kuno (The Lost Remedy Pedestal)
// Pedestal Altar Suci
draw_set_color(make_color_rgb(60, 50, 78));
draw_roundrect_ext(_acx - 32, _acy - 32, _acx + 32, _acy + 32, 8, 8, false);
draw_set_color(make_color_rgb(240, 200, 80));
draw_roundrect_ext(_acx - 32, _acy - 32, _acx + 32, _acy + 32, 8, 8, true);

// Pendaran Cahaya The Lost Remedy
var _f_glow = 0.8 + sin(flower_anim * 2.0) * 0.2;
draw_set_alpha(0.5 * _f_glow);
draw_set_color(make_color_rgb(120, 230, 255));
draw_circle(_acx, _acy - 16, 28, false);

// Kristal / Botol Relik The Lost Remedy Berkilau
draw_set_alpha(1.0);
draw_set_color(make_color_rgb(160, 240, 255));
draw_circle(_acx - 7, _acy - 16, 7, false);
draw_circle(_acx + 7, _acy - 16, 7, false);
draw_circle(_acx, _acy - 23, 7, false);
draw_circle(_acx, _acy - 9, 7, false);

// Inti Sari Tenaga Penyembuh
draw_set_color(make_color_rgb(255, 245, 140));
draw_circle(_acx, _acy - 16, 5, false);

// Partikel Motes Melayang dari The Lost Remedy
draw_set_color(c_white);
for (var _p = 0; _p < 6; _p++) {
    var _px = _acx + sin(flower_anim + _p * 1.2) * 20;
    var _py = _acy - 16 - ((flower_anim * 12 + _p * 7) mod 26);
    draw_circle(_px, _py, 1.5, false);
}

// Teks Pedestal & Status Quest
draw_set_color(make_color_rgb(255, 235, 140));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_acx, _acy + 38, "✧ The Lost Remedy (Tersedia!) ✧");

draw_set_color(make_color_rgb(180, 240, 255));
draw_text(_acx, _acy + 58, "▶ Ambil Penawar & Lewati Portal ke Selatan!");

// 7. Portal Suci Kembali ke Gubuk Adik (South Exit)
var _ptx = _acx;
var _pty = _y2 - 25;
var _p_glow = 0.8 + sin(rune_glow * 3.0) * 0.2;

draw_set_alpha(0.4 * _p_glow);
draw_set_color(make_color_rgb(100, 200, 255));
draw_ellipse(_ptx - 55, _pty - 14, _ptx + 55, _pty + 14, false);

draw_set_alpha(0.85);
draw_set_color(make_color_rgb(255, 220, 120));
draw_ellipse(_ptx - 46, _pty - 10, _ptx + 46, _pty + 10, true);
draw_ellipse(_ptx - 30, _pty - 6, _ptx + 30, _pty + 6, true);

// Banner Petunjuk Portal
draw_set_color(make_color_rgb(24, 40, 65));
draw_roundrect_ext(_ptx - 105, _pty - 38, _ptx + 105, _pty - 18, 4, 4, false);
draw_set_color(make_color_rgb(120, 220, 255));
draw_roundrect_ext(_ptx - 105, _pty - 38, _ptx + 105, _pty - 18, 4, 4, true);

draw_set_color(make_color_rgb(255, 240, 180));
draw_set_valign(fa_middle);
draw_text(_ptx, _pty - 28, "▼ PORTAL KE GUBUK SESTRINA");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
