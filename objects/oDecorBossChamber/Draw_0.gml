/// @description Draw Event oDecorBossChamber (The Forgotten Sanctum of Dark Crystal Overlord)

var _acx = 640;
var _acy = 448;

// 1. Latar Belakang Jurang Kehampaan Kosmik (Deep Cosmic Abyss)
draw_set_color(make_color_rgb(10, 6, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// Nebula Aura Lembayung di Luar Arena
draw_set_alpha(0.06);
draw_set_color(make_color_rgb(85, 25, 120));
draw_circle(200, 220, 180, false);
draw_circle(1080, 220, 220, false);
draw_set_alpha(0.04);
draw_circle(280, 520, 140, false);
draw_circle(1000, 520, 140, false);
draw_set_alpha(1.0);

// 2. Bayangan Jurang di Bawah Platform Melingkar (Abyss Drop Shadow)
draw_set_alpha(0.65);
draw_set_color(c_black);
draw_ellipse(_acx - 390, 685 - 90, _acx + 390, 685 + 20, false);
draw_set_alpha(0.3);
draw_ellipse(_acx - 420, 685 - 120, _acx + 420, 685 + 35, false);
draw_set_alpha(1.0);

// 3. Render Diorama Arena Bos Melingkar Megah (sBossArena_Diorama 818x662)
draw_sprite(sBossArena_Diorama, 0, 231, 23);

// 4. Pendaran Dinamis Kristal & Api Ungu
// A. Lingkaran Sihir Pemanggilan di Pusat Arena (x: 640, y: 448)
var _seal_pulse = 0.8 + sin(rune_glow * 1.5) * 0.2;
draw_set_alpha(0.12 * _seal_pulse);
draw_set_color(make_color_rgb(175, 65, 255));
draw_ellipse(_acx - 140, _acy - 80, _acx + 140, _acy + 80, false);
draw_set_alpha(0.25 * _seal_pulse);
draw_ellipse(_acx - 90, _acy - 50, _acx + 90, _acy + 50, false);
draw_set_alpha(0.45 * _seal_pulse);
draw_ellipse(_acx - 45, _acy - 25, _acx + 45, _acy + 25, false);
draw_set_alpha(1.0);

// B. Aura Kegelapan Singgasana Atas (x: 640, y: 175)
var _throne_pulse = 0.85 + sin(rune_glow * 2.0) * 0.15;
draw_set_alpha(0.18 * _throne_pulse);
draw_set_color(make_color_rgb(210, 60, 255));
draw_ellipse(_acx - 100, 175 - 70, _acx + 100, 175 + 70, false);
draw_set_alpha(0.35 * _throne_pulse);
draw_ellipse(_acx - 60, 175 - 40, _acx + 60, 175 + 40, false);
draw_set_alpha(1.0);

// C. Pendaran Kristal Sian Raksasa di Dinding Kiri (x: 345, y: 270) & Kanan (x: 935, y: 270)
var _cryst_pulse = 0.85 + sin(rune_glow * 1.8) * 0.15;
draw_set_alpha(0.20 * _cryst_pulse);
draw_set_color(make_color_rgb(60, 210, 255));
draw_circle(345, 270, 85, false);
draw_circle(935, 270, 85, false);
draw_set_alpha(0.40 * _cryst_pulse);
draw_circle(345, 270, 45, false);
draw_circle(935, 270, 45, false);
draw_set_alpha(1.0);

// D. Obor Api Ungu di Undakan Gerbang Selatan (x: 485, y: 560) & (x: 795, y: 560)
var _f_pulse = 0.8 + sin(flame_anim * 2.5) * 0.2;
draw_set_alpha(0.22 * _f_pulse);
draw_set_color(make_color_rgb(195, 75, 255));
draw_circle(485, 560, 45, false);
draw_circle(795, 560, 45, false);
draw_set_alpha(0.55 * _f_pulse);
draw_circle(485, 560, 18, false);
draw_circle(795, 560, 18, false);
draw_set_alpha(1.0);

// 5. ADEGAN KEMENANGAN: PILAR CAHAYA SUCI SETELAH BOS DIKALAHKAN
var _boss_defeated = (variable_global_exists("player_has_remedy") && global.player_has_remedy) || !instance_exists(oBossGolem);
if (_boss_defeated) {
    // Berkas Cahaya Suci Vertikal dari Altar Singgasana (x: 640, y: 210)
    var _b_pulse = 0.75 + sin(portal_anim * 3.0) * 0.25;
    draw_set_alpha(0.4 * _b_pulse);
    draw_set_color(make_color_rgb(255, 245, 180));
    draw_rectangle(640 - 24, 0, 640 + 24, 230, false);
    draw_set_alpha(0.7 * _b_pulse);
    draw_set_color(c_white);
    draw_rectangle(640 - 10, 0, 640 + 10, 230, false);
    
    // Suaka Portal Emas Berpendar
    draw_set_alpha(0.5 * _b_pulse);
    draw_set_color(make_color_rgb(255, 215, 100));
    draw_ellipse(640 - 45, 215 - 16, 640 + 45, 215 + 16, false);
    draw_set_alpha(1.0);
    
    // Label Portal Suci
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 240, 160));
    draw_text(640, 140, "✦ PORTAL SUCI FORGOTTEN SANCTUM ✦");
    draw_set_color(make_color_rgb(255, 255, 220));
    draw_text(640, 160, "[TEKAN E UNTUK KEMBALI KE KAMAR SESTRINA]");
}

// 6. Label Navigasi Gerbang Bawah
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
if (!_boss_defeated) {
    draw_set_color(make_color_rgb(255, 100, 100));
    draw_text(640, 705, "☠ GERBANG TERSEGEL AURA DARK CRYSTAL OVERLORD ☠");
} else {
    draw_set_color(make_color_rgb(240, 210, 140));
    draw_text(640, 705, "▼ KEMBALI KE LANTAI 2 (GUA KRISTAL)");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
