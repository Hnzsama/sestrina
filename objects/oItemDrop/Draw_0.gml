/// @description Draw Event - Render Item Drop Berkilau

var _float_y = y + sin(float_timer) * 3 + z;

// Bayangan di tanah
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 6, y + 2, x + 6, y + 6, false);
draw_set_alpha(1.0);

// Gambar representasi visual sesuai item_type
switch (item_type) {
    case "gold":
        draw_set_color(make_color_rgb(255, 215, 0));
        draw_circle(x, _float_y, 5, false);
        draw_set_color(make_color_rgb(200, 150, 0));
        draw_circle(x, _float_y, 5, true);
        draw_set_color(c_white);
        draw_point(x - 1, _float_y - 1);
        break;
        
    case "slime_jelly":
        draw_set_color(make_color_rgb(60, 230, 90));
        draw_circle(x, _float_y, 6, false);
        draw_set_color(make_color_rgb(20, 160, 50));
        draw_circle(x, _float_y, 6, true);
        draw_set_color(make_color_rgb(180, 255, 190));
        draw_circle(x - 2, _float_y - 2, 2, false);
        break;
        
    case "bone_shard":
        draw_set_color(make_color_rgb(230, 225, 210));
        draw_triangle(x - 4, _float_y + 4, x, _float_y - 5, x + 4, _float_y + 4, false);
        draw_set_color(make_color_rgb(150, 140, 130));
        draw_triangle(x - 4, _float_y + 4, x, _float_y - 5, x + 4, _float_y + 4, true);
        break;
        
    case "scrap_iron":
        draw_set_color(make_color_rgb(160, 170, 185));
        draw_roundrect_ext(x - 5, _float_y - 4, x + 5, _float_y + 4, 3, 3, false);
        draw_set_color(make_color_rgb(90, 100, 115));
        draw_roundrect_ext(x - 5, _float_y - 4, x + 5, _float_y + 4, 3, 3, true);
        break;
        
    case "iron_ore":
        draw_set_color(make_color_rgb(130, 95, 75));
        draw_circle(x, _float_y, 6, false);
        draw_set_color(make_color_rgb(210, 150, 80));
        draw_circle(x + 1, _float_y - 1, 2, false);
        draw_set_color(make_color_rgb(70, 50, 40));
        draw_circle(x, _float_y, 6, true);
        break;
        
    case "magic_crystal":
        draw_set_color(make_color_rgb(140, 90, 255));
        draw_triangle(x, _float_y - 7, x - 5, _float_y + 1, x + 5, _float_y + 1, false);
        draw_triangle(x, _float_y + 7, x - 5, _float_y + 1, x + 5, _float_y + 1, false);
        draw_set_color(make_color_rgb(230, 190, 255));
        draw_circle(x, _float_y, 2, false);
        break;
        
    case "potion":
        draw_set_color(make_color_rgb(235, 50, 60));
        draw_circle(x, _float_y + 2, 5, false);
        draw_set_color(make_color_rgb(180, 140, 80));
        draw_rectangle(x - 2, _float_y - 5, x + 2, _float_y - 2, false);
        break;
}

draw_set_color(c_white);
