/// @description Helper Rendering Arsitektur & Lingkungan Kota Altdorf (Tertata Rapi, Bersih, Artistik)

// =========================================================================
// 1. PEMBATAS BATU JALAN ALAMI (Natural Earthy Stone Edge)
// =========================================================================

function scr_draw_curb_line(_x1, _y1, _x2, _y2, _is_horiz) {
    if (_is_horiz) {
        // Garis batas luar batu tanah menyatu ke rumput
        draw_set_color(make_color_rgb(85, 78, 68));
        draw_line(_x1 - 1, _y1 - 1, _x2 + 1, _y1 - 1);
        
        // Trotoar batu hangat tebal 2px
        draw_set_color(make_color_rgb(142, 134, 122));
        draw_rectangle(_x1, _y1, _x2, _y1 + 1, false);
        
        // Highlight lembut atas batu
        draw_set_color(make_color_rgb(168, 160, 148));
        draw_line(_x1, _y1, _x2, _y1);
        
        // Bayangan bawah batu
        draw_set_color(make_color_rgb(105, 98, 88));
        draw_line(_x1, _y1 + 1, _x2, _y1 + 1);
    } else {
        // Vertikal
        draw_set_color(make_color_rgb(85, 78, 68));
        draw_line(_x1 - 1, _y1 - 1, _x1 - 1, _y2 + 1);
        
        draw_set_color(make_color_rgb(142, 134, 122));
        draw_rectangle(_x1, _y1, _x1 + 1, _y2, false);
        
        draw_set_color(make_color_rgb(168, 160, 148));
        draw_line(_x1, _y1, _x1, _y2);
        
        draw_set_color(make_color_rgb(105, 98, 88));
        draw_line(_x1 + 1, _y1, _x1 + 1, _y2);
    }
}

function scr_draw_curb_box(_x1, _y1, _x2, _y2) {
    draw_set_color(make_color_rgb(85, 78, 68));
    draw_rectangle(_x1, _y1, _x2, _y2, true);
    
    draw_set_color(make_color_rgb(138, 130, 118));
    draw_rectangle(_x1 + 1, _y1 + 1, _x2 - 1, _y2 - 1, true);
}


// =========================================================================
// 2. JALAN BATU PAVING COBBLESTONE FLEKSIBEL (Natural Warm Medieval Cobblestone)
// =========================================================================

function scr_draw_cobblestone_road(_rx1, _ry1, _rx2, _ry2, _curb_t = true, _curb_b = true, _curb_l = true, _curb_r = true) {
    // 1. Dasar hangat tanah batu pasir Altdorf
    draw_set_color(make_color_rgb(155, 146, 132));
    draw_rectangle(_rx1, _ry1, _rx2, _ry2, false);
    
    // 2. Pola balok paving batu alami berulang (16x16)
    var _step = 16;
    for (var _ry = _ry1; _ry < _ry2; _ry += _step) {
        var _row_idx = (_ry - _ry1) div _step;
        var _x_offset = (_row_idx mod 2 == 1) ? 8 : 0;
        
        for (var _rx = _rx1 + _x_offset; _rx < _rx2; _rx += _step) {
            var _hash = ((_rx * 374761393) ^ (_ry * 668265263)) & 255;
            var _c_val = 148 + (_hash mod 16);
            draw_set_color(make_color_rgb(_c_val, _c_val - 4, _c_val - 12));
            draw_rectangle(_rx, _ry, min(_rx + _step - 2, _rx2 - 2), min(_ry + _step - 2, _ry2 - 2), false);
            
            // Highlight lembut sudut batu alami
            draw_set_color(make_color_rgb(_c_val + 12, _c_val + 8, _c_val));
            draw_point(_rx + 1, _ry + 1);
        }
    }
    
    // 3. Garis nat semen alami antar batu
    draw_set_color(make_color_rgb(122, 114, 102));
    for (var _ry = _ry1; _ry <= _ry2; _ry += _step) {
        draw_line(_rx1, _ry, _rx2, _ry);
    }
    for (var _rx = _rx1; _rx <= _rx2; _rx += _step) {
        draw_line(_rx, _ry1, _rx, _ry2);
    }
    
    // 4. Pembatas batu lembut di tepi jalan
    if (_curb_t) scr_draw_curb_line(_rx1, _ry1, _rx2, _ry1, true);
    if (_curb_b) scr_draw_curb_line(_rx1, _ry2 - 2, _rx2, _ry2 - 2, true);
    if (_curb_l) scr_draw_curb_line(_rx1, _ry1, _rx1, _ry2, false);
    if (_curb_r) scr_draw_curb_line(_rx2 - 2, _ry1, _rx2 - 2, _ry2, false);
}


