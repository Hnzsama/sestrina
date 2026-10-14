/// @description Draw Event - Render Slime Beracun Mana Seed Sprite

event_inherited(); // Gambar HP bar jika terluka

// Bayangan Slime
draw_set_alpha(0.3);
draw_set_color(c_black);
draw_ellipse(x - 14, y + 6, x + 14, y + 14, false);
draw_set_alpha(1.0);

// Render Sprite Slime Mana Seed
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}
