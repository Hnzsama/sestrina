/// @description Draw Event oBedroomDecor (Medieval Fantasy Bedroom Lighting & Effects)

// 1. Gambar Master Composed Room Sprite (jika background layer tidak aktif)
if (sprite_exists(sBedroom_Diorama)) {
    draw_sprite(sBedroom_Diorama, 0, 0, 0);
}

// 2. Pijar Lilin Meja Nakas Sestrina (Nightstand Candle Flame: x: 279, y: 220)
var _c1_pulse = sin(current_time * 0.012);
draw_set_alpha(0.22 + 0.08 * _c1_pulse);
draw_set_color(make_color_rgb(255, 175, 65));
draw_circle(279, 220, 16 + _c1_pulse * 2, false);
draw_set_alpha(0.70 + 0.15 * _c1_pulse);
draw_set_color(make_color_rgb(255, 240, 150));
draw_circle(279, 220, 5 + _c1_pulse, false);

// 3. Pijar Lilin Meja Belajar Utama (Master Study Desk Candle Flame: x: 676, y: 204)
var _c2_pulse = sin((current_time + 400) * 0.014);
draw_set_alpha(0.20 + 0.08 * _c2_pulse);
draw_set_color(make_color_rgb(255, 170, 60));
draw_circle(676, 204, 16 + _c2_pulse * 2, false);
draw_set_alpha(0.70 + 0.15 * _c2_pulse);
draw_set_color(make_color_rgb(255, 235, 140));
draw_circle(676, 204, 5 + _c2_pulse, false);

// 4. Pijar Kandelabra 3-Lilin Dresser Sayap Barat (x: 290, y: 513)
var _c3_pulse = sin((current_time + 800) * 0.013);
draw_set_alpha(0.20 + 0.07 * _c3_pulse);
draw_set_color(make_color_rgb(255, 170, 65));
draw_circle(290, 513, 18 + _c3_pulse * 2, false);
draw_set_alpha(0.68 + 0.14 * _c3_pulse);
draw_set_color(make_color_rgb(255, 240, 150));
draw_circle(285, 513, 3.5, false);
draw_circle(290, 509, 3.5, false);
draw_circle(295, 513, 3.5, false);

// 4.5. Pijar Lembut Lampu Dinding Sconce (Wall Sconces: x: 450, 580, 700, 830, y: 105)
var _sc_pulse = sin((current_time + 200) * 0.010);
draw_set_alpha(0.12 + 0.04 * _sc_pulse);
draw_set_color(make_color_rgb(255, 180, 75));
draw_circle(450, 105, 12, false);
draw_circle(580, 105, 12, false);
draw_circle(700, 105, 12, false);
draw_circle(830, 105, 12, false);

// 5. Pijar Lentera Kaca Pintu Masuk (Entrance Lanterns: x: 578 & 702, y: 641)
var _l_pulse = sin(current_time * 0.008);
draw_set_alpha(0.16 + 0.05 * _l_pulse);
draw_set_color(make_color_rgb(255, 190, 80));
draw_circle(578, 641, 18, false);
draw_circle(702, 641, 18, false);
draw_set_alpha(0.70 + 0.15 * _l_pulse);
draw_set_color(make_color_rgb(255, 240, 170));
draw_circle(578, 641, 4.5, false);
draw_circle(702, 641, 4.5, false);

// 6. Berkas Cahaya Mentari Pagi Lembut dari 2 Jendela Kamar (x: 515 & 765)
var _sun_pulse = sin(current_time * 0.002);
// Jendela Tirai Merah (Barat: x: 515, y: 115)
draw_set_alpha(0.06 + 0.02 * _sun_pulse);
draw_set_color(make_color_rgb(255, 240, 200));
draw_triangle(500, 115, 530, 115, 610, 330, false);
draw_triangle(500, 115, 610, 330, 550, 330, false);

// Jendela Tirai Biru (Timur: x: 765, y: 115)
draw_set_alpha(0.05 + 0.02 * _sun_pulse);
draw_set_color(make_color_rgb(215, 235, 255));
draw_triangle(750, 115, 780, 115, 860, 330, false);
draw_triangle(750, 115, 860, 330, 800, 330, false);

// 7. Plang Penunjuk Pintu Keluar ke Altdorf
var _door_x = 640;
var _door_y = 638;
var _dr_pulse = sin(current_time * 0.005);
draw_set_alpha(0.88);
draw_set_color(make_color_rgb(22, 32, 48));
draw_roundrect_ext(_door_x - 70, _door_y - 20 + _dr_pulse * 2, _door_x + 70, _door_y + 2 + _dr_pulse * 2, 6, 6, false);
draw_set_color(make_color_rgb(110, 175, 235));
draw_roundrect_ext(_door_x - 70, _door_y - 20 + _dr_pulse * 2, _door_x + 70, _door_y + 2 + _dr_pulse * 2, 6, 6, true);
draw_set_color(make_color_rgb(255, 235, 160));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_door_x, _door_y - 9 + _dr_pulse * 2, "▼ Ke Kota Altdorf");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
