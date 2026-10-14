/// @description Draw Event oDecorTown (Mana Seed RPG Altdorf Masterpiece Town Square)

var _x1 = 440;
var _y1 = 40;
var _x2 = 840;
var _y2 = 680;
var _cx = 640;
var _cy = 360;

// 1. Latar Luar Ruangan (Void Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Hamparan Rumput Musim Panas Berbunga Mana Seed (Clean Meadow dari sTile_Summer 16, 96)
for (var _yy = _y1; _yy < _y2; _yy += 32) {
    for (var _xx = _x1; _xx < _x2; _xx += 32) {
        var _tw = min(32, _x2 - _xx);
        var _th = min(32, _y2 - _yy);
        draw_sprite_part(sTile_Summer, 0, 16, 96, _tw, _th, _xx, _yy);
    }
}

// 3. Jaringan Jalan Batu Halus Kota (Smooth Cobblestone Avenues)
// Jalan Utama Utara ke Selatan (Utara 640 -> Alun-alun 640 -> Selatan 640)
var _draw_cobble_road = function(_rx1, _ry1, _rx2, _ry2) {
    // Dasar Batu
    draw_set_color(make_color_rgb(115, 105, 95));
    draw_roundrect_ext(_rx1 - 2, _ry1 - 2, _rx2 + 2, _ry2 + 2, 8, 8, false);
    draw_set_color(make_color_rgb(145, 138, 125));
    draw_roundrect_ext(_rx1, _ry1, _rx2, _ry2, 6, 6, false);
    // Tekstur ubin batu alami
    draw_set_color(make_color_rgb(125, 118, 105));
    for (var _py = _ry1 + 4; _py < _ry2 - 4; _py += 14) {
        var _off = ((_py div 14) mod 2) * 8;
        for (var _px = _rx1 + 4 + _off; _px < _rx2 - 4; _px += 16) {
            draw_roundrect_ext(_px, _py, min(_rx2 - 4, _px + 12), _py + 10, 2, 2, true);
        }
    }
};

// Jalan Vertikal Utama (Utara -> Air Mancur -> Selatan)
_draw_cobble_road(_cx - 40, 85, _cx + 40, _y2 - 10);
// Cabang Jalan Barat ke Toko Pandai Besi Goran
_draw_cobble_road(490, 150, _cx, 230);
// Cabang Jalan Timur ke Toko Apotek Elysia
_draw_cobble_road(_cx, 150, 790, 230);

// Lapangan Bundar di Sekitar Air Mancur (Fountain Plaza)
draw_set_color(make_color_rgb(115, 105, 95));
draw_circle(_cx, _cy, 88, false);
draw_set_color(make_color_rgb(145, 138, 125));
draw_circle(_cx, _cy, 84, false);
draw_set_color(make_color_rgb(125, 118, 105));
draw_circle(_cx, _cy, 80, true);
draw_circle(_cx, _cy, 68, true);

// 4. Bangunan Toko Otentik Mana Seed di Utara (Cottages dari sTile_Timber)
// Gedung Barat: Pandai Besi Goran (x: 445..545, y: 55..155)
// Atap & Fasad Cottage Kayu dari sTile_Timber (48, 48, 80, 80)
draw_sprite_part(sTile_Timber, 0, 48, 48, 80, 80, 470, 75);
// Cerobong Asap Batu di Atas Toko Goran
draw_sprite_part(sTile_Timber, 0, 20, 0, 28, 40, 475, 42);
// Asap Mengepul dari Cerobong
var _smoke_y = (current_time * 0.02) mod 24;
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(220, 220, 225));
draw_circle(488, 38 - _smoke_y, 4 + _smoke_y * 0.2, false);
draw_circle(486, 26 - _smoke_y, 6 + _smoke_y * 0.3, false);
draw_set_alpha(1.0);

// Plang Nama Pedang Besi Toko Goran
draw_set_color(make_color_rgb(95, 60, 35));
draw_rectangle(525, 115, 545, 132, false);
draw_set_color(make_color_rgb(255, 215, 90));
draw_line_width(528, 128, 542, 118, 2); // Simbol pedang
// Tong Logam & Anvil Luar di Depan Toko
draw_set_color(make_color_rgb(60, 65, 75));
draw_roundrect_ext(455, 140, 470, 155, 2, 2, false);

