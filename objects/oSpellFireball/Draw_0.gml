/// @description Draw Event - Efek Visual Bola Api & Ledakan

if (!is_exploded) {
    // Inti api berpijar
    draw_set_color(make_color_rgb(255, 120, 30));
    draw_circle(x, y, 7, false);
    draw_set_color(make_color_rgb(255, 230, 80));
    draw_circle(x, y, 4, false);
    
    // Ekor api
    var _tx = x - lengthdir_x(8, fire_dir);
    var _ty = y - lengthdir_y(8, fire_dir);
    draw_set_color(make_color_rgb(255, 70, 20));
    draw_circle(_tx, _ty, 4, false);
} else {
    // Lingkaran ledakan api membuncah
    var _progress = (12 - explode_timer) / 12;
    var _r = explode_radius * _progress;
    draw_set_alpha(1.0 - _progress);
    draw_set_color(make_color_rgb(255, 140, 20));
    draw_circle(x, y, _r, false);
    draw_set_color(make_color_rgb(255, 240, 100));
    draw_circle(x, y, _r * 0.6, false);
    draw_set_alpha(1.0);
}
draw_set_color(c_white);
