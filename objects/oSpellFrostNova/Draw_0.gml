/// @description Draw Event - Kristal Es Radial

var _alpha = duration / 18;
draw_set_alpha(_alpha * 0.8);
draw_set_color(make_color_rgb(90, 210, 255));
draw_circle(x, y, current_radius, true);
draw_set_alpha(_alpha * 0.4);
draw_set_color(make_color_rgb(170, 240, 255));
draw_circle(x, y, current_radius * 0.8, false);

// Paku-paku kristal es
for (var _ang = 0; _ang < 360; _ang += 45) {
    var _px = x + lengthdir_x(current_radius, _ang);
    var _py = y + lengthdir_y(current_radius, _ang);
    draw_set_color(make_color_rgb(220, 255, 255));
    draw_line_width(x, y, _px, _py, 2);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
