/// @description Draw Event - Render Kapten Alden Mana Seed Sprite

anim_timer += 0.05;

// Bayangan Karakter Grounded
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// Gambar Karakter Sprite Mana Seed
draw_self();

// Tombak Halberd Kesatria Emas Baja di Samping Kapten
draw_set_color(make_color_rgb(110, 70, 40));
draw_line_width(x + 13, y - 28, x + 13, y + 8, 2.5);
draw_set_color(make_color_rgb(235, 240, 250));
draw_triangle(x + 9, y - 28, x + 17, y - 28, x + 13, y - 40, false);
draw_triangle(x + 13, y - 28, x + 21, y - 24, x + 13, y - 20, false); // Bilah Kapak
draw_set_color(make_color_rgb(225, 190, 70));
draw_circle(x + 13, y - 28, 3, false); // Cincin Pengikat Emas
draw_set_color(c_white);

// Floating prompt inherited
event_inherited();
