/// @description Draw Event - Render Boss Golem (Stage 1) & True Guardian Spirit (Stage 2)

anim_timer += 0.05;

// =========================================================================
// RENDER TAHAP 1: ANCIENT STONE GOLEM & RUNIC BARRIER
// =========================================================================
if (boss_stage == 1) {
    // 1. Runtuhan Batu Langit-Langit
    for (var _k = 0; _k < array_length(falling_rocks); _k++) {
        var _rock = falling_rocks[_k];
        if (!_rock.fell) {
            var _pulse = 0.4 + sin(anim_timer * 6 + _k) * 0.25;
            draw_set_alpha(_pulse);
            draw_set_color(make_color_rgb(255, 40, 40));
            draw_circle(_rock.xx, _rock.yy, _rock.radius, false);
            draw_set_alpha(0.85);
            draw_set_color(make_color_rgb(255, 220, 80));
            draw_circle(_rock.xx, _rock.yy, _rock.radius, true);
        } else {
            var _d_alpha = (_rock.dust_timer / 20.0);
            draw_set_alpha(_d_alpha * 0.7);
            draw_set_color(make_color_rgb(180, 160, 130));
            draw_circle(_rock.xx, _rock.yy, _rock.radius * 1.1, false);
        }
    }
    
    // 2. Batu Raksasa Terbang (Boulders)
    for (var _b = 0; _b < array_length(boulders); _b++) {
        var _bd = boulders[_b];
        draw_set_alpha(0.4);
        draw_set_color(c_black);
        draw_ellipse(_bd.xx - _bd.radius, _bd.yy + _bd.radius * 0.6, _bd.xx + _bd.radius, _bd.yy + _bd.radius * 1.1, false);
        
        draw_set_alpha(1.0);
        draw_set_color(make_color_rgb(110, 105, 120));
        draw_circle(_bd.xx, _bd.yy, _bd.radius, false);
        draw_set_color(make_color_rgb(60, 55, 70));
        draw_circle(_bd.xx, _bd.yy, _bd.radius, true);
        draw_set_color(make_color_rgb(175, 170, 185));
        draw_circle(_bd.xx - 4, _bd.yy - 4, _bd.radius * 0.45, false);
    }
    
    // 3. Bayangan Golem
    draw_set_alpha(0.45);
    draw_set_color(c_black);
    draw_ellipse(x - 36, y + 14, x + 36, y + 30, false);
    
    // 4. Efek Gelombang Hentakan Kaki
    if (is_stomping && stomp_shockwave_r > 0) {
        draw_set_alpha(0.6 * (1.0 - stomp_shockwave_r / 130));
        draw_set_color(make_color_rgb(255, 180, 50));
        draw_circle(x, y + 14, stomp_shockwave_r, true);
        draw_set_color(make_color_rgb(255, 90, 30));
        draw_circle(x, y + 14, stomp_shockwave_r - 2, true);
    }
    
    draw_set_alpha(1.0);
    
    // 5. Render Sprite Golem
    if (flash_timer > 0) {
        gpu_set_fog(true, c_white, 0, 0);
        draw_self();
        gpu_set_fog(false, c_white, 0, 0);
    } else {
        draw_self();
    }
    
    // 6. RUNIC ANTI-MAGIC BARRIER SHIELD (Kubik Perisai Biru-Emas)
    if (runic_barrier) {
        var _b_pulse = 0.55 + sin(anim_timer * 4) * 0.25;
        if (barrier_reflect_flash > 0) _b_pulse = 0.95; // Kilatan saat menepis fireball
        
        draw_set_alpha(_b_pulse * 0.45);
        draw_set_color(make_color_rgb(60, 160, 255));
        draw_circle(x, y + 2, 54, false);
        
        draw_set_alpha(_b_pulse * 0.9);
        draw_set_color((barrier_reflect_flash > 0) ? make_color_rgb(255, 230, 100) : make_color_rgb(120, 220, 255));
        draw_circle(x, y + 2, 54, true);
        draw_circle(x, y + 2, 52, true);
        
        // Simbol Runic yang Berputar Mengelilingi Golem
        for (var _r = 0; _r < barrier_hp; _r++) {
            var _rang = degtorad(anim_timer * 60 + _r * (360 / max(1, barrier_hp)));
            var _rx = x + cos(_rang) * 44;
            var _ry = y + sin(_rang) * 26;
            draw_set_color(make_color_rgb(255, 215, 80));
            draw_circle(_rx, _ry, 5, false);
            draw_set_color(c_white);
            draw_circle(_rx, _ry, 2.5, false);
        }
        
        // Teks Indikator di atas kepala
        draw_set_alpha(0.9);
        draw_set_color(make_color_rgb(130, 220, 255));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(x, y - 54, "🛡️ RUNIC BARRIER (Kebal Sihir - Tebas Melee: " + string(barrier_hp) + "/3)");
        draw_set_alpha(1.0);
    } else if (is_staggered) {
        // Indikator Terhuyung saat Barrier Pecah
        draw_set_alpha(0.85 + sin(anim_timer * 8) * 0.15);
        draw_set_color(make_color_rgb(255, 235, 100));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(x, y - 54, "★ TERHUYUNG! BARRIER PECAH! (Damage 1.5x) ★");
        draw_set_alpha(1.0);
    }
}
// =========================================================================
// RENDER TAHAP 2: THE TRUE GUARDIAN SPIRIT (Roh Penjaga Purba / Crimson Phantom)
// =========================================================================
else if (boss_stage == 2) {
    // 1. Bayangan Gelap Ethereal (Shadow Trail)
    for (var _st = 0; _st < array_length(shadow_trail); _st++) {
        var _sh = shadow_trail[_st];
        draw_set_alpha(_sh.alpha * 0.4);
        draw_set_color(make_color_rgb(60, 20, 90));
        draw_circle(_sh.xx, _sh.yy, _sh.radius, false);
    }
    
    // 2. Gelombang Kejut Kegelapan (Spirit Pulse Wave)
    if (spirit_pulse_r > 0) {
        draw_set_alpha(0.7 * (1.0 - spirit_pulse_r / 120));
        draw_set_color(make_color_rgb(160, 30, 180));
        draw_circle(x, y, spirit_pulse_r, true);
        draw_set_color(make_color_rgb(240, 50, 70));
        draw_circle(x, y, spirit_pulse_r - 3, true);
    }
    
    // 3. Bilah Pedang Roh Meluncur (Phantom Swords)
    for (var _sw = 0; _sw < array_length(phantom_swords); _sw++) {
        var _ps = phantom_swords[_sw];
        var _p_rad = degtorad(_ps.ang);
        draw_set_alpha(0.95);
        draw_set_color(make_color_rgb(220, 40, 120));
        draw_line_width(_ps.xx, _ps.yy, _ps.xx - cos(_p_rad) * 22, _ps.yy + sin(_p_rad) * 22, 4);
        draw_set_color(make_color_rgb(255, 230, 240));
        draw_circle(_ps.xx, _ps.yy, 4, false);
    }
    
    // 4. Inti Roh Purba & Aura Api Kegelapan (Floating Phantom Core)
    var _float_y = y + sin(spirit_aura_anim * 2) * 5;
    
    // Pendaran Aura Luar Gelap
    draw_set_alpha(0.45 + sin(spirit_aura_anim * 3) * 0.2);
    draw_set_color(make_color_rgb(120, 20, 140));
    draw_circle(x, _float_y, 42, false);
    draw_set_color(make_color_rgb(220, 30, 60));
    draw_circle(x, _float_y, 30, false);
    
    // Sayap Bayangan Ethereal (Phantom Shadow Wings)
    for (var _w = -1; _w <= 1; _w += 2) {
        var _wing_ang = degtorad(anim_timer * 40 * _w);
        draw_set_color(make_color_rgb(80, 15, 110));
        draw_triangle(x, _float_y - 6, x + _w * (48 + sin(anim_timer * 4) * 8), _float_y - 28, x + _w * 28, _float_y + 18, false);
    }
    
    // Inti Tubuh Roh Kegelapan
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(35, 12, 50));
    draw_ellipse(x - 18, _float_y - 26, x + 18, _float_y + 26, false);
    
    // DUA MATA MERAH MEMBARA (The Crimson Eyes of the Guardian)
    var _eye_pulse = 0.85 + sin(spirit_aura_anim * 5) * 0.15;
    draw_set_alpha(_eye_pulse);
    draw_set_color(make_color_rgb(255, 30, 40));
    draw_ellipse(x - 8, _float_y - 8, x - 3, _float_y - 3, false);
    draw_ellipse(x + 3, _float_y - 8, x + 8, _float_y - 3, false);
    draw_set_color(c_white);
    draw_circle(x - 5.5, _float_y - 5.5, 1.5, false);
    draw_circle(x + 5.5, _float_y - 5.5, 1.5, false);
    
    // Prompt Segel Darah Iblis [F]
    if (variable_global_exists("demon_unsealed") && !global.demon_unsealed && hp > 0) {
        var _p_pulse = 0.7 + sin(anim_timer * 4) * 0.3;
        draw_set_alpha(_p_pulse);
        draw_set_color(make_color_rgb(255, 70, 90));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(x, _float_y + 44, "✦ [F] Buka Segel Darah Iblis (-30 HP, Tebasan Pemusnah) ✦");
        draw_set_alpha(1.0);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
