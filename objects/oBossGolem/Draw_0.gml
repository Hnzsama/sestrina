/// @description Draw Event - Render Dark Crystal Overlord & Phase 2 Corrupted Form

anim_timer += 0.05;

// =========================================================================
// 1. RENDER PROYEKTIL & EFEK ARENA (METEOR, BOLA SIHIR, PEDANG ROH)
// =========================================================================
// A. Peringatan & Ledakan Meteor
for (var _m = 0; _m < array_length(meteors); _m++) {
    var _met = meteors[_m];
    if (!_met.impact) {
        var _m_pulse = 0.5 + sin(anim_timer * 8 + _m) * 0.3;
        draw_set_alpha(_m_pulse);
        draw_set_color(make_color_rgb(255, 60, 60));
        draw_ellipse(_met.xx - _met.radius, _met.target_y - _met.radius * 0.6, _met.xx + _met.radius, _met.target_y + _met.radius * 0.6, false);
        draw_set_color(make_color_rgb(255, 230, 100));
        draw_ellipse(_met.xx - _met.radius, _met.target_y - _met.radius * 0.6, _met.xx + _met.radius, _met.target_y + _met.radius * 0.6, true);
        
        // Garis telegraf jatuh
        draw_set_alpha(0.3);
        draw_set_color(make_color_rgb(255, 120, 200));
        draw_line(_met.xx, 0, _met.xx, _met.target_y);
    } else {
        // Ledakan Erupsi Kristal Ungu
        var _e_alpha = (_met.timer / 20.0);
        draw_set_alpha(_e_alpha * 0.85);
        draw_set_color(make_color_rgb(220, 40, 255));
        draw_circle(_met.xx, _met.target_y, _met.radius * 1.25, false);
        draw_set_color(make_color_rgb(255, 240, 255));
        draw_circle(_met.xx, _met.target_y, _met.radius * 0.6, false);
    }
}

// B. Bola Sihir Gelap (Magic Orbs)
for (var _o = 0; _o < array_length(magic_orbs); _o++) {
    var _orb = magic_orbs[_o];
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(190, 40, 255));
    draw_circle(_orb.xx, _orb.yy, _orb.radius, false);
    draw_set_color(make_color_rgb(255, 220, 255));
    draw_circle(_orb.xx, _orb.yy, _orb.radius * 0.5, false);
}

// C. Pedang Roh Meluncur (Phase 2)
for (var _sw = 0; _sw < array_length(phantom_swords); _sw++) {
    var _ps = phantom_swords[_sw];
    var _p_rad = degtorad(_ps.ang);
    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(240, 50, 140));
    draw_line_width(_ps.xx, _ps.yy, _ps.xx - cos(_p_rad) * 22, _ps.yy + sin(_p_rad) * 22, 4);
    draw_set_color(make_color_rgb(255, 240, 250));
    draw_circle(_ps.xx, _ps.yy, 4, false);
}

// D. Gelombang Kejut Spirit Pulse (Phase 2)
if (spirit_pulse_r > 0) {
    draw_set_alpha(0.7 * (1.0 - spirit_pulse_r / 130));
    draw_set_color(make_color_rgb(180, 40, 220));
    draw_circle(x, y - 20, spirit_pulse_r, true);
    draw_set_color(make_color_rgb(255, 60, 100));
    draw_circle(x, y - 20, max(1, spirit_pulse_r - 3), true);
}

draw_set_alpha(1.0);

// =========================================================================
// 2. RENDER TUBUH DARK CRYSTAL OVERLORD
// =========================================================================
// A. Bayangan Bos di Lantai
draw_set_alpha(0.45);
draw_set_color(c_black);
draw_ellipse(x - 26, y - 6, x + 26, y + 8, false);
draw_set_alpha(1.0);

// B. Render Sprite Bos (Berbalik Sesuai Arah Hadap)
image_xscale = facing;
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// =========================================================================
// 3. RUNIC BARRIER & STATUS TAHAP 1
// =========================================================================
if (boss_stage == 1) {
    if (runic_barrier) {
        var _b_pulse = 0.6 + sin(anim_timer * 4.5) * 0.25;
        if (barrier_reflect_flash > 0) _b_pulse = 0.95;
        
        // Gelembung Perisai Kristal Gelap
        draw_set_alpha(_b_pulse * 0.35);
        draw_set_color(make_color_rgb(160, 50, 255));
        draw_circle(x, y - 48, 56, false);
        
        draw_set_alpha(_b_pulse * 0.85);
        draw_set_color((barrier_reflect_flash > 0) ? make_color_rgb(255, 230, 100) : make_color_rgb(210, 120, 255));
        draw_circle(x, y - 48, 56, true);
        draw_circle(x, y - 48, 54, true);
        
        // Rune Mengorbit di Sekeliling Perisai
        for (var _r = 0; _r < barrier_hp; _r++) {
            var _rang = degtorad(anim_timer * 60 + _r * (360 / max(1, barrier_hp)));
            var _rx = x + cos(_rang) * 46;
            var _ry = (y - 48) + sin(_rang) * 28;
            draw_set_color(make_color_rgb(255, 215, 80));
            draw_circle(_rx, _ry, 5, false);
            draw_set_color(c_white);
            draw_circle(_rx, _ry, 2.5, false);
        }
        
        // Teks Indikator di atas kepala
        draw_set_alpha(0.9);
        draw_set_color(make_color_rgb(220, 160, 255));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(x, y - 110, "🛡️ RUNIC BARRIER (Kebal Sihir - Tebas Melee: " + string(barrier_hp) + "/3)");
        draw_set_alpha(1.0);
    } else if (is_staggered && boss_stage == 1 && !is_plot_twisting) {
        // Indikator Terhuyung saat Barrier Pecah
        draw_set_alpha(0.85 + sin(anim_timer * 8) * 0.15);
        draw_set_color(make_color_rgb(255, 235, 100));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(x, y - 110, "★ OVERLORD TERHUYUNG! BARRIER PECAH! (Damage 1.5x) ★");
        draw_set_alpha(1.0);
    }
}
// =========================================================================
// 4. EFEK VISUAL TAHAP 2: THE TRUE CORRUPTED FORM
// =========================================================================
else if (boss_stage == 2) {
    // Aura Gelap Mendidih
    draw_set_alpha(0.35 + sin(spirit_aura_anim * 3) * 0.15);
    draw_set_color(make_color_rgb(180, 20, 160));
    draw_circle(x, y - 50, 48, false);
    draw_set_color(make_color_rgb(240, 40, 70));
    draw_circle(x, y - 50, 32, false);
    draw_set_alpha(1.0);
    
    // Prompt Segel Darah Iblis [F]
    if (variable_global_exists("demon_unsealed") && !global.demon_unsealed && hp > 0) {
        var _p_pulse = 0.75 + sin(anim_timer * 5) * 0.25;
        draw_set_alpha(_p_pulse);
        draw_set_color(make_color_rgb(255, 80, 100));
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(x, y + 20, "✦ [F] Buka Segel Darah Iblis (-30 HP, Tebasan Pemusnah) ✦");
        draw_set_alpha(1.0);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
