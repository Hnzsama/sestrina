/// @description Draw Event oDecorOutskirts (Mana Seed RPG Ancient Forest & Outskirts)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _cx = 640;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Hamparan Rumput Musim Panas Mana Seed (dari sTile_Summer)
for (var _yy = _y1; _yy < _y2; _yy += 16) {
    for (var _xx = _x1; _xx < _x2; _xx += 16) {
        draw_sprite_part(sTile_Summer, 0, 0, 32, 16, 16, _xx, _yy);
    }
}

// 3. Jalan Tanah Berliku Mana Seed (Dirt Path)
for (var _py = _y1; _py < _y2; _py += 16) {
    var _pw = 56;
    var _pcx = _cx + sin((_py - _y1) * 0.014) * 48;
    for (var _px = _pcx - _pw / 2; _px <= _pcx + _pw / 2; _px += 16) {
        draw_sprite_part(sTile_Summer, 0, 32, 48, 16, 16, _px, _py);
    }
}

// 4. Sungai Alami & Air Berkilau Mana Seed di Sisi Timur
for (var _wy = _y1 + 40; _wy < _y2 - 60; _wy += 16) {
    for (var _wx = _x2 - 80; _wx < _x2 - 20; _wx += 16) {
        draw_sprite_part(sTile_Summer, 0, 112, 128, 16, 16, _wx, _wy);
    }
}
// Efek Kilau Air Sungai Beranimasi (sWaterSparkles)
var _spk_frame = (current_time div 160) mod 4;
draw_sprite(sWaterSparkles, _spk_frame, _x2 - 55, 160);
draw_sprite(sWaterSparkles, (_spk_frame + 1) mod 4, _x2 - 40, 310);
draw_sprite(sWaterSparkles, (_spk_frame + 2) mod 4, _x2 - 50, 470);

// 5. Tebing Batu & Pilar Reruntuhan Purba Mana Seed (Cliff Rocks)
// Formasi Tebing Batu Kiri
for (var _cy = 150; _cy < 260; _cy += 16) {
    draw_sprite_part(sTile_Summer, 0, 48, 160, 16, 16, _x1 + 30, _cy);
    draw_sprite_part(sTile_Summer, 0, 64, 160, 16, 16, _x1 + 46, _cy);
}
// Pilar Batu Reruntuhan
draw_set_color(make_color_rgb(95, 98, 95));
draw_roundrect_ext(_x1 + 85, 200, _x1 + 115, 255, 4, 4, false);
draw_set_color(make_color_rgb(45, 95, 50));
draw_rectangle(_x1 + 85, 235, _x1 + 115, 255, false);

// 6. Pohon Pinus Rimba Kuno Berayun Lembut (Tree Foliage)
var _draw_forest_tree = function(_tx, _ty) {
    var _sway = sin(tree_sway + _tx * 0.1) * 2;
    // Batang Kayu Oak
    draw_set_color(make_color_rgb(68, 42, 22));
    draw_rectangle(_tx - 8, _ty, _tx + 8, _ty + 30, false);
    // Mahkota Daun Pinus Rimbun
    draw_set_color(make_color_rgb(26, 58, 32));
    draw_triangle(_tx - 36 + _sway, _ty + 10, _tx + 36 + _sway, _ty + 10, _tx + _sway, _ty - 28, false);
    draw_set_color(make_color_rgb(34, 72, 40));
    draw_triangle(_tx - 28 + _sway, _ty - 8, _tx + 28 + _sway, _ty - 8, _tx + _sway, _ty - 48, false);
    draw_set_color(make_color_rgb(45, 92, 50));
    draw_triangle(_tx - 20 + _sway, _ty - 28, _tx + 20 + _sway, _ty - 28, _tx + _sway, _ty - 62, false);
};

// Deretan Pohon Hutan Kiri & Kanan
_draw_forest_tree(_x1 + 45, 120);
_draw_forest_tree(_x1 + 35, 300);
_draw_forest_tree(_x1 + 48, 470);

_draw_forest_tree(_x2 - 40, 110);
_draw_forest_tree(_x2 - 105, 280);
_draw_forest_tree(_x2 - 100, 480);

// 7. Guci & Peti Harta Karun Hutan Mana Seed
draw_sprite(sBreakablePots, 0, _x1 + 55, 390);
draw_sprite(sBreakablePots, 0, _x1 + 75, 405);
draw_sprite(sTreasureChest, 0, _x1 + 55, 530);

// 8. Gerbang Masuk Katakombe Kuno di Selatan
var _gtx = _cx;
var _gty = _y2 - 35;

// Lengkungan Batu Gerbang
draw_set_color(make_color_rgb(58, 62, 70));
draw_roundrect_ext(_gtx - 52, _gty - 42, _gtx + 52, _y2, 16, 16, false);
draw_set_color(c_black);
draw_roundrect_ext(_gtx - 36, _gty - 26, _gtx + 36, _y2, 12, 12, false);

// Tangga Turun ke Katakombe
draw_set_color(make_color_rgb(35, 38, 45));
for (var _sy = _gty - 20; _sy < _y2; _sy += 8) {
    draw_line_width(_gtx - 30, _sy, _gtx + 30, _sy, 2);
}

// Teks Indikator Gerbang
draw_set_color(make_color_rgb(140, 210, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_gtx, _gty - 46, "▼ GERBANG KATAKOMBE");

// 9. Lapisan Kabut Hutan Mistis (Forest Mist)
draw_set_alpha(0.12);
draw_set_color(make_color_rgb(210, 230, 255));
for (var _m = 0; _m < 3; _m++) {
    var _my = _y1 + 100 + _m * 180 + sin(mist_anim + _m) * 20;
    draw_ellipse(_x1 - 50, _my - 40, _x2 + 50, _my + 40, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
