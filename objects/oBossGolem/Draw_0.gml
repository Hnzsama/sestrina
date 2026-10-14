/// @description Draw Event - Render Raksasa Golem Purba Mana Seed Sprite

anim_timer += 0.05;

// Bayangan Raksasa
draw_set_alpha(0.45);
draw_set_color(c_black);
draw_ellipse(x - 36, y + 14, x + 36, y + 30, false);

// Efek Shockwave Hentakan Kaki
if (is_stomping && stomp_shockwave_r > 0) {
    draw_set_alpha(0.6 * (1.0 - stomp_shockwave_r / 120));
    draw_set_color(make_color_rgb(255, 200, 80));
    draw_circle(x, y + 14, stomp_shockwave_r, true);
    draw_set_color(make_color_rgb(255, 120, 40));
    draw_circle(x, y + 14, stomp_shockwave_r - 2, true);
}

draw_set_alpha(1.0);

// Render Sprite Raksasa Golem Purba
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

draw_set_color(c_white);
