/// @description Draw Event oDialogueManager - In-World Emotion Reaction Bubble (Reference: reactionbubble.png)

if (current_dialogue == noone || !global.dialogue_active) exit;

var _lines = current_dialogue.lines;
if (current_line_index >= array_length(_lines)) exit;
var _line = _lines[current_line_index];

if (!variable_struct_exists(_line, "emote") || _line.emote == "" || emote_scale <= 0.05) exit;

var _target_x = 0;
var _target_y = 0;
var _found_target = false;

if (_line.side_active == "left") {
    if (instance_exists(oPlayer)) {
        _target_x = oPlayer.x;
        _target_y = oPlayer.y - 34;
        _found_target = true;
    }
} else {
    // Sisi kanan: cari NPC atau Bos terdekat dari player
    if (instance_exists(oPlayer)) {
        if (instance_exists(oInteractableParent)) {
            var _npc = instance_nearest(oPlayer.x, oPlayer.y, oInteractableParent);
            if (_npc != noone) {
                _target_x = _npc.x;
                _target_y = _npc.y - 32;
                _found_target = true;
            }
        }
        
        if (!_found_target && instance_exists(oBossGolem)) {
            _target_x = oBossGolem.x;
            _target_y = oBossGolem.y - 55;
            _found_target = true;
        }
        
        if (!_found_target && instance_exists(oNPC_Sister_Bed)) {
            _target_x = oNPC_Sister_Bed.x;
            _target_y = oNPC_Sister_Bed.y - 28;
            _found_target = true;
        }
    }
}

if (!_found_target) exit;

// Gambar Balon Reaksi Emosi di Dunia (World Space - Reference: reactionbubble.png)
var _bounce = emote_scale;
if (_bounce < 1.0) _bounce = emote_scale * 1.15;

var _rad = 14 * _bounce;
var _bob = sin(emote_timer * 3) * 2;
var _cy = _target_y + _bob;
var _cx = _target_x;

// Bayangan Balon
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(10, 15, 30));
draw_circle(_cx, _cy + 3, _rad + 1.5, false);

// Latar Putih Balon Bulat
draw_set_alpha(0.96);
draw_set_color(c_white);
draw_circle(_cx, _cy, _rad, false);

// Ekor Balon Segitiga Menunjuk ke Kepala Sprite
draw_triangle(_cx - 4 * _bounce, _cy + _rad - 2, _cx + 4 * _bounce, _cy + _rad - 2, _cx - 2 * _bounce, _cy + _rad + 7 * _bounce, false);

// Outline Balon
draw_set_color(make_color_rgb(45, 55, 75));
draw_circle(_cx, _cy, _rad, true);
draw_line(_cx - 4 * _bounce, _cy + _rad - 2, _cx - 2 * _bounce, _cy + _rad + 7 * _bounce);
draw_line(_cx + 4 * _bounce, _cy + _rad - 2, _cx - 2 * _bounce, _cy + _rad + 7 * _bounce);

// Ikon di dalam Balon
draw_set_alpha(1.0);
if (_line.emote == "sweat") {
    // Tetesan Air Keringat Biru (Reference: reactionbubble.png)
    var _sx = _cx;
    var _sy = _cy + 1;
    draw_set_color(make_color_rgb(40, 150, 245));
    draw_triangle(_sx, _sy - 8 * _bounce, _sx - 6 * _bounce, _sy + 4 * _bounce, _sx + 6 * _bounce, _sy + 4 * _bounce, false);
    draw_circle(_sx, _sy + 3 * _bounce, 5.5 * _bounce, false);
    // Kilau Putih Lengkung
    draw_set_color(c_white);
    draw_ellipse(_sx - 3 * _bounce, _sy - 1 * _bounce, _sx - 0.5 * _bounce, _sy + 3 * _bounce, false);
} else if (_line.emote == "exclamation") {
    // Tanda Seru Merah (!)
    draw_set_color(make_color_rgb(235, 45, 55));
    draw_roundrect_ext(_cx - 2 * _bounce, _cy - 8 * _bounce, _cx + 2 * _bounce, _cy + 2 * _bounce, 2, 2, false);
    draw_circle(_cx, _cy + 6 * _bounce, 2.2 * _bounce, false);
} else if (_line.emote == "dots") {
    // Tiga Titik (...)
    draw_set_color(make_color_rgb(60, 75, 110));
    for (var _d = -1; _d <= 1; _d++) {
        var _wave = sin(emote_timer * 4 + _d * 1.5) * 2 * _bounce;
        draw_circle(_cx + _d * 6 * _bounce, _cy + _wave, 2 * _bounce, false);
    }
} else if (_line.emote == "question") {
    // Tanda Tanya (?)
    draw_set_color(make_color_rgb(65, 80, 200));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(_cx, _cy - 1, "?", 1.0 * _bounce, 1.0 * _bounce, 0);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
