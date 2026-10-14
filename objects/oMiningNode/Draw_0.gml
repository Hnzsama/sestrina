/// @description Draw Event - Render Bongkahan Tambang & Vena Mineral

var _ox = (shake_timer > 0) ? irandom_range(-2, 2) : 0;
var _oy = (shake_timer > 0) ? irandom_range(-1, 1) : 0;

// Bayangan tanah
draw_set_alpha(0.4);
draw_set_color(c_black);
draw_ellipse(x - 16, y + 2, x + 16, y + 12, false);
draw_set_alpha(1.0);

// Badan batu utama
var _base_col = is_depleted ? make_color_rgb(70, 75, 85) : make_color_rgb(95, 100, 115);
draw_set_color(_base_col);
draw_roundrect_ext(x - 14 + _ox, y - 20 + _oy, x + 14 + _ox, y + 6 + _oy, 10, 10, false);
draw_set_color(make_color_rgb(45, 50, 60));
draw_roundrect_ext(x - 14 + _ox, y - 20 + _oy, x + 14 + _ox, y + 6 + _oy, 10, 10, true);

// Vena Kristal / Bijih jika belum habis
if (!is_depleted) {
    if (ore_type == "iron_ore") {
        draw_set_color(make_color_rgb(225, 160, 85)); // Urat bijih besi keemasan
        draw_circle(x - 4 + _ox, y - 10 + _oy, 3.5, false);
        draw_circle(x + 5 + _ox, y - 6 + _oy, 2.5, false);
        draw_circle(x + 2 + _ox, y - 14 + _oy, 3.0, false);
        draw_set_color(make_color_rgb(255, 210, 130));
        draw_point(x - 4 + _ox, y - 11 + _oy);
    } else {
        // Kristal Mana Ungu / Biru Neon
        draw_set_color(make_color_rgb(175, 110, 255));
        draw_triangle(x - 5 + _ox, y - 8 + _oy, x - 1 + _ox, y - 18 + _oy, x + 2 + _ox, y - 8 + _oy, false);
        draw_set_color(make_color_rgb(110, 190, 255));
        draw_triangle(x + 1 + _ox, y - 6 + _oy, x + 6 + _ox, y - 15 + _oy, x + 9 + _ox, y - 6 + _oy, false);
    }
}

draw_set_color(c_white);

// Gambar prompt teks bawaan interactable parent jika pemain mendekat
event_inherited();