// Gedung Timur: Apotek Herbal Elysia (x: 735..835, y: 55..155)
// Fasad Cottage Kayu dengan Pintu Hijau dari sTile_Timber (128, 48, 96, 80)
draw_sprite_part(sTile_Timber, 0, 128, 48, 96, 80, 725, 75);
// Plang Botol Ramuan Apotek Elysia
draw_set_color(make_color_rgb(95, 60, 35));
draw_rectangle(740, 115, 760, 132, false);
draw_set_color(make_color_rgb(80, 240, 180));
draw_circle(750, 125, 4, false); // Simbol ramuan
// Kotak Bunga & Pot Tanaman Obat di Luar Toko
draw_set_color(make_color_rgb(130, 85, 45));
draw_rectangle(805, 145, 830, 155, false);
draw_set_color(make_color_rgb(255, 140, 180));
draw_circle(812, 144, 3, false);
draw_circle(822, 143, 3, false);

// Gerbang Utara: Masuk ke Kamar Sestrina / Manor Kerajaan (x=640, y=85)
draw_set_color(make_color_rgb(65, 50, 40));
draw_roundrect_ext(_cx - 45, 40, _cx + 45, 85, 6, 6, false);
// Atap Kanopi Kayu Gerbang
draw_set_color(make_color_rgb(165, 55, 65));
draw_rectangle(_cx - 42, 42, _cx + 42, 54, false);
draw_set_color(make_color_rgb(255, 215, 90));
draw_rectangle(_cx - 42, 52, _cx + 42, 55, false);
// Gapura Pintu Masuk
draw_set_color(make_color_rgb(30, 20, 15));
draw_roundrect_ext(_cx - 24, 55, _cx + 24, 88, 4, 4, false);
draw_set_color(make_color_rgb(255, 230, 140));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_cx, 50, "Mansion Sestrina");

// 5. Air Mancur Batu Megah di Pusat Alun-Alun (Central Masterpiece Fountain)
// Kolam Batu Bertingkat (Stone Fountain Basin)
draw_set_color(make_color_rgb(70, 75, 85));
draw_circle(_cx, _cy, 46, false);
draw_set_color(make_color_rgb(120, 125, 140));
draw_circle(_cx, _cy, 46, true);
draw_set_color(make_color_rgb(90, 95, 105));
draw_circle(_cx, _cy, 44, true);

// Air Biru Beriak (Deep Azure Fountain Water)
draw_set_color(make_color_rgb(45, 130, 200));
draw_circle(_cx, _cy, 40, false);
draw_set_color(make_color_rgb(85, 180, 240));
draw_circle(_cx, _cy, 36, false);

// Pilar Air Mancur Tengah & Muncratan Air
draw_set_color(make_color_rgb(60, 65, 75));
draw_circle(_cx, _cy, 12, false);
draw_set_color(make_color_rgb(140, 145, 160));
draw_circle(_cx, _cy, 10, false);
draw_set_color(make_color_rgb(220, 245, 255));
draw_circle(_cx, _cy, 5, false);

// Partikel Kilau Air Beranimasi (sWaterSparkles)
var _spk_frame = (current_time div 140) mod 4;
draw_sprite(sWaterSparkles, _spk_frame, _cx - 18, _cy - 14);
draw_sprite(sWaterSparkles, (_spk_frame + 1) mod 4, _cx + 18, _cy + 12);
draw_sprite(sWaterSparkles, (_spk_frame + 2) mod 4, _cx - 14, _cy + 18);
draw_sprite(sWaterSparkles, (_spk_frame + 3) mod 4, _cx + 16, _cy - 16);

// Daun Teratai (Lily Pads) Mengapung di Kolam
draw_set_color(make_color_rgb(60, 150, 70));
draw_circle(_cx - 24, _cy + 6, 4, false);
draw_circle(_cx + 22, _cy - 8, 4.5, false);

// 6. Pepohonan Rindang, Semak Berbunga & Suasana Alun-Alun
// Pohon Oak Rimbun Mana Seed di Sisi Barat Daya (x: 450, y: 310)
draw_sprite_part(sTile_Summer, 0, 176, 0, 80, 112, 445, 260);

// Semak Belukar Hijau Berbunga (dari sTile_Summer 16, 128)
draw_sprite_part(sTile_Summer, 0, 16, 128, 32, 32, _x1 + 10, 420);
draw_sprite_part(sTile_Summer, 0, 16, 128, 32, 32, _x2 - 42, 420);
draw_sprite_part(sTile_Summer, 0, 16, 128, 32, 32, _x2 - 42, 260);