// =========================================================================
// 3. PETAK TAMAN BUNGA RAPI BERBINGKAI BATU (Manicured Flowerbeds)
// =========================================================================

function scr_draw_flowerbed(_fx1, _fy1, _fx2, _fy2, _f_type = 0) {
    // Tanah humus kebun subur cokelat gelap
    draw_set_color(make_color_rgb(52, 38, 26));
    draw_roundrect_ext(_fx1, _fy1, _fx2, _fy2, 6, 6, false);
    draw_set_color(make_color_rgb(72, 52, 36));
    draw_roundrect_ext(_fx1 + 2, _fy1 + 2, _fx2 - 2, _fy2 - 2, 4, 4, false);
    
    // Bingkai batu taman alami
    draw_set_color(make_color_rgb(115, 102, 88));
    draw_roundrect_ext(_fx1, _fy1, _fx2, _fy2, 6, 6, true);
    draw_set_color(make_color_rgb(148, 136, 120));
    draw_roundrect_ext(_fx1 - 1, _fy1 - 1, _fx2 + 1, _fy2 + 1, 8, 8, true);
    
    // Bunga-bunga mekar lebat tertata rapi
    for (var _by = _fy1 + 8; _by <= _fy2 - 8; _by += 14) {
        for (var _bx = _fx1 + 8; _bx <= _fx2 - 8; _bx += 14) {
            // Batang & Daun Hijau
            draw_set_color(make_color_rgb(45, 115, 40));
            draw_circle(_bx - 2, _by + 1, 2, false);
            draw_circle(_bx + 2, _by + 1, 2, false);
            
            // Kelopak Bunga sesuai tipe
            if (_f_type == 0) {
                // Marigold Kuning Emas Cerah
                draw_set_color(make_color_rgb(255, 205, 45));
                draw_circle(_bx, _by, 3.5, false);
                draw_set_color(make_color_rgb(255, 130, 25));
                draw_circle(_bx, _by, 1.5, false);
            } else if (_f_type == 1) {
                // Lili / Melati Putih Murni
                draw_set_color(make_color_rgb(248, 252, 255));
                draw_circle(_bx, _by, 3.5, false);
                draw_set_color(make_color_rgb(255, 235, 120));
                draw_circle(_bx, _by, 1.5, false);
            } else if (_f_type == 2) {
                // Lavender Ungu Kerajaan
                draw_set_color(make_color_rgb(165, 110, 225));
                draw_ellipse(_bx - 2, _by - 4, _bx + 2, _by + 4, false);
                draw_set_color(make_color_rgb(215, 175, 255));
                draw_circle(_bx, _by - 1, 1.5, false);
            } else {
                // Mawar Merah Bergairah
                draw_set_color(make_color_rgb(225, 45, 65));
                draw_circle(_bx, _by, 3.5, false);
                draw_set_color(make_color_rgb(255, 120, 140));
                draw_circle(_bx, _by, 1.5, false);
            }
        }
    }
}


// =========================================================================
// 4. LENTERA JALAN KLASIK KOTA (Victorian / Fantasy Streetlamp)
// =========================================================================

