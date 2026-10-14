/// @description Draw Event oNPC_Sister_Bed (Mana Seed Carved Bed & Adik Sestrina)

// 1. Gambar Sprite Ranjang & Adik Sestrina Mana Seed
draw_self();

// 2. Partikel Istirahat / Efek Nafas Sestrina
var _zz_alpha = 0.55 + 0.35 * sin(prompt_anim * 2.2);
draw_set_alpha(_zz_alpha);
draw_set_color(make_color_rgb(180, 220, 255));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(x + 14, y - 20, "z");
draw_set_color(make_color_rgb(220, 240, 255));
draw_text(x + 20, y - 27, "Z");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 3. Panggil inherited untuk prompt floating [E] jika pemain dekat
event_inherited();
