/// @description Draw Event oTreasureChest

// Bayangan Peti
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 8, x + 12, y + 16, false);
draw_set_alpha(1.0);

draw_self();

event_inherited(); // Prompt [E] jika pemain dekat
