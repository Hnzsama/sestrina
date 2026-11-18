/// @description Step Event - AI Boss Golem (Stage 1) & True Guardian Spirit (Stage 2)

if (global.dialogue_active || is_plot_twisting || !instance_exists(oPlayer)) exit;

anim_timer += 0.05;
if (barrier_reflect_flash > 0) barrier_reflect_flash--;

// =========================================================================
// TAHAP 1: ANCIENT STONE GOLEM (Batu Raksasa, Anti-Sihir & Lemparan Boulder)
// =========================================================================
if (boss_stage == 1) {
    // 1. Regenerasi Runic Barrier
    if (!runic_barrier) {
        barrier_break_timer--;
        if (barrier_break_timer <= 0) {
            runic_barrier = true;
            barrier_hp = barrier_max_hp;
            is_stomping = true;
            stomp_shockwave_r = 10;
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "BARRIER RUNIC REGENERASI!";
                oRoomTransition.banner_subtitle = "Golem kembali kebal sihir! Tebas dengan pedang untuk memecahkannya lagi!";
                oRoomTransition.banner_timer = 120;
                oRoomTransition.screen_shake = 8;
            }
        }
    }
    
    // 2. Logika Terhuyung / Stun Recovery Window
    if (is_staggered) {
        stagger_timer--;
        image_speed = 0;
        if (stagger_timer <= 0) {
            is_staggered = false;
            image_speed = 0.08;
        }
    } else {
        // Gerakan mendekati pemain jika tidak sedang menghentak
        if (!is_stomping) {
            var _pdir = point_direction(x, y, oPlayer.x, oPlayer.y);
            var _mx = lengthdir_x(move_speed, _pdir);
            var _my = lengthdir_y(move_speed, _pdir);
            if (!scr_check_collision(x + _mx, y)) x += _mx;
            if (!scr_check_collision(x, y + _my)) y += _my;
            if (_mx != 0) image_xscale = sign(_mx) * abs(image_xscale);
        }
        
        var _pdist = point_distance(x, y, oPlayer.x, oPlayer.y);
        
        // 3. Serangan Balasan Jarak Jauh (Lemparan Batu Boulder) jika Pemain Menjauh
        if (_pdist > 130) {
            boulder_timer--;
            if (boulder_timer <= 0) {
                boulder_timer = 95;
                var _bdir = point_direction(x, y, oPlayer.x, oPlayer.y);
                var _bspd = 6.4;
                array_push(boulders, {
                    xx: x,
                    yy: y + 10,
                    vx: lengthdir_x(_bspd, _bdir),
                    vy: lengthdir_y(_bspd, _bdir),
                    radius: 20,
                    life: 110,
                    rot: 0
                });
                if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 5);
            }
        }
        
        // 4. Hentakan Gempa & Runtuhan Batu (Stomp Ground Pound)
        stomp_timer--;
        if (stomp_timer <= 0) {
            stomp_timer = 130;
            is_stomping = true;
            stomp_shockwave_r = 10;
            if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 8);
            
            // Panggil 2 runtuhan batu dari langit-langit
            for (var _r = 0; _r < 2; _r++) {
                var _rx = clamp(oPlayer.x + lengthdir_x(irandom_range(20, 85), irandom(359)), 120, room_width - 120);
                var _ry = clamp(oPlayer.y + lengthdir_y(irandom_range(20, 85), irandom(359)), 120, room_height - 120);
                array_push(falling_rocks, {
                    xx: _rx,
                    yy: _ry,
                    timer: 40 + (_r * 15),
                    radius: 34,
                    fell: false,
                    dust_timer: 20
                });
            }
        }
    }
    
    // 5. Ekspansi Gelombang Kejut Stomp
    if (is_stomping) {
        stomp_shockwave_r += 4.5;
        if (instance_exists(oPlayer)) {
            var _s_dist = point_distance(x, y, oPlayer.x, oPlayer.y);
            if (abs(_s_dist - stomp_shockwave_r) < 16 && oPlayer.invincible_timer <= 0) {
                global.player_hp = max(0, global.player_hp - 18);
                if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 6);
            }
        }
        if (stomp_shockwave_r > 130) {
            is_stomping = false;
        }
    }
    
    // 6. Update Boulders (Batu Raksasa Meluncur)
    for (var _b = array_length(boulders) - 1; _b >= 0; _b--) {
        var _bd = boulders[_b];
        _bd.xx += _bd.vx;
        _bd.yy += _bd.vy;
        _bd.rot += 8;
        _bd.life--;
        
        // Cek hantaman ke pemain
        if (instance_exists(oPlayer)) {
            var _b_pdist = point_distance(_bd.xx, _bd.yy, oPlayer.x, oPlayer.y);
            if (_b_pdist < _bd.radius + 14) {
                if (variable_instance_exists(oPlayer, "is_rolling") && oPlayer.is_rolling) {
                    // Berhasil roll melompati batu!
                } else if (oPlayer.invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - 22);
                    oPlayer.invincible_timer = 28;
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 7;
                    _bd.life = 0;
                }
            }
        }
        
        if (_bd.life <= 0 || scr_check_collision(_bd.xx, _bd.yy)) {
            array_delete(boulders, _b, 1);
        }
    }
    
    // 7. Update Falling Rocks
    for (var _k = array_length(falling_rocks) - 1; _k >= 0; _k--) {
        var _rock = falling_rocks[_k];
        _rock.timer--;
        if (_rock.timer <= 0 && !_rock.fell) {
            _rock.fell = true;
            if (instance_exists(oPlayer)) {
                var _dist_rock = point_distance(_rock.xx, _rock.yy, oPlayer.x, oPlayer.y);
                if (_dist_rock <= _rock.radius && oPlayer.invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - 20);
                }
            }
            if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 6);
        }
        if (_rock.fell) {
            _rock.dust_timer--;
            if (_rock.dust_timer <= 0) {
                array_delete(falling_rocks, _k, 1);
            }
        }
    }
}
// =========================================================================
// TAHAP 2: THE TRUE GUARDIAN SPIRIT (Roh Penjaga Purba / Crimson Phantom)
// =========================================================================
else if (boss_stage == 2) {
    spirit_aura_anim += 0.08;
    
    // 1. Pergerakan Melayang Cepat Menuju Pemain
    var _sp_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _smx = lengthdir_x(move_speed, _sp_dir);
    var _smy = lengthdir_y(move_speed, _sp_dir);
    if (!scr_check_collision(x + _smx, y)) x += _smx;
    if (!scr_check_collision(x, y + _smy)) y += _smy;
    
    // Bayangan Jejak Hantu (Shadow Trail)
    if (irandom(10) < 4) {
        array_push(shadow_trail, { xx: x, yy: y, alpha: 0.75, radius: 24 });
    }
    for (var _st = array_length(shadow_trail) - 1; _st >= 0; _st--) {
        shadow_trail[_st].alpha -= 0.08;
        if (shadow_trail[_st].alpha <= 0) array_delete(shadow_trail, _st, 1);
    }
    
    // 2. Serangan Menembakkan Bilah Pedang Roh (Phantom Swords)
    sword_barrage_timer--;
    if (sword_barrage_timer <= 0) {
        sword_barrage_timer = 95;
        var _base_ang = point_direction(x, y, oPlayer.x, oPlayer.y);
        for (var _a = -24; _a <= 24; _a += 16) {
            var _fang = _base_ang + _a;
            var _fspd = 5.2;
            array_push(phantom_swords, {
                xx: x,
                yy: y,
                vx: lengthdir_x(_fspd, _fang),
                vy: lengthdir_y(_fspd, _fang),
                ang: _fang,
                life: 90
            });
        }
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 5);
    }
    
    // Update Phantom Swords
    for (var _sw = array_length(phantom_swords) - 1; _sw >= 0; _sw--) {
        var _ps = phantom_swords[_sw];
        _ps.xx += _ps.vx;
        _ps.yy += _ps.vy;
        _ps.life--;
        
        if (instance_exists(oPlayer)) {
            if (point_distance(_ps.xx, _ps.yy, oPlayer.x, oPlayer.y) < 18) {
                if (variable_instance_exists(oPlayer, "is_rolling") && oPlayer.is_rolling) {
                    // Dodged with roll
                } else if (oPlayer.invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - 16);
                    oPlayer.invincible_timer = 24;
                    _ps.life = 0;
                }
            }
        }
        if (_ps.life <= 0 || scr_check_collision(_ps.xx, _ps.yy)) {
            array_delete(phantom_swords, _sw, 1);
        }
    }
    
    // 3. Teleport Flank Mengelilingi Pemain
    teleport_timer--;
    if (teleport_timer <= 0) {
        teleport_timer = 135;
        var _tang = random(360);
        var _tx = oPlayer.x + lengthdir_x(85, _tang);
        var _ty = oPlayer.y + lengthdir_y(85, _tang);
        if (!scr_check_collision(_tx, _ty)) {
            x = _tx;
            y = _ty;
            spirit_pulse_r = 10; // Memicu gelombang gelap seketika
            if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 6;
        }
    }
    
    // 4. Gelombang Kejut Kegelapan Radial (Spirit Pulse Wave)
    if (spirit_pulse_r > 0) {
        spirit_pulse_r += 5;
        if (instance_exists(oPlayer)) {
            var _pdist_sp = point_distance(x, y, oPlayer.x, oPlayer.y);
            if (abs(_pdist_sp - spirit_pulse_r) < 14 && oPlayer.invincible_timer <= 0 && (!variable_instance_exists(oPlayer, "is_rolling") || !oPlayer.is_rolling)) {
                global.player_hp = max(0, global.player_hp - 18);
                oPlayer.invincible_timer = 25;
            }
        }
        if (spirit_pulse_r > 120) spirit_pulse_r = 0;
    }
    
    // 5. Pilihan Segel Darah Iblis [F] (The Crimson Pact Ending)
    if (keyboard_check_pressed(ord("F")) && !global.demon_unsealed && hp > 0) {
        if (global.player_hp > 30) {
            global.player_hp -= 30; // Pengorbanan HP
            global.demon_unsealed = true;
            take_damage(200, 0, true);
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "SEGEL DARAH IBLIS DIBUKA!";
                oRoomTransition.banner_subtitle = "Darah dikorbankan! Tebasan mata merah membelah roh penjaga purba!";
                oRoomTransition.banner_timer = 200;
                oRoomTransition.screen_shake = 16;
            }
        } else {
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "DARAH TIDAK MENCUKUPI!";
                oRoomTransition.banner_subtitle = "HP terlalu rendah untuk pengorbanan darah iblis!";
                oRoomTransition.banner_timer = 90;
            }
        }
    }
}
