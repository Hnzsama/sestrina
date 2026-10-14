/// @description Draw Event - Render Health Bar Musuh

// Gambar HP Bar di atas kepala jika terluka dan bukan boss (boss digambar di GUI)
if (hp < max_hp && !is_boss) {
    var _bw = 32;
    var _bh = 5;
    var _bx = x - _bw / 2;
    var _by = y - 30;
    
    draw_set_color(c_black);
    draw_rectangle(_bx - 1, _by - 1, _bx + _bw + 1, _by + _bh + 1, false);
    
    draw_set_color(make_color_rgb(180, 40, 40));
    var _fw = (_bw * (hp / max_hp));
    draw_rectangle(_bx, _by, _bx + _fw, _by + _bh, false);
    
    draw_set_color(c_white);
}
