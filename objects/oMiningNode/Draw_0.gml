/// @description Draw Event - Render Bongkahan Tambang & Vena Mineral Realistis

var _ox = (shake_timer > 0) ? irandom_range(-2, 2) : 0;
var _oy = (shake_timer > 0) ? irandom_range(-1, 1) : 0;
var _bx = x + _ox;
var _by = y + _oy;

// 1. Bayangan Tebal di Bawah Bongkahan Batu
draw_set_alpha(0.45);
draw_set_color(c_black);
draw_ellipse(_bx - 20, _by + 2, _bx + 20, _by + 14, false);
draw_set_alpha(1.0);

// 2. Badan Batu Mineral Bertingkat (Faceted Rocky Crag)
var _c_dark = is_depleted ? make_color_rgb(50, 54, 62) : make_color_rgb(68, 72, 82);
var _c_mid  = is_depleted ? make_color_rgb(72, 78, 88) : make_color_rgb(98, 105, 118);
var _c_lite = is_depleted ? make_color_rgb(95, 102, 115) : make_color_rgb(130, 138, 154);

// Sisi Bayangan Bawah & Kiri Batu
draw_set_color(_c_dark);
draw_triangle(_bx - 18, _by + 6, _bx - 12, _by - 18, _bx, _by + 8, false);
draw_triangle(_bx, _by + 8, _bx + 14, _by + 6, _bx + 8, _by - 12, false);

// Sisi Muka Tengah Batu
draw_set_color(_c_mid);
draw_triangle(_bx - 12, _by - 18, _bx + 2, _by - 24, _bx, _by + 4, false);
draw_triangle(_bx + 2, _by - 24, _bx + 16, _by - 10, _bx + 12, _by + 4, false);

// Facet Puncak Terkena Cahaya Matahari (Top Highlight Facets)
draw_set_color(_c_lite);
draw_triangle(_bx - 8, _by - 20, _bx + 2, _by - 24, _bx - 2, _by - 12, false);
draw_triangle(_bx - 2, _by - 12, _bx + 2, _by - 24, _bx + 10, _by - 16, false);

// Garis Retakan & Kontur Batu Alami (Chiseled Rock Edges)
draw_set_color(make_color_rgb(38, 42, 50));
draw_line(_bx - 12, _by - 18, _bx - 2, _by - 12);
draw_line(_bx - 2, _by - 12, _bx + 2, _by - 24);
draw_line(_bx - 2, _by - 12, _bx + 1, _by + 4);
draw_line(_bx + 1, _by + 4, _bx + 12, _by + 4);

// Lumut Liar Hijau di Punggung Batu
draw_set_color(make_color_rgb(85, 128, 55));
draw_circle(_bx - 9, _by - 19, 2.2, false);
draw_circle(_bx - 6, _by - 21, 1.8, false);
draw_circle(_bx + 6, _by - 20, 2.0, false);

// 3. Vena Kristal Bijih Logam Berkilau (Ore Veins)
if (!is_depleted) {
    if (ore_type == "iron_ore") {
        // Bijih Besi Emas Berkilau (Raw Pyrite / Gold-Iron Ore)
        var _glow = 0.85 + sin((current_time + x * 10) * 0.006) * 0.15;
        draw_set_color(make_color_rgb(240, 165, 60)); // Amber emas hangat
        draw_circle(_bx - 4, _by - 8, 3.2, false);
        draw_circle(_bx + 6, _by - 4, 2.8, false);
        draw_circle(_bx + 1, _by - 14, 3.0, false);
        draw_circle(_bx - 9, _by - 2, 2.2, false);
        
        // Inti Kristal Terang
        draw_set_color(make_color_rgb(255, 235, 160));
        draw_circle(_bx - 4, _by - 9, 1.8, false);
        draw_circle(_bx + 6, _by - 5, 1.5, false);
        draw_circle(_bx + 1, _by - 15, 1.6, false);
        
        // Kilatan Cahaya Bintang Beranimasi
        if ((current_time div 400 + x) mod 4 == 0) {
            draw_set_color(c_white);
            draw_point(_bx - 4, _by - 9);
            draw_point(_bx + 1, _by - 15);
        }
    } else {
        // Kristal Mana Ungu / Cyan Mistis Bercahaya
        draw_set_color(make_color_rgb(170, 90, 255));
        draw_triangle(_bx - 7, _by - 4, _bx - 2, _by - 18, _bx + 1, _by - 4, false);
        draw_set_color(make_color_rgb(100, 215, 255));
        draw_triangle(_bx + 1, _by - 2, _bx + 7, _by - 15, _bx + 11, _by - 2, false);
        
        // Puncak Berkilau Kristal
        draw_set_color(make_color_rgb(240, 245, 255));
        draw_line(_bx - 2, _by - 18, _bx - 3, _by - 12);
        draw_line(_bx + 7, _by - 15, _bx + 6, _by - 9);
    }
}

draw_set_color(c_white);

// Prompt teks interaksi saat pemain mendekat
event_inherited();
