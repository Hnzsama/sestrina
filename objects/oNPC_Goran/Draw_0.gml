/// @description Draw Event - Render Pandai Besi Goran Mana Seed Sprite

anim_timer += 0.06;
var _hammer_swing = sin(anim_timer * 3.0) * 10;

// Bayangan Karakter
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// Gambar Karakter Sprite Mana Seed
draw_self();

// Palu Tempa di Samping Goran
draw_set_color(make_color_rgb(110, 60, 30));
draw_roundrect_ext(x + 10, y - 8, x + 14, y + 4, 2, 2, false);
draw_set_color(make_color_rgb(70, 75, 85));
draw_rectangle(x + 8, y - 14 + _hammer_swing, x + 16, y - 8 + _hammer_swing, false);
draw_set_color(c_white);

// Floating prompt inherited
event_inherited();