function scr_draw_street_lamp(_lx, _ly) {
    // Bayangan tiang di tanah
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_ellipse(_lx - 6, _ly - 2, _lx + 6, _ly + 2, false);
    draw_set_alpha(1.0);
    
    // Dasar besi tempa tiang lentera
    draw_set_color(make_color_rgb(45, 48, 56));
    draw_rectangle(_lx - 4, _ly - 4, _lx + 4, _ly, false);
    draw_set_color(make_color_rgb(32, 34, 40));
    draw_rectangle(_lx - 1, _ly - 24, _lx + 1, _ly - 4, false); // Tiang utama
    
    // Palang lengan lentera
    draw_line_width(_lx - 6, _ly - 24, _lx + 6, _ly - 24, 2);
    
    // Lentera Kaca & Rumah Lentera
    draw_set_color(make_color_rgb(55, 58, 68));
    draw_rectangle(_lx - 4, _ly - 32, _lx + 4, _ly - 24, true);
    
    // Api Lilin / Kristal Cahaya Lentera
    var _flicker = sin(current_time * 0.005 + _lx) * 0.1;
    draw_set_color(make_color_rgb(255, 235, 140));
    draw_rectangle(_lx - 3, _ly - 30, _lx + 3, _ly - 26, false);
    
    // Topi atap lentera runcing
    draw_set_color(make_color_rgb(32, 34, 40));
    draw_triangle(_lx - 6, _ly - 32, _lx + 6, _ly - 32, _lx, _ly - 37, false);
    
    // Pendaran cahaya hangat melingkar
    draw_set_alpha(0.12 + _flicker);
    draw_set_color(make_color_rgb(255, 220, 100));
    draw_circle(_lx, _ly - 28, 22, false);
    draw_set_alpha(0.06);
    draw_circle(_lx, _ly - 28, 44, false);
    draw_set_alpha(1.0);
}


// =========================================================================
// 5. BANGKU TAMAN KAYU ELEGAN (Wooden Park Bench)
// =========================================================================

function scr_draw_park_bench(_bx, _by, _width = 48) {
    var _hw = _width div 2;
    // Bayangan bangku di rumput/paving
    draw_set_alpha(0.28);
    draw_set_color(c_black);
    draw_ellipse(_bx - _hw - 4, _by + 6, _bx + _hw + 4, _by + 14, false);
    draw_set_alpha(1.0);
    
    // Kaki Besi Tempa Hitam
    draw_set_color(make_color_rgb(40, 42, 50));
    draw_rectangle(_bx - _hw + 4, _by + 2, _bx - _hw + 7, _by + 10, false);
    draw_rectangle(_bx + _hw - 7, _by + 2, _bx + _hw - 4, _by + 10, false);
    
    // Dudukan Kayu Halus (3 Bilah Papan)
    for (var _p = 0; _p < 3; _p++) {
        var _py = _by + (_p * 3);
        draw_set_color(make_color_rgb(165, 115, 65));
        draw_rectangle(_bx - _hw, _py, _bx + _hw, _py + 2, false);
        draw_set_color(make_color_rgb(215, 165, 105));
        draw_line(_bx - _hw, _py, _bx + _hw, _py); // Highlight atas kayu
        draw_set_color(make_color_rgb(105, 65, 35));
        draw_line(_bx - _hw, _py + 2, _bx + _hw, _py + 2); // Bayangan bawah bilah
    }
    
    // Sandaran Punggung Bangku Kayu
    for (var _sp = 0; _sp < 2; _sp++) {
        var _spy = _by - 8 + (_sp * 4);
        draw_set_color(make_color_rgb(175, 125, 75));
        draw_rectangle(_bx - _hw, _spy, _bx + _hw, _spy + 2, false);
        draw_set_color(make_color_rgb(225, 175, 115));
        draw_line(_bx - _hw, _spy, _bx + _hw, _spy);
    }
}


// =========================================================================
// 6. KOLAM TAMAN INDAH BERBATU TEPI & TERATAI (Serene Park Pond)
// =========================================================================

