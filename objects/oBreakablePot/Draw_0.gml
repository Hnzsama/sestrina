/// @description Draw Event oBreakablePot

if (!is_broken) {
    // Bayangan Guci Utuh
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_ellipse(x - 8, y + 8, x + 8, y + 14, false);
    draw_set_alpha(1.0);
}

draw_self();