// Kios Dagang / Gerobak Pasar Tradisional di Barat Alun-Alun
draw_set_color(make_color_rgb(115, 80, 48));
draw_roundrect_ext(490, 430, 535, 470, 4, 4, false);
// Tenda Kanopi Belang Merah-Putih
for (var _sx = 490; _sx < 535; _sx += 9) {
    draw_set_color((((_sx - 490) div 9) mod 2 == 0) ? make_color_rgb(220, 50, 60) : make_color_rgb(245, 245, 250));
    draw_rectangle(_sx, 420, min(535, _sx + 9), 432, false);
}
// Keranjang Apel Merah & Gandum di Kios
draw_set_color(make_color_rgb(130, 90, 50));
draw_circle(502, 445, 6, false);
draw_circle(522, 445, 6, false);
draw_set_color(make_color_rgb(230, 50, 50));
draw_circle(502, 443, 4, false); // Apel
draw_set_color(make_color_rgb(240, 210, 120));
draw_circle(522, 443, 4, false); // Gandum

// Bangku Kayu Taman untuk Warga Beristirahat di Timur
draw_set_color(make_color_rgb(110, 75, 45));
draw_roundrect_ext(750, 440, 785, 460, 3, 3, false);
draw_set_color(make_color_rgb(145, 105, 65));
draw_line_width(752, 444, 783, 444, 2);
draw_line_width(752, 452, 783, 452, 2);

// Tiang Lampu Jalan Besi Tempa (Street Lanterns) dengan Cahaya Hangat
var _draw_lamp_post = function(_lx, _ly) {
    var _glow = 0.75 + sin(current_time * 0.007 + _lx) * 0.25;
    // Cahaya Ambient Kuning
    draw_set_alpha(0.22 * _glow);
    draw_set_color(make_color_rgb(255, 215, 100));
    draw_circle(_lx, _ly, 32, false);
    draw_set_alpha(1.0);
    // Tiang Besi
    draw_set_color(make_color_rgb(45, 48, 55));
    draw_line_width(_lx, _ly, _lx, _ly + 22, 2);
    // Lentera Kuningan
    draw_set_color(make_color_rgb(180, 140, 60));
    draw_roundrect_ext(_lx - 4, _ly - 8, _lx + 4, _ly, 2, 2, false);
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_circle(_lx, _ly - 4, 2.5, false);
};

_draw_lamp_post(_cx - 50, 200);
_draw_lamp_post(_cx + 50, 200);
_draw_lamp_post(_cx - 50, 510);
_draw_lamp_post(_cx + 50, 510);

// Guci-Guci Hias dari sBreakablePots
draw_sprite(sBreakablePots, 0, 545, 175);
draw_sprite(sBreakablePots, 0, 735, 175);

// 7. Papan Pengumuman Kerajaan (Notice Board di x=570, y=520)
// Dipercantik dengan atap sirap kayu dan kertas gulungan
draw_set_color(make_color_rgb(95, 60, 35));
draw_roundrect_ext(545, 492, 595, 532, 4, 4, false);
draw_set_color(make_color_rgb(145, 95, 55));
draw_roundrect_ext(543, 488, 597, 496, 2, 2, false); // Atap pelindung
draw_set_color(make_color_rgb(70, 42, 24));
draw_line_width(552, 532, 552, 548, 3); // Tiang kaki kiri
draw_line_width(588, 532, 588, 548, 3); // Tiang kaki kanan
// Kertas Pengumuman Tertempel
draw_set_color(make_color_rgb(245, 235, 210));
draw_rectangle(550, 500, 568, 518, false);
draw_rectangle(572, 502, 590, 522, false);
draw_set_color(make_color_rgb(200, 40, 40)); // Segel lilin merah
draw_circle(559, 504, 2, false);
draw_circle(581, 506, 2, false);

// 8. Gerbang Keluar Selatan Menuju Hutan (x=640, y=665)
var _gt_y = _y2 - 12;
draw_set_color(make_color_rgb(60, 42, 28));
draw_roundrect_ext(_cx - 40, _gt_y - 12, _cx + 40, _y2, 4, 4, false);
draw_set_color(make_color_rgb(195, 160, 80));
draw_line_width(_cx - 36, _gt_y - 2, _cx + 36, _gt_y - 2, 3);
draw_set_color(make_color_rgb(140, 220, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_cx, _gt_y - 16, "▼ GERBANG KOTA SELATAN");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