function scr_draw_park_pond(_px1, _py1, _px2, _py2) {
    // 1. Dinding Tanggul Batu Luar
    draw_set_color(make_color_rgb(85, 78, 68));
    draw_roundrect_ext(_px1 - 4, _py1 - 4, _px2 + 4, _py2 + 4, 12, 12, false);
    draw_set_color(make_color_rgb(142, 134, 122));
    draw_roundrect_ext(_px1 - 4, _py1 - 4, _px2 + 4, _py2 + 4, 12, 12, true);
    draw_set_color(make_color_rgb(168, 160, 148));
    draw_line(_px1, _py1 - 4, _px2, _py1 - 4);
    
    // 2. Air Kolam Tenang (Gradasi Biru-Kehijauan Alami)
    draw_set_color(make_color_rgb(38, 86, 112));
    draw_roundrect_ext(_px1, _py1, _px2, _py2, 8, 8, false);
    
    draw_set_color(make_color_rgb(48, 112, 138));
    draw_roundrect_ext(_px1 + 4, _py1 + 4, _px2 - 4, _py2 - 4, 6, 6, false);
    
    // 3. Riak Air Animatif Halus
    var _anim = current_time * 0.002;
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(120, 215, 245));
    for (var _wy = _py1 + 10; _wy <= _py2 - 10; _wy += 20) {
        var _wave_x = _px1 + 16 + sin(_anim + _wy * 0.05) * 12;
        draw_line(_wave_x, _wy, _wave_x + 18, _wy);
        draw_line(_wave_x + 40, _wy + 6, _wave_x + 55, _wy + 6);
    }
    draw_set_alpha(1.0);
    
    // 4. Daun Teratai (Lily Pads) & Bunga Teratai Pink Mekar
    var _pad_pos = [
        [_px1 + 22, _py1 + 18],
        [_px1 + 36, _py1 + 24],
        [_px2 - 28, _py1 + 22],
        [_px1 + 30, _py2 - 20],
        [_px2 - 34, _py2 - 18]
    ];
    for (var _p = 0; _p < array_length(_pad_pos); _p++) {
        var _lx = _pad_pos[_p][0];
        var _ly = _pad_pos[_p][1];
        if (_lx > _px1 + 6 && _lx < _px2 - 6 && _ly > _py1 + 6 && _ly < _py2 - 6) {
            // Daun Teratai Hijau Zamrud
            draw_set_color(make_color_rgb(42, 138, 72));
            draw_circle(_lx, _ly, 6, false);
            draw_set_color(make_color_rgb(38, 86, 112)); // Celah daun teratai
            draw_triangle(_lx, _ly, _lx + 6, _ly - 3, _lx + 6, _ly + 3, false);
            
            // Bunga Teratai Merah Muda di beberapa daun
            if (_p mod 2 == 1) {
                draw_set_color(make_color_rgb(255, 160, 200));
                draw_circle(_lx, _ly, 2.5, false);
                draw_set_color(make_color_rgb(255, 245, 140));
                draw_circle(_lx, _ly, 1, false);
            }
        }
    }
}


// =========================================================================
// 7. JEMBATAN KAYU INDAH PENYEBERANGAN KOLAM (Wooden Footbridge)
// =========================================================================

function scr_draw_wooden_bridge(_bx1, _by1, _bx2, _by2) {
    // 1. Tiang Penyangga Jembatan di Air (Piling Posts)
    draw_set_color(make_color_rgb(65, 42, 24));
    draw_rectangle(_bx1 + 2, _by1 - 4, _bx1 + 8, _by2 + 4, false);
    draw_rectangle(_bx2 - 8, _by1 - 4, _bx2 - 2, _by2 + 4, false);
    
    // 2. Dek Papan Kayu Lantai Jembatan
    draw_set_color(make_color_rgb(145, 98, 58));
    draw_rectangle(_bx1, _by1, _bx2, _by2, false);
    
    // Garis bilah kayu lantai jembatan
    var _step = 8;
    for (var _yy = _by1; _yy <= _by2; _yy += _step) {
        draw_set_color(make_color_rgb(185, 135, 85));
        draw_line(_bx1, _yy, _bx2, _yy);
        draw_set_color(make_color_rgb(95, 60, 32));
        draw_line(_bx1, _yy + 1, _bx2, _yy + 1);
    }
    
    // 3. Pegangan Tangan / Handrails di Sisi Kiri dan Kanan Jembatan
    // Railing Kiri
    draw_set_color(make_color_rgb(85, 52, 28));
    draw_line_width(_bx1, _by1, _bx1, _by2, 3);
    draw_set_color(make_color_rgb(195, 145, 95));
    draw_line(_bx1 - 1, _by1, _bx1 - 1, _by2);
    
    // Railing Kanan
    draw_set_color(make_color_rgb(85, 52, 28));
    draw_line_width(_bx2, _by1, _bx2, _by2, 3);
    draw_set_color(make_color_rgb(195, 145, 95));
    draw_line(_bx2 + 1, _by1, _bx2 + 1, _by2);
    
    // Tiang-tiang bulat ujung jembatan
    draw_set_color(make_color_rgb(115, 75, 45));
    draw_circle(_bx1, _by1, 3.5, false);
    draw_circle(_bx2, _by1, 3.5, false);
    draw_circle(_bx1, _by2, 3.5, false);
    draw_circle(_bx2, _by2, 3.5, false);
}


