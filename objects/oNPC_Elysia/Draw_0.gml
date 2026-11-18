/// @description Draw Event - Render Alkemis Elysia Mana Seed Sprite

anim_timer += 0.05;
var _float = sin(anim_timer * 2.0) * 2;

// Bayangan Karakter Grounded
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// Gambar Karakter Sprite Mana Seed
draw_self();

// Botol Ramuan Berpendar di Tangan Elysia
draw_set_color(make_color_rgb(120, 245, 200));
draw_circle(x + 12, y - 4 + _float, 4, false);
draw_set_color(c_white);
// Story Bubble Indicator di atas kepala Elysia jika quest persiapan aktif
if (global.quest_stage == 1 && global.player_potions < 2) {
    var _sb_y = y - 56 + sin(current_time * 0.005) * 3;
    draw_set_alpha(0.95);
    draw_set_color(c_white);
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, false);
    draw_set_color(make_color_rgb(70, 110, 190));
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, true);
    
    // Bubble pointer
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

// Floating prompt inherited
event_inherited();
