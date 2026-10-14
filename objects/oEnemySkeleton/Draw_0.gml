/// @description Draw Event - Render Ksatria Tengkorak Mana Seed Sprite

event_inherited(); // HP Bar

// Bayangan Karakter
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// Render Sprite Ksatria Tengkorak
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// Mata Merah Tengkorak Bersinar
draw_set_color(make_color_rgb(255, 60, 60));
draw_circle(x - 2, y - 8, 1.5, false);
draw_circle(x + 3, y - 8, 1.5, false);
draw_set_color(c_white);
