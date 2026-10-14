/// @description Draw Event - Indikator Pintu Gerbang Medieval RPG Elegan

// Gambar hanya jika player mendekat dan hanya panah halus / efek karpet lembut
if (instance_exists(oPlayer)) {
    var _pdist = point_distance(x, y, oPlayer.x, oPlayer.y);
    if (_pdist < 55) {
        var _pulse = 0.5 + sin(glow_anim * 2.0) * 0.5;
        
        if (required_quest_stage > 0 && global.quest_stage < required_quest_stage) {
            // Indikator Pintu Terkunci (Garis Palang Merah & Gembok)
            draw_set_alpha(0.8 * _pulse);
            draw_set_color(make_color_rgb(255, 75, 75));
            draw_line_width(x - 22, y - 2, x + 22, y - 2, 3);
            draw_roundrect_ext(x - 6, y - 11, x + 6, y - 2, 2, 2, false);
            draw_set_color(c_white);
            draw_circle(x, y - 7, 1.5, false);
            draw_set_alpha(1.0);
        } else {
            // Panah Indikator Masuk Emas Bersinar Halus di ambang pintu
            draw_set_alpha(0.6 * _pulse);
            draw_set_color(make_color_rgb(255, 230, 140));
            draw_triangle(x - 5, y + 2, x + 5, y + 2, x, y - 4, false);
            draw_set_alpha(1.0);
        }
    }
}

// Pesan Terkunci jika stage belum mencukupi
if (lock_prompt_timer > 0) {
    draw_set_alpha(1.0);
    var _tw = string_width(locked_message) + 24;
    draw_set_color(make_color_rgb(35, 15, 20));
    draw_roundrect_ext(x - _tw / 2, y - 48, x + _tw / 2, y - 22, 8, 8, false);
    draw_set_color(make_color_rgb(255, 90, 90));
    draw_roundrect_ext(x - _tw / 2, y - 48, x + _tw / 2, y - 22, 8, 8, true);
    
    draw_set_color(make_color_rgb(255, 220, 220));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y - 35, locked_message);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
