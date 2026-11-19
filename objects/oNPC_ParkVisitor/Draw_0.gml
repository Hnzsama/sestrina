/// @description Draw Event oNPC_ParkVisitor (Visual Khas Warga Kota Altdorf)

anim_timer += 0.04;
var _breathe = sin(anim_timer * 2.0);

// 1. Bayangan Karakter di Tanah
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// 2. Gambar Sprite Karakter Utama
draw_self();

// 3. Aksesori Khas Sesuai Peran Warga
switch (npc_role) {
    case "merchant":
        // Topi Jerami Pedagang Gandum & Buah
        draw_set_color(make_color_rgb(220, 185, 110));
        draw_ellipse(x - 14, y - 32 + _breathe, x + 14, y - 24 + _breathe, false);
        draw_set_color(make_color_rgb(180, 140, 75));
        draw_ellipse(x - 8, y - 36 + _breathe, x + 8, y - 28 + _breathe, false);
        // Apron Pedagang Hijau Zaitun
        draw_set_color(make_color_rgb(65, 120, 75));
        draw_roundrect_ext(x - 7, y - 8 + _breathe, x + 7, y + 6 + _breathe, 2, 2, false);
        break;

    case "guard_north":
        // Tombak Penjaga Kota Baja Berpucuk Emas
        draw_set_color(make_color_rgb(110, 70, 40));
        draw_line_width(x + 13, y - 28, x + 13, y + 8, 2.5);
        draw_set_color(make_color_rgb(220, 230, 245));
        draw_triangle(x + 9, y - 28, x + 17, y - 28, x + 13, y - 40, false);
        draw_set_color(make_color_rgb(235, 195, 75));
        draw_circle(x + 13, y - 28, 2.5, false);
        break;

    case "guard_south":
        // Perisai Tower Ksatria Pelindung Gerbang
        draw_set_color(make_color_rgb(45, 55, 75));
        draw_roundrect_ext(x - 18, y - 18 + _breathe, x - 8, y + 6 + _breathe, 4, 4, false);
        draw_set_color(make_color_rgb(220, 180, 75));
        draw_line_width(x - 13, y - 15 + _breathe, x - 13, y + 3 + _breathe, 2);
        draw_line_width(x - 17, y - 6 + _breathe, x - 9, y - 6 + _breathe, 2);
        break;

    case "elder":
        // Selendang Hangat Merah Marun Nenek
        draw_set_color(make_color_rgb(130, 42, 55));
        draw_roundrect_ext(x - 10, y - 16 + _breathe, x + 10, y - 4 + _breathe, 4, 4, false);
        draw_set_color(make_color_rgb(215, 175, 115));
        draw_circle(x, y - 14 + _breathe, 2.5, false); // Bros emas
        break;

    case "flower_girl":
        // Keranjang Bunga Lavender di Tangan
        draw_set_color(make_color_rgb(145, 105, 65));
        draw_ellipse(x + 10, y - 4 + _breathe, x + 20, y + 4 + _breathe, false);
        draw_set_color(make_color_rgb(175, 110, 235)); // Bunga lavender
        draw_circle(x + 13, y - 3 + _breathe, 2.5, false);
        draw_circle(x + 17, y - 3 + _breathe, 2.5, false);
        break;

    case "cafe_patron":
        // Cangkir Kopi Porselen Hangat
        draw_set_color(make_color_rgb(240, 240, 245));
        draw_roundrect_ext(x + 9, y - 6 + _breathe, x + 16, y + 1 + _breathe, 2, 2, false);
        // Uap Kopi Hangat
        draw_set_alpha(0.6);
        draw_set_color(make_color_rgb(230, 230, 230));
        draw_line(x + 12, y - 8 + _breathe, x + 14, y - 14 + _breathe);
        draw_set_alpha(1.0);
        break;

    case "fisherman":
        // Joran Pancing Bambu Panjang Menghadap Sungai
        draw_set_color(make_color_rgb(160, 125, 75));
        draw_line_width(x - 4, y, x + 24, y - 32, 2);
        draw_set_color(make_color_rgb(200, 215, 235));
        draw_line(x + 24, y - 32, x + 38, y + 14); // Senar pancing ke air
        draw_set_color(make_color_rgb(255, 65, 65));
        draw_circle(x + 38, y + 14, 2.5, false);    // Pelampung pancing
        break;
}

draw_set_alpha(1.0);
draw_set_color(c_white);

// 4. Floating Prompt [Z] jika Pemain Mendekat (dari oInteractableParent)
event_inherited();
