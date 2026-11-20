/// @description Draw Event - Render Enemy Sprite, Grounded Shadow, dan Health Bar

// Bayangan tanah menapak kokoh tepat di bawah telapak kaki
draw_set_alpha(0.38);
draw_set_color(c_black);
draw_ellipse(x - 22 * base_xscale, y - 4, x + 22 * base_xscale, y + 4, false);
draw_set_alpha(1.0);

// Render Sprite dengan Flash jika terkena damage
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// Gambar HP Bar di atas kepala jika terluka dan belum mati dan bukan boss
if (hp < max_hp && !is_dead && !is_boss) {
    var _bw = 24;
    var _bh = 4;
    var _bx = x - _bw / 2;
    var _by = y - (sprite_height * base_yscale) - 5;
    
    draw_set_color(c_black);
    draw_rectangle(_bx - 1, _by - 1, _bx + _bw + 1, _by + _bh + 1, false);
    
    draw_set_color(make_color_rgb(180, 40, 40));
    var _fw = max(0, (_bw * (hp / max_hp)));
    draw_rectangle(_bx, _by, _bx + _fw, _by + _bh, false);
    
    draw_set_color(c_white);
}
