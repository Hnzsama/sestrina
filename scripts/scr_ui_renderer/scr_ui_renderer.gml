/// @description Reusable JRPG UI Rendering Functions (Adapted from MK_UICustomizer style)

/// @function scr_ui_draw_glass_panel(x, y, w, h, [border_col], [bg_alpha])
/// @desc Renders a translucent deep indigo glass panel with double borders and diamond corners
function scr_ui_draw_glass_panel(_x, _y, _w, _h, _border_col = make_color_rgb(65, 105, 180), _alpha = 0.92) {
    var _x2 = _x + _w;
    var _y2 = _y + _h;
    
    // 1. Dark Indigo Translucent Background
    draw_set_alpha(_alpha);
    draw_set_color(make_color_rgb(14, 20, 36));
    draw_roundrect_ext(_x, _y, _x2, _y2, 10, 10, false);
    
    // 2. Outer Accent Border
    draw_set_alpha(1.0);
    draw_set_color(_border_col);
    draw_roundrect_ext(_x, _y, _x2, _y2, 10, 10, true);
    
    // 3. Inner Subtle Inset Border
    draw_set_color(make_color_rgb(25, 38, 68));
    draw_roundrect_ext(_x + 2, _y + 2, _x2 - 2, _y2 - 2, 8, 8, true);
    
    // 4. Diamond Corner Accents
    scr_ui_draw_diamond_corner(_x + 2, _y + 2, _border_col);
    scr_ui_draw_diamond_corner(_x2 - 3, _y + 2, _border_col);
    scr_ui_draw_diamond_corner(_x + 2, _y2 - 3, _border_col);
    scr_ui_draw_diamond_corner(_x2 - 3, _y2 - 3, _border_col);
}

/// @function scr_ui_draw_diamond_corner(x, y, color)
function scr_ui_draw_diamond_corner(_dx, _dy, _col) {
    draw_set_color(_col);
    draw_point(_dx, _dy - 1);
    draw_line(_dx - 1, _dy, _dx + 1, _dy);
    draw_point(_dx, _dy + 1);
}

/// @function scr_ui_draw_gauge(x, y, w, h, label, cur_val, max_val, c_fill, [c_top_highlight], [c_badge_bg])
/// @desc Renders a polished gradient resource gauge with label pill and fractional text
function scr_ui_draw_gauge(_gx, _gy, _gw, _gh, _label, _cur, _max, _c_fill, _c_highlight = c_white, _c_badge = make_color_rgb(30, 40, 65)) {
    var _badge_w = 40;
    
    // Label Badge
    draw_set_alpha(0.95);
    draw_set_color(_c_badge);
    draw_roundrect_ext(_gx, _gy, _gx + _badge_w, _gy + _gh, 4, 4, false);
    draw_set_color(make_color_rgb(60, 80, 120));
    draw_roundrect_ext(_gx, _gy, _gx + _badge_w, _gy + _gh, 4, 4, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_gx + _badge_w / 2, _gy + _gh / 2, _label, 0.75, 0.75, 0);
    
    // Bar Area
    var _bx = _gx + _badge_w + 6;
    var _bw = _gw - _badge_w - 6;
    
    // Background Track
    draw_set_color(make_color_rgb(20, 24, 38));
    draw_rectangle(_bx, _gy, _bx + _bw, _gy + _gh, false);
    draw_set_color(make_color_rgb(55, 70, 100));
    draw_rectangle(_bx, _gy, _bx + _bw, _gy + _gh, true);
    
    // Fill
    var _pct = clamp(_cur / max(1, _max), 0, 1);
    var _fill_w = round((_bw - 2) * _pct);
    if (_fill_w > 0) {
        draw_set_color(_c_fill);
        draw_rectangle(_bx + 1, _gy + 1, _bx + _fill_w, _gy + _gh - 1, false);
        
        // Specular highlight line on top edge
        draw_set_color(_c_highlight);
        draw_set_alpha(0.65);
        draw_line(_bx + 1, _gy + 1, _bx + _fill_w, _gy + 1);
        draw_set_alpha(1.0);
    }
    
    // Numeric Text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_bx + _bw / 2, _gy + _gh / 2, string(round(_cur)) + " / " + string(round(_max)), 0.72, 0.72, 0);
}

/// @function scr_ui_draw_command_item(x, y, w, h, icon_idx, text, is_selected, is_active, [badge_text])
/// @desc Renders a command row with icon, label, and smooth selection highlight
function scr_ui_draw_command_item(_cx, _cy, _cw, _ch, _icon_idx, _text, _is_selected, _is_active = true, _badge_text = "") {
    var _bg_col = _is_selected ? make_color_rgb(32, 52, 95) : make_color_rgb(18, 26, 46);
    var _border_col = _is_selected ? make_color_rgb(255, 215, 80) : make_color_rgb(42, 60, 96);
    
    draw_set_alpha(_is_selected ? 0.98 : 0.88);
    draw_set_color(_bg_col);
    draw_roundrect_ext(_cx, _cy, _cx + _cw, _cy + _ch, 6, 6, false);
    draw_set_color(_border_col);
    draw_roundrect_ext(_cx, _cy, _cx + _cw, _cy + _ch, 6, 6, true);
    
    // Pointer Arrow if selected
    if (_is_selected) {
        draw_set_color(make_color_rgb(255, 225, 90));
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text_transformed(_cx + 8, _cy + _ch / 2, ">", 0.9, 0.9, 0);
    }
    
    // Icon
    if (_icon_idx >= 0 && sprite_exists(sUiIcons)) {
        var _ic_x = _is_selected ? (_cx + 24) : (_cx + 14);
        var _ic_y = _cy + (_ch - 32) / 2;
        draw_sprite_ext(sUiIcons, _icon_idx, _ic_x, _ic_y, 0.8, 0.8, 0, _is_active ? c_white : c_gray, 1.0);
    }
    
    // Text Label
    var _tx_x = _is_selected ? (_cx + 56) : (_cx + 46);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(_is_selected ? make_color_rgb(255, 235, 140) : (_is_active ? make_color_rgb(220, 230, 250) : make_color_rgb(120, 130, 150)));
    draw_text_transformed(_tx_x, _cy + _ch / 2, _text, 0.88, 0.88, 0);
    
    // Optional Right Badge (e.g., "! Points" or "100%")
    if (_badge_text != "") {
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(255, 210, 60));
        draw_text_transformed(_cx + _cw - 12, _cy + _ch / 2, _badge_text, 0.75, 0.75, 0);
    }
    draw_set_alpha(1.0);
}

