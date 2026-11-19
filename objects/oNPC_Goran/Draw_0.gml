/// @description Draw Event - Render Goran Workshop & Party Recruitment Indicator

// Jika Goran sudah direkrut ke party, dia bertualang bersama pemain sebagai oCompanion_Goran
if (variable_global_exists("party_goran") && global.party_goran) {
    // Tampilkan plakat mini kayu di konter
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(45, 30, 20));
    draw_roundrect_ext(x - 55, y - 8, x + 55, y + 10, 4, 4, false);
    draw_set_color(make_color_rgb(190, 150, 70));
    draw_roundrect_ext(x - 55, y - 8, x + 55, y + 10, 4, 4, true);
    
    draw_set_color(make_color_rgb(240, 225, 180));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(x, y + 1, "Goran Ikut Bertualang", 0.85, 0.85, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1.0);
    exit;
}

anim_timer += 0.05;

// Animasi bergantian antara Menempa di Anvil & Berjaga di Konter
var _player_near = (instance_exists(oPlayer) && distance_to_object(oPlayer) < 80);

if (_player_near) {
    sprite_index = sGoran_Workshop_Idle;
    image_speed = 0.08;
    image_xscale = (oPlayer.x < x) ? -1.0 : 1.0;
} else {
    // Saat pemain belum mendekat, Goran sibuk menempa bilah pedang di landasan
    sprite_index = sGoran_Workshop_Hammering;
    image_speed = 0.12;
    image_xscale = 1.0;
}

// 1. Bayangan Karakter Goran
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 14, y + 10, x + 14, y + 18, false);
draw_set_alpha(1.0);

// 2. Gambar Sprite Animasi Goran Asli dari Asset Pack
draw_self();

// 3. Indikator Balon Cerita / Party Recruitment di Atas Kepala Goran
if (global.has_boss_key && !global.party_goran) {
    // Indikator Emas Rekrut Party
    var _pb_y = y - 56 + sin(current_time * 0.006) * 4;
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(25, 20, 35));
    draw_roundrect_ext(x - 42, _pb_y - 12, x + 42, _pb_y + 6, 8, 8, false);
    draw_set_color(make_color_rgb(255, 215, 60));
    draw_roundrect_ext(x - 42, _pb_y - 12, x + 42, _pb_y + 6, 8, 8, true);
    
    // Bubble pointer
    draw_set_color(make_color_rgb(255, 215, 60));
    draw_triangle(x - 5, _pb_y + 6, x + 5, _pb_y + 6, x, _pb_y + 11, false);
    
    draw_set_color(make_color_rgb(255, 230, 100));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, _pb_y - 3, "REKRUT PARTY!");
} else if (global.quest_stage == 1 && !global.player_has_sword) {
    var _sb_y = y - 56 + sin(current_time * 0.005) * 3;
    draw_set_alpha(0.95);
    draw_set_color(c_white);
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, false);
    draw_set_color(make_color_rgb(70, 110, 190));
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, true);
    
    draw_set_color(c_white);
    draw_triangle(x - 4, _sb_y + 4, x + 4, _sb_y + 4, x, _sb_y + 9, false);
    
    draw_set_color(make_color_rgb(30, 45, 90));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, _sb_y - 4, "Story");
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Floating prompt inherited "[Z] Tempa dgn Goran"
event_inherited();
