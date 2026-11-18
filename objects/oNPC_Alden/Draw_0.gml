/// @description Draw Event - Render Kapten Alden Mana Seed Sprite & Story Bubble Indicator

anim_timer += 0.05;

// Bayangan Karakter Grounded
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(x - 12, y + 10, x + 12, y + 18, false);
draw_set_alpha(1.0);

// Gambar Karakter Sprite Mana Seed
draw_self();

// Tombak Halberd Kesatria Emas Baja di Samping Kapten
draw_set_color(make_color_rgb(110, 70, 40));
draw_line_width(x + 13, y - 28, x + 13, y + 8, 2.5);
draw_set_color(make_color_rgb(235, 240, 250));
draw_triangle(x + 9, y - 28, x + 17, y - 28, x + 13, y - 40, false);
draw_triangle(x + 13, y - 28, x + 21, y - 24, x + 13, y - 20, false); // Bilah Kapak
draw_set_color(make_color_rgb(225, 190, 70));
draw_circle(x + 13, y - 28, 3, false); // Cincin Pengikat Emas
draw_set_color(c_white);

// Story Bubble Indicator di atas kepala Kapten Alden (Reference: story bubble indikator.png)
if (global.quest_stage < 2) {
    var _sb_y = y - 56 + sin(current_time * 0.005) * 3;
    draw_set_alpha(0.95);
    draw_set_color(c_white);
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, false);
    draw_set_color(make_color_rgb(70, 110, 190));
    draw_roundrect_ext(x - 22, _sb_y - 12, x + 22, _sb_y + 4, 10, 10, true);
    
    // Bubble pointer
    draw_set_color(c_white);
    draw_triangle(x - 4, _sb_y + 4, x + 4, _sb_y + 4, x, _sb_y + 9, false);
    
    draw_set_color(make_color_rgb(30, 45, 90));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, _sb_y - 4, "Story");
}

// Reset drawing settings & floating prompt
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Floating prompt inherited
event_inherited();
