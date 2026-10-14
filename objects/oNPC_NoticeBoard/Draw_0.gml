/// @description Draw Event - Render Papan Pengumuman Kayu Beratap Kerajaan

// Bayangan Papan
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 22, y + 4, x + 22, y + 14, false);
draw_set_alpha(1.0);

// Dua Tiang Kayu Penyangga Kokoh
draw_set_color(make_color_rgb(75, 45, 22));
draw_rectangle(x - 16, y - 10, x - 12, y + 8, false);
draw_rectangle(x + 12, y - 10, x + 16, y + 8, false);

// Papan Kayu Ek Besar
draw_set_color(make_color_rgb(110, 68, 36));
draw_roundrect_ext(x - 24, y - 38, x + 24, y - 10, 4, 4, false);
draw_set_color(make_color_rgb(58, 32, 16));
draw_roundrect_ext(x - 24, y - 38, x + 24, y - 10, 4, 4, true);

// Atap Kayu Pelindung Hujan di Atas Papan
draw_set_color(make_color_rgb(145, 50, 38)); // Genteng merah
draw_triangle(x - 28, y - 38, x + 28, y - 38, x, y - 48, false);
draw_set_color(make_color_rgb(85, 30, 20));
draw_triangle(x - 28, y - 38, x + 28, y - 38, x, y - 48, true);

// Lembaran-lembaran Perkamen Tertempel
draw_set_color(make_color_rgb(245, 235, 195));
draw_rectangle(x - 20, y - 34, x - 6, y - 16, false); // Maklumat 1
draw_rectangle(x - 3, y - 32, x + 10, y - 18, false); // Maklumat 2
draw_rectangle(x + 12, y - 35, x + 21, y - 20, false); // Maklumat 3

// Garis Tulisan Kecil pada Perkamen
draw_set_color(make_color_rgb(120, 110, 95));
draw_line(x - 18, y - 30, x - 8, y - 30);
draw_line(x - 18, y - 26, x - 8, y - 26);
draw_line(x - 18, y - 22, x - 10, y - 22);

draw_line(x - 1, y - 28, x + 8, y - 28);
draw_line(x - 1, y - 24, x + 8, y - 24);

// Segel Lilin Merah Kerajaan Berkilau
draw_set_color(make_color_rgb(215, 45, 45));
draw_circle(x - 13, y - 32, 2.5, false);
draw_circle(x + 4, y - 30, 2.5, false);

// Floating prompt inherited
event_inherited();