// =========================================================================
// 8. POHON RINDANG DENGAN BAYANGAN LEMBUT (Tree with Soft Shadow)
// =========================================================================

function scr_draw_tree_with_shadow(_tx, _ty) {
    // Bayangan pohon di tanah (origin bawah pohon di tx+32, ty+72)
    draw_set_alpha(0.32);
    draw_set_color(c_black);
    draw_ellipse(_tx + 12, _ty + 64, _tx + 52, _ty + 78, false);
    draw_set_alpha(1.0);
    
    // Gambar sprite pohon
    draw_sprite(sProp_OakTree, 0, _tx, _ty);
}


// =========================================================================
// 9. MEJA KAFE / BISTRO TAVERN (Outdoor Cafe Table & Chairs)
// =========================================================================

function scr_draw_cafe_table(_tx, _ty) {
    // Bayangan meja & kursi di lantai paving
    draw_set_alpha(0.28);
    draw_set_color(c_black);
    draw_circle(_tx, _ty + 2, 16, false);
    draw_set_alpha(1.0);
    
    // 4 Kursi Kayu Bulat di Sekeliling Meja
    var _chair_col = make_color_rgb(115, 75, 45);
    draw_set_color(_chair_col);
    draw_circle(_tx - 15, _ty, 4.5, false);
    draw_circle(_tx + 15, _ty, 4.5, false);
    draw_circle(_tx, _ty - 15, 4.5, false);
    draw_circle(_tx, _ty + 15, 4.5, false);
    
    // Meja Bundar Kayu
    draw_set_color(make_color_rgb(145, 95, 55));
    draw_circle(_tx, _ty, 11, false);
    draw_set_color(make_color_rgb(185, 135, 85));
    draw_circle(_tx, _ty, 10, false);
    draw_set_color(make_color_rgb(225, 175, 115));
    draw_circle(_tx - 2, _ty - 2, 8, true);
    
    // Cangkir / Mug Minuman di Atas Meja
    draw_set_color(make_color_rgb(240, 240, 245));
    draw_circle(_tx + 3, _ty - 2, 2, false);
    draw_set_color(make_color_rgb(165, 85, 30));
    draw_circle(_tx + 3, _ty - 2, 1.2, false); // Teh/Kopi
}


// =========================================================================
// 10. ALUN-ALUN PUSAT LINGKARAN & BUSUR CURB HALUS (Smooth Circular Plaza & Arcs)
// =========================================================================

