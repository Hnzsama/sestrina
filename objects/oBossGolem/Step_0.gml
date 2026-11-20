/// @description Step Event - State Machine Dark Crystal Overlord & Phase 2 Guardian

if (flash_timer > 0) flash_timer--;
if (barrier_reflect_flash > 0) barrier_reflect_flash--;

if (is_plot_twisting) {
    twist_timer++;
    // Fallback otomatis jika dialog telah selesai atau dilewati pemain
    if (!global.dialogue_active && twist_timer > 30) {
        start_phase_2();
    }
    exit;
}

// =========================================================================
// ADEGAN KEMATIAN BOS (DISSOLVE SEQUENCE)
// =========================================================================
if (state == STATE_DEATH) {
    sprite_index = sBoss_Overlord_Death;
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha -= 0.015;
        if (image_alpha <= 0) {
            instance_destroy();
        }
    }
    exit;
}

if (!instance_exists(oPlayer)) exit;

// Menentukan Arah Hadap Bos
facing = (oPlayer.x < x) ? -1 : 1;

// =========================================================================
// TAHAP 1: DARK CRYSTAL OVERLORD (Sihir Kegelapan, Scythe Melee, Meteor)
// =========================================================================
if (boss_stage == 1) {
    // Regenerasi Barrier setelah waktu habis
    if (!runic_barrier) {
        if (barrier_break_timer > 0) {
            barrier_break_timer--;
        } else {
            runic_barrier = true;
            barrier_hp = barrier_max_hp;
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "BARRIER OVERLORD REGENERASI!";
                oRoomTransition.banner_subtitle = "Overlord kembali kebal sihir! Tebas dengan pedang melee!";
                oRoomTransition.banner_timer = 90;
                oRoomTransition.screen_shake = 8;
            }
        }
    }
    
    // Status Terhuyung (Staggered Window)
    if (is_staggered) {
        stagger_timer--;
        sprite_index = sBoss_Overlord_Hurt;
        image_speed = 0.08;
        if (stagger_timer <= 0) {
            is_staggered = false;
            state = STATE_IDLE;
            state_timer = 30;
        }
    } else {
        // STATE MACHINE TAHAP 1
        var _dist_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
        
        // Cooldown Timer
        if (melee_cooldown > 0) melee_cooldown--;
        if (magic_timer > 0) magic_timer--;
        if (meteor_timer > 0) meteor_timer--;
        
        switch (state) {
            case STATE_IDLE:
                sprite_index = sBoss_Overlord_Idle;
                image_speed = 0.10;
                state_timer--;
                
                if (state_timer <= 0) {
                    if (_dist_to_player < 75 && melee_cooldown <= 0) {
                        state = STATE_MELEE;
                        sprite_index = sBoss_Overlord_Attack_Melee;
                        image_index = 0;
                        image_speed = 0.15;
                        state_timer = 40;
                    } else if (meteor_timer <= 0) {
                        state = STATE_METEOR;
                        sprite_index = sBoss_Overlord_Skill_Meteor;
                        image_index = 0;
                        image_speed = 0.12;
                        state_timer = 60;
                        meteor_timer = 200;
                    } else if (magic_timer <= 0) {
                        state = STATE_MAGIC;
                        sprite_index = sBoss_Overlord_Attack_Magic;
                        image_index = 0;
                        image_speed = 0.14;
                        state_timer = 45;
                        magic_timer = 120;
                    } else {
                        state = STATE_CHASE;
                        state_timer = 90;
                    }
                }
                break;
                
            case STATE_CHASE:
                sprite_index = sBoss_Overlord_Walk;
                image_speed = 0.12;
                state_timer--;
                
                // Bergerak Mendekati Pemain
                var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
                var _vx = lengthdir_x(move_speed, _dir);
                var _vy = lengthdir_y(move_speed, _dir);
                
                // Batasi gerakan di dalam platform arena melingkar (elips 270 x 170)
                var _nx = x + _vx;
                var _ny = y + _vy;
                var _ellipse_norm = sqr((_nx - 640) / 265) + sqr((_ny - 448) / 165);
                var _is_upper_dais = (_nx >= 540 && _nx <= 740 && _ny >= 200 && _ny <= 320);
                
                if (_ellipse_norm <= 1.0 || _is_upper_dais) {
                    x = _nx;
                    y = _ny;
                }
                
                if (_dist_to_player < 70 && melee_cooldown <= 0) {
                    state = STATE_MELEE;
                    sprite_index = sBoss_Overlord_Attack_Melee;
                    image_index = 0;
                    image_speed = 0.15;
                    state_timer = 40;
                } else if (state_timer <= 0) {
                    state = STATE_IDLE;
                    state_timer = 20;
                }
                break;
                
            case STATE_MELEE:
                // Tebasan Sabit Kegelapan (Scythe Slash Combo)
                if (image_index >= 2 && !scythe_active) {
                    scythe_active = true;
                    if (_dist_to_player < 85) {
                        with (oPlayer) {
                            if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                                scr_player_trigger_perfect_dodge(other.x, other.y);
                            } else if (invincible_timer <= 0) {
                                global.player_hp = max(0, global.player_hp - other.attack_power);
                                invincible_timer = 30;
                                if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 8;
                            }
                        }
                    }
                }
                
                if (image_index >= image_number - 1) {
                    scythe_active = false;
                    melee_cooldown = 70;
                    state = STATE_IDLE;
                    state_timer = 25;
                }
                break;
                
            case STATE_MAGIC:
                // Tembakan Bola Sihir Portal Blast
                if (floor(image_index) == 3 && array_length(magic_orbs) < 3) {
                    var _pdir = point_direction(x, y - 40, oPlayer.x, oPlayer.y);
                    for (var _a = -15; _a <= 15; _a += 15) {
                        var _ang = _pdir + _a;
                        array_push(magic_orbs, {
                            xx: x,
                            yy: y - 40,
                            vx: lengthdir_x(3.8, _ang),
                            vy: lengthdir_y(3.8, _ang),
                            radius: 8,
                            life: 140
                        });
                    }
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 4;
                }
                
                if (image_index >= image_number - 1) {
                    state = STATE_IDLE;
                    state_timer = 30;
                }
                break;
                
            case STATE_METEOR:
                // Panggilan Hujan Meteor Kristal
                if (floor(image_index) == 2 && array_length(meteors) == 0) {
                    // Panggil 3 meteor di sekitar pemain
                    array_push(meteors, { xx: oPlayer.x, yy: 0, target_y: oPlayer.y, radius: 36, timer: 45, impact: false });
                    array_push(meteors, { xx: oPlayer.x + irandom_range(-80, 80), yy: 0, target_y: oPlayer.y + irandom_range(-60, 60), radius: 32, timer: 60, impact: false });
                    array_push(meteors, { xx: oPlayer.x + irandom_range(-100, 100), yy: 0, target_y: oPlayer.y + irandom_range(-70, 70), radius: 32, timer: 75, impact: false });
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 6;
                }
                
                if (image_index >= image_number - 1) {
                    state = STATE_IDLE;
                    state_timer = 35;
                }
                break;
                
            case STATE_HURT:
                state_timer--;
                if (state_timer <= 0) {
                    state = STATE_IDLE;
                    state_timer = 20;
                }
                break;
        }
    }
}
// =========================================================================
// TAHAP 2: THE TRUE CORRUPTED GUARDIAN (Roh Penjaga Purba / Crimson Phantom)
// =========================================================================
else if (boss_stage == 2) {
    spirit_aura_anim += 0.08;
    
    // Jejak Bayangan Phantom
    array_push(shadow_trail, { xx: x, yy: y, alpha: 1.0, radius: 24 });
    for (var _s = array_length(shadow_trail) - 1; _s >= 0; _s--) {
        shadow_trail[_s].alpha -= 0.06;
        if (shadow_trail[_s].alpha <= 0) array_delete(shadow_trail, _s, 1);
    }
    
    // Pergerakan Mengejar Pemain dengan Kecepatan Tinggi
    var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _vx = lengthdir_x(move_speed, _dir);
    var _vy = lengthdir_y(move_speed, _dir);
    
    var _nx = x + _vx;
    var _ny = y + _vy;
    var _ellipse_norm = sqr((_nx - 640) / 265) + sqr((_ny - 448) / 165);
    var _is_upper_dais = (_nx >= 540 && _nx <= 740 && _ny >= 200 && _ny <= 320);
    if (_ellipse_norm <= 1.0 || _is_upper_dais) {
        x = _nx;
        y = _ny;
    }
    
    // Teleportasi Kilat saat Jarak Terlalu Jauh
    teleport_timer--;
    if (teleport_timer <= 0) {
        teleport_timer = 140;
        var _t_ang = random(360);
        var _tx = oPlayer.x + lengthdir_x(85, _t_ang);
        var _ty = oPlayer.y + lengthdir_y(85, _t_ang);
        var _t_norm = sqr((_tx - 640) / 260) + sqr((_ty - 448) / 160);
        if (_t_norm <= 1.0) {
            x = _tx;
            y = _ty;
            if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 5;
        }
    }
    
    // Gelombang Kejut Kegelapan (Spirit Pulse)
    spirit_pulse_timer--;
    if (spirit_pulse_timer <= 0) {
        spirit_pulse_timer = 160;
        spirit_pulse_r = 10;
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 8;
    }
    
    if (spirit_pulse_r > 0) {
        spirit_pulse_r += 4.5;
        if (point_distance(x, y, oPlayer.x, oPlayer.y) < spirit_pulse_r + 15 && point_distance(x, y, oPlayer.x, oPlayer.y) > spirit_pulse_r - 20) {
            with (oPlayer) {
                if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                    scr_player_trigger_perfect_dodge(other.x, other.y);
                } else if (invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - 18);
                    invincible_timer = 25;
                }
            }
        }
        if (spirit_pulse_r > 130) spirit_pulse_r = 0;
    }
    
    // Hujan Pedang Roh Meluncur (Phantom Swords)
    sword_barrage_timer--;
    if (sword_barrage_timer <= 0) {
        sword_barrage_timer = 90;
        for (var _p = 0; _p < 4; _p++) {
            var _ang = point_direction(x, y, oPlayer.x, oPlayer.y) + (_p - 1.5) * 18;
            array_push(phantom_swords, {
                xx: x,
                yy: y - 20,
                vx: lengthdir_x(4.5, _ang),
                vy: lengthdir_y(4.5, _ang),
                ang: _ang,
                life: 120
            });
        }
    }
    
    // Buka Segel Darah Iblis [F]
    if (keyboard_check_pressed(ord("F")) && !global.demon_unsealed && hp > 0) {
        if (global.player_hp > 30) {
            global.player_hp -= 30;
            global.demon_unsealed = true;
            take_damage(220, 0, true);
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "SEGEL DARAH IBLIS DIBUKA!";
                oRoomTransition.banner_subtitle = "Darah dikorbankan! Tebasan mata merah membelah wujud roh kutukan!";
                oRoomTransition.banner_timer = 180;
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

// =========================================================================
// UPDATE PROYEKTIL: MAGIC ORBS & METEORS & PHANTOM SWORDS
// =========================================================================
// 1. Bola Sihir Gelap
for (var _o = array_length(magic_orbs) - 1; _o >= 0; _o--) {
    var _orb = magic_orbs[_o];
    _orb.xx += _orb.vx;
    _orb.yy += _orb.vy;
    _orb.life--;
    
    if (point_distance(_orb.xx, _orb.yy, oPlayer.x, oPlayer.y) < _orb.radius + 14) {
        with (oPlayer) {
            if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                scr_player_trigger_perfect_dodge(_orb.xx, _orb.yy);
            } else if (invincible_timer <= 0) {
                global.player_hp = max(0, global.player_hp - 16);
                invincible_timer = 25;
                if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 5;
            }
        }
        _orb.life = 0;
    }
    
    if (_orb.life <= 0) array_delete(magic_orbs, _o, 1);
}

// 2. Meteor Kristal Langit
for (var _m = array_length(meteors) - 1; _m >= 0; _m--) {
    var _met = meteors[_m];
    _met.timer--;
    
    if (_met.timer <= 0 && !_met.impact) {
        _met.impact = true;
        _met.timer = 20; // Waktu ledakan
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 9;
        
        if (point_distance(_met.xx, _met.target_y, oPlayer.x, oPlayer.y) < _met.radius + 12) {
            with (oPlayer) {
                if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                    scr_player_trigger_perfect_dodge(_met.xx, _met.target_y);
                } else if (invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - 24);
                    invincible_timer = 30;
                }
            }
        }
    } else if (_met.impact && _met.timer <= 0) {
        array_delete(meteors, _m, 1);
    }
}

// 3. Pedang Roh (Phase 2)
for (var _sw = array_length(phantom_swords) - 1; _sw >= 0; _sw--) {
    var _ps = phantom_swords[_sw];
    _ps.xx += _ps.vx;
    _ps.yy += _ps.vy;
    _ps.life--;
    
    if (point_distance(_ps.xx, _ps.yy, oPlayer.x, oPlayer.y) < 16) {
        with (oPlayer) {
            if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                scr_player_trigger_perfect_dodge(_ps.xx, _ps.yy);
            } else if (invincible_timer <= 0) {
                global.player_hp = max(0, global.player_hp - 16);
                invincible_timer = 24;
            }
        }
        _ps.life = 0;
    }
    
    if (_ps.life <= 0) array_delete(phantom_swords, _sw, 1);
}
