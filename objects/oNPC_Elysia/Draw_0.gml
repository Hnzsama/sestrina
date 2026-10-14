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
draw_circle(x + 11, y - 5 + _float, 1.5, false);

// Floating prompt inherited
event_inherited();