function scr_draw_circular_plaza(_cx, _cy, _radius = 155, _half_w = 55, _half_h = 45) {
    // 1. Dasar hangat tanah batu pasir Altdorf berbentuk lingkaran
    draw_set_color(make_color_rgb(155, 146, 132));
    draw_circle(_cx, _cy, _radius, false);
    
    // 2. Pola balok paving batu alami berulang di dalam lingkaran
    var _step = 16;
    for (var _py = _cy - _radius; _py < _cy + _radius; _py += _step) {
        var _row = (_py - (_cy - _radius)) div _step;
        var _xoff = (_row mod 2 == 1) ? 8 : 0;
        for (var _px = _cx - _radius + _xoff; _px < _cx + _radius; _px += _step) {
            if (point_distance(_px + 8, _py + 8, _cx, _cy) < _radius - 4) {
                var _hash = ((_px * 374761393) ^ (_py * 668265263)) & 255;
                var _c_val = 148 + (_hash mod 16);
                draw_set_color(make_color_rgb(_c_val, _c_val - 4, _c_val - 12));
                draw_rectangle(_px, _py, min(_px + _step - 2, _cx + _radius), min(_py + _step - 2, _cy + _radius), false);
                
                draw_set_color(make_color_rgb(_c_val + 12, _c_val + 8, _c_val));
                draw_point(_px + 1, _py + 1);
            }
        }
    }
    
    // 3. Overlay Tekstur Paving Atlas di Area Plaza (Bila Ada)
    if (sprite_exists(sTown_TerrainCobble)) {
        for (var _py2 = _cy - _radius + 20; _py2 < _cy + _radius - 20; _py2 += 80) {
            for (var _px2 = _cx - _radius + 20; _px2 < _cx + _radius - 20; _px2 += 80) {
                if (point_distance(_px2 + 40, _py2 + 40, _cx, _cy) < _radius - 30) {
                    draw_sprite_ext(sTown_TerrainCobble, 0, _px2, _py2, 0.85, 0.85, 0, c_white, 0.28);
                }
            }
        }
    }
    
    // 4. Hitung titik temu matematis antara jalan dan lingkaran plaza
    var _y_int = round(sqrt(max(0, _radius * _radius - _half_w * _half_w)));
    var _x_int = round(sqrt(max(0, _radius * _radius - _half_h * _half_h)));
    
    var _a1 = darctan2(_half_h, _x_int);
    var _a2 = 90 - darctan2(_half_w, _y_int);
    
    // Warna curb tepi batu
    var _curb_col_dark = make_color_rgb(60, 55, 68);
    var _curb_col_light = make_color_rgb(165, 160, 175);
    
    // 5. Helper untuk menggambar busur lingkaran halus
    var _draw_arc = function(_center_x, _center_y, _r, _ang_start, _ang_end, _col) {
        draw_set_color(_col);
        var _prev_x = _center_x + lengthdir_x(_r, _ang_start);
        var _prev_y = _center_y + lengthdir_y(_r, _ang_start);
        var _steps = 12;
        var _d_ang = (_ang_end - _ang_start) / _steps;
        for (var _i = 1; _i <= _steps; _i++) {
            var _cur_ang = _ang_start + _i * _d_ang;
            var _cur_x = _center_x + lengthdir_x(_r, _cur_ang);
            var _cur_y = _center_y + lengthdir_y(_r, _cur_ang);
            draw_line_width(_prev_x, _prev_y, _cur_x, _cur_y, 2);
            _prev_x = _cur_x;
            _prev_y = _cur_y;
        }
    };
    
    // Arc 1: Top-Right (antara North Road dan East Road)
    _draw_arc(_cx, _cy, _radius, _a1, _a2, _curb_col_dark);
    // Arc 2: Top-Left (antara North Road dan West Road)
    _draw_arc(_cx, _cy, _radius, 180 - _a2, 180 - _a1, _curb_col_dark);
    // Arc 3: Bottom-Left (antara West Road dan South Road)
    _draw_arc(_cx, _cy, _radius, 180 + _a1, 180 + _a2, _curb_col_dark);
    // Arc 4: Bottom-Right (antara South Road dan East Road)
    _draw_arc(_cx, _cy, _radius, 360 - _a2, 360 - _a1, _curb_col_dark);
    
    // Highlight bagian dalam busur
    _draw_arc(_cx, _cy, _radius - 2, _a1, _a2, _curb_col_light);
    _draw_arc(_cx, _cy, _radius - 2, 180 - _a2, 180 - _a1, _curb_col_light);
    _draw_arc(_cx, _cy, _radius - 2, 180 + _a1, 180 + _a2, _curb_col_light);
    _draw_arc(_cx, _cy, _radius - 2, 360 - _a2, 360 - _a1, _curb_col_light);
}


// =========================================================================
// 11. HAMPARAN TERRAIN ATLAS BERULANG (Tiled Atlas Terrain Helper)
// =========================================================================

function scr_draw_tiled_terrain(_spr, _x1, _y1, _x2, _y2, _scale = 0.85, _alpha = 1.0) {
    if (!sprite_exists(_spr)) return;
    var _tw = sprite_get_width(_spr) * _scale;
    var _th = sprite_get_height(_spr) * _scale;
    for (var _ty = _y1; _ty < _y2; _ty += _th - 4) {
        for (var _tx = _x1; _tx < _x2; _tx += _tw - 4) {
            draw_sprite_ext(_spr, 0, _tx, _ty, _scale, _scale, 0, c_white, _alpha);
        }
    }
}


