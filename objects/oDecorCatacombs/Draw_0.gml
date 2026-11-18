/// @description Draw Event oDecorCatacombs (Forbidden Crypt - Hazards & Puzzles UAS)

var _x1 = 40;
var _y1 = 40;
var _x2 = 1240;
var _y2 = 680;
var _cx = 640;

// 1. Latar Belakang Luar Katakombe Gelap (Outer Dungeon Frame)
draw_set_color(make_color_rgb(10, 12, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Flagstone Hitam Kuno Menutupi Seluruh Ruangan (Crypt Flagstone)
var _tile_s = 32;
for (var _yy = _y1 + 75; _yy < _y2; _yy += _tile_s) {
    for (var _xx = _x1; _xx < _x2; _xx += _tile_s) {
        var _tw = min(_tile_s, _x2 - _xx);
        var _th = min(_tile_s, _y2 - _yy);
        draw_sprite_part(sTile_Autumn, 0, 192, 192, _tw, _th, _xx, _yy);
    }
}

// 3. Dinding Batu Katakombe Purba Utara (dari sTile_Interior 272, 192)
for (var _wx = _x1; _wx < _x2; _wx += 32) {
    var _ww = min(32, _x2 - _wx);
    draw_sprite_part(sTile_Interior, 0, 272, 192, _ww, 75, _wx, _y1);
}
draw_set_color(make_color_rgb(25, 28, 36));
draw_rectangle(_x1, _y1 + 72, _x2, _y1 + 76, false);
draw_set_alpha(0.40);
draw_set_color(make_color_rgb(12, 15, 22));
draw_rectangle(_x1, _y1, _x2, _y1 + 75, false);
draw_set_alpha(1.0);

// 4. Obor Dinding Api Biru Mistis (Soul-Fire Torches di Sepanjang Dinding)
var _draw_blue_torch = function(_tx, _ty) {
    var _glow = 0.75 + sin(torch_blue_flame + _tx) * 0.25;
    
    // Pendaran Cahaya Biru Mistis
    draw_set_alpha(0.25 * _glow);
    draw_set_color(make_color_rgb(60, 160, 255));
    draw_circle(_tx, _ty - 6, 42, false);
    
    // Braket Obor Besi Hitam
    draw_set_alpha(1.0);
    draw_set_color(make_color_rgb(24, 25, 32));
    draw_rectangle(_tx - 3, _ty, _tx + 3, _ty + 14, false);
    draw_rectangle(_tx - 6, _ty - 4, _tx + 6, _ty, false);
    
    // Kobaran Api Biru Berkobar
    draw_set_color(make_color_rgb(45, 145, 255));
    draw_ellipse(_tx - 5, _ty - 16, _tx + 5, _ty - 4, false);
    draw_set_color(make_color_rgb(180, 235, 255));
    draw_ellipse(_tx - 3, _ty - 14, _tx + 3, _ty - 6, false);
};

_draw_blue_torch(120, _y1 + 50);
_draw_blue_torch(360, _y1 + 50);
_draw_blue_torch(_cx, _y1 + 50);
_draw_blue_torch(920, _y1 + 50);
_draw_blue_torch(1160, _y1 + 50);

_draw_blue_torch(120, 360);
_draw_blue_torch(1160, 360);

// 5. Sarkofagus Kuno & Relik Purba Nyata dari sDungeon_Props
draw_sprite_part_ext(sDungeon_Props, 0, 0, 64, 48, 80, 160, 180, 1.15, 1.15, c_white, 1.0);
draw_sprite_part_ext(sDungeon_Props, 0, 0, 64, 48, 80, 1060, 180, 1.15, 1.15, c_white, 1.0);

// =========================================================================
// 6. RENDER JEBAKAN DURI LANTAI (FLOOR SPIKE TRAP)
// =========================================================================
var _spikes_active = (spike_cycle >= 70 && spike_cycle <= 125);
var _spikes_warning = (spike_cycle >= 50 && spike_cycle < 70);

// Pelat Dasar Kisi-Kisi Duri Besi
draw_set_color(make_color_rgb(32, 28, 36));
draw_roundrect_ext(spike_x1 - 4, spike_y1 - 4, spike_x2 + 4, spike_y2 + 4, 8, 8, false);
draw_set_color(make_color_rgb(60, 55, 70));
draw_roundrect_ext(spike_x1 - 4, spike_y1 - 4, spike_x2 + 4, spike_y2 + 4, 8, 8, true);

// Lubang-Lubang Duri Lantai
for (var _sx = spike_x1 + 10; _sx <= spike_x2 - 10; _sx += 24) {
    for (var _sy = spike_y1 + 10; _sy <= spike_y2 - 10; _sy += 20) {
        draw_set_color(make_color_rgb(15, 12, 18));
        draw_circle(_sx, _sy, 5, false);
        
        if (_spikes_active) {
            // Duri Besi Tajam Menghunus ke Atas
            draw_set_color(make_color_rgb(220, 225, 235));
            draw_triangle(_sx - 5, _sy + 4, _sx, _sy - 14, _sx + 5, _sy + 4, false);
            // Kilau Ujung Duri
            draw_set_color(make_color_rgb(255, 90, 80));
            draw_circle(_sx, _sy - 14, 2, false);
        } else if (_spikes_warning) {
            // Ujung Duri Mulai Mencuat (Peringatan Visual)
            var _shake_y = irandom_range(-2, 2);
            draw_set_color(make_color_rgb(200, 180, 60));
            draw_triangle(_sx - 3, _sy + 2, _sx, _sy - 4 + _shake_y, _sx + 3, _sy + 2, false);
        }
    }
}

// =========================================================================
// 7. RENDER TUAS SAKLAR DINDING BARAT (SWITCH)
// =========================================================================
// Pelat Logam Tuas
draw_set_color(make_color_rgb(38, 42, 55));
draw_roundrect_ext(switch_x - 14, switch_y - 20, switch_x + 14, switch_y + 20, 6, 6, false);
draw_set_color(make_color_rgb(90, 110, 150));
draw_roundrect_ext(switch_x - 14, switch_y - 20, switch_x + 14, switch_y + 20, 6, 6, true);

// Permata Runic Indikator (Merah jika Terkunci, Hijau jika Terbuka)
draw_set_color(gate_opened ? make_color_rgb(80, 255, 130) : make_color_rgb(255, 60, 60));
draw_circle(switch_x, switch_y - 10, 4, false);

// Gagang Tuas Besi
if (gate_opened) {
    // Tuas Ditarik ke Bawah
    draw_set_color(make_color_rgb(180, 190, 210));
    draw_line_width(switch_x, switch_y, switch_x + 8, switch_y + 12, 4);
    draw_circle(switch_x + 8, switch_y + 12, 5, false);
} else {
    // Tuas Mengarah ke Atas
    draw_set_color(make_color_rgb(210, 215, 230));
    draw_line_width(switch_x, switch_y, switch_x - 8, switch_y - 12, 4);
    draw_circle(switch_x - 8, switch_y - 12, 5, false);
    
    // Prompt Interaksi saat Dekat Tuas
    if (instance_exists(oPlayer) && point_distance(oPlayer.x, oPlayer.y, switch_x, switch_y) < 42) {
        draw_set_color(make_color_rgb(255, 230, 120));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(switch_x, switch_y - 26, "[E] Tarik Tuas Gerbang");
    }
}

// =========================================================================
// 8. RENDER GERBANG JERUJI BESI (PORTCULLIS GATE)
// =========================================================================
if (!gate_opened) {
    // Balok Penahan Atas Jeruji
    draw_set_color(make_color_rgb(45, 48, 60));
    draw_roundrect_ext(gate_x1 - 8, gate_y - 18, gate_x2 + 8, gate_y - 6, 6, 6, false);
    draw_set_color(make_color_rgb(100, 110, 130));
    draw_roundrect_ext(gate_x1 - 8, gate_y - 18, gate_x2 + 8, gate_y - 6, 6, 6, true);
    
    // Jeruji-Jeruji Besi Menghalang Jalan
    for (var _gx = gate_x1; _gx <= gate_x2; _gx += 16) {
        draw_set_color(make_color_rgb(160, 170, 190));
        draw_line_width(_gx, gate_y - 12, _gx, gate_y + 16, 4);
        // Ujung Runcing Bawah Jeruji
        draw_set_color(make_color_rgb(210, 220, 240));
        draw_triangle(_gx - 3, gate_y + 16, _gx, gate_y + 22, _gx + 3, gate_y + 16, false);
    }
    
    // Gembok Rantai di Tengah Jeruji
    var _lock_cx = (gate_x1 + gate_x2) / 2;
    draw_set_color(make_color_rgb(240, 180, 50));
    draw_rectangle(_lock_cx - 8, gate_y - 2, _lock_cx + 8, gate_y + 12, false);
    draw_set_color(make_color_rgb(40, 30, 20));
    draw_circle(_lock_cx, gate_y + 5, 2.5, false);
    
    // Prompt jika Pemain Mendekati Gerbang Terkunci
    if (instance_exists(oPlayer) && point_distance(oPlayer.x, oPlayer.y, _lock_cx, gate_y) < 55) {
        draw_set_color(make_color_rgb(255, 130, 130));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(_lock_cx, gate_y - 22, "⚠ Jeruji Terkunci (Cari Tuas di Lorong Barat)");
    }
} else {
    // Alur Bekas Jeruji Turun ke Lantai
    draw_set_color(make_color_rgb(25, 28, 38));
    draw_rectangle(gate_x1 - 4, gate_y - 2, gate_x2 + 4, gate_y + 4, false);
    draw_set_color(make_color_rgb(70, 80, 100));
    draw_rectangle(gate_x1 - 4, gate_y - 2, gate_x2 + 4, gate_y + 4, true);
}

// 9. Efek Tetesan Air Bawah Tanah (Drip Puddles)
var _puddle_radius = 6 + sin(drip_timer * 1.5) * 2;
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(70, 140, 180));
draw_ellipse(480 - _puddle_radius, 280 - _puddle_radius / 2, 480 + _puddle_radius, 280 + _puddle_radius / 2, false);
draw_ellipse(800 - _puddle_radius, 460 - _puddle_radius / 2, 800 + _puddle_radius, 460 + _puddle_radius / 2, false);
draw_set_alpha(1.0);

// 10. Gerbang Masuk Ruang Boss / Forgotten Sanctum di Selatan
var _gtx = _cx;
var _gty = _y2 - 35;

draw_set_color(make_color_rgb(65, 70, 85));
draw_roundrect_ext(_gtx - 55, _gty - 45, _gtx + 55, _y2, 16, 16, false);
draw_set_color(c_black);
draw_roundrect_ext(_gtx - 40, _gty - 30, _gtx + 40, _y2, 12, 12, false);

// Kisi-kisi Gerbang Besi Purba
draw_set_color(make_color_rgb(140, 150, 170));
for (var _gx = _gtx - 30; _gx <= _gtx + 30; _gx += 12) {
    draw_line_width(_gx, _gty - 25, _gx, _y2, 3);
}

// Teks Indikator Gerbang Kuil
draw_set_color(make_color_rgb(255, 110, 110));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_gtx, _gty - 50, "☠ GERBANG FORGOTTEN SANCTUM");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
