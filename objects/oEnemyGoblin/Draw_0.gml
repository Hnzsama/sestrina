/// @description Draw Event - Render Goblin Rogue

event_inherited(); // HP Bar

// Bayangan Karakter
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 11, y + 8, x + 11, y + 16, false);
draw_set_alpha(1.0);

// Facing direction disesuaikan posisi player
if (instance_exists(oPlayer)) {
    if (oPlayer.x < x) {
        image_xscale = -1.35;
    } else {
        image_xscale = 1.35;
    }
}

// Render Sprite Goblin
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// Kilauan Mata Kuning Licik Goblin
draw_set_color(make_color_rgb(255, 230, 60));
var _sign = (image_xscale > 0) ? 1 : -1;
draw_circle(x + _sign * 2, y - 6, 1.2, false);
draw_set_color(c_white);
