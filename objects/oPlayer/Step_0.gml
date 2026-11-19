// Auto-unstick jika di luar batas aman kamar Room1 dari save file lama
if (room_get_name(room) == "Room1" && (x < 210 || x > 1070 || y < 165 || y > 645)) {
    x = 640;
    y = 420;
}

// 0. Cek Kematian / Pingsan Pemain (UAS Defeat & Respawn Handling)
if (global.player_hp <= 0) {
    if (!is_defeated) {
        is_defeated = true;
        defeat_timer = 100;
        image_blend = c_gray;
        image_speed = 0;
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "KAMU TERKAPAR!";
            oRoomTransition.banner_subtitle = "Daya tahanmu runtuh... Kembali sadar di ranjang Sestrina.";
            oRoomTransition.banner_timer = 180;
            oRoomTransition.screen_shake = 8;
        }
    }
    
    defeat_timer--;
    if (defeat_timer == 25) {
        if (instance_exists(oRoomTransition)) {
            var _tr = instance_find(oRoomTransition, 0);
            _tr.start_transition(Room1, 345, 225, "Kamar Sestrina", "Kembali Sadar Setelah Terkapar");
        }
    } else if (defeat_timer <= 0) {
        global.player_hp = global.player_max_hp;
        global.player_mp = global.player_max_mp;
        global.player_stamina = global.player_max_stamina;
        is_defeated = false;
        image_blend = c_white;
        scr_advance_time(); // Memajukan siklus hari/malam sebagai konsekuensi waktu
    }
    exit;
}

// 0.5. Micro Hitstop saat Perfect Dodge Terjadi (Sensasi Freeze-Frame Bayonetta/Zelda)
if (hitstop_timer > 0) {
    hitstop_timer--;
    if (perfect_dodge_ring_alpha > 0) {
        perfect_dodge_ring_rad += 4.5;
        perfect_dodge_ring_alpha -= 0.08;
    }
    if (perfect_dodge_text_alpha > 0) {
        perfect_dodge_text_y -= 0.9;
        perfect_dodge_text_alpha -= 0.035;
    }
    for (var _sp = array_length(perfect_sparks) - 1; _sp >= 0; _sp--) {
        perfect_sparks[_sp].xx += perfect_sparks[_sp].vx;
        perfect_sparks[_sp].yy += perfect_sparks[_sp].vy;
        perfect_sparks[_sp].alpha -= 0.07;
        if (perfect_sparks[_sp].alpha <= 0) array_delete(perfect_sparks, _sp, 1);
    }
    exit;
}

// Hentikan pergerakan pemain jika sedang dalam dialog atau membuka menu status/toko/save/map/konfirmasi
if ((variable_global_exists("dialogue_active") && global.dialogue_active) || 
    (variable_global_exists("main_menu_open") && global.main_menu_open) ||
    (variable_global_exists("stat_menu_open") && global.stat_menu_open) || 
    (variable_global_exists("save_menu_open") && global.save_menu_open) || 
    (variable_global_exists("map_menu_open") && global.map_menu_open) || 
    (variable_global_exists("leave_confirm_active") && global.leave_confirm_active) || 
    (variable_global_exists("shop_menu_open") && global.shop_menu_open != "")) {
    image_speed = 0;
    exit;
}

scr_player_input();   // Input pengguna

// 1. Regenerasi Stamina & Mana Otomatis
if (!is_rolling && attack_cooldown <= 0 && is_casting <= 0 && is_drinking <= 0 && global.player_stamina < global.player_max_stamina) {
    global.player_stamina = min(global.player_max_stamina, global.player_stamina + 0.65 + (global.stat_agi * 0.04));
}
if (global.player_mp < global.player_max_mp) {
    global.player_mp = min(global.player_max_mp, global.player_mp + 0.12 + (global.stat_int * 0.03));
}

// 2. Pengurangan Timer Status & Efek Perfect Dodge
if (invincible_timer > 0) invincible_timer--;
if (perfect_dodge_cooldown > 0) perfect_dodge_cooldown--;
if (perfect_dodge_timer > 0) perfect_dodge_timer--;
if (perfect_dodge_flash > 0) perfect_dodge_flash--;
if (counter_boost_timer > 0) {
    counter_boost_timer--;
    if (counter_boost_timer <= 0) counter_boost_active = false;
}
if (perfect_dodge_ring_alpha > 0) {
    perfect_dodge_ring_rad += 3.8;
    perfect_dodge_ring_alpha -= 0.055;
}
if (perfect_dodge_text_alpha > 0) {
    perfect_dodge_text_y -= 0.85;
    perfect_dodge_text_alpha -= 0.035;
}
for (var _sp = array_length(perfect_sparks) - 1; _sp >= 0; _sp--) {
    perfect_sparks[_sp].xx += perfect_sparks[_sp].vx;
    perfect_sparks[_sp].yy += perfect_sparks[_sp].vy;
    perfect_sparks[_sp].vx *= 0.94;
    perfect_sparks[_sp].vy *= 0.94;
    perfect_sparks[_sp].alpha -= 0.05;
    if (perfect_sparks[_sp].alpha <= 0) array_delete(perfect_sparks, _sp, 1);
}

if (attack_cooldown > 0) attack_cooldown--;
if (spell_cooldown > 0) spell_cooldown--;
if (is_attacking > 0) is_attacking--;
if (combo_timer > 0) {
    combo_timer--;
    if (combo_timer <= 0) combo_step = 0;
}

// Update Bayangan Ghost Trail
for (var _i = array_length(ghost_trail) - 1; _i >= 0; _i--) {
    ghost_trail[_i].alpha -= 0.08;
    if (ghost_trail[_i].alpha <= 0) {
        array_delete(ghost_trail, _i, 1);
    }
}

// =========================================================================
// 3. LOGIKA DODGE ROLL (Folder 02_dodge_roll: spr_player_roll_*)
// =========================================================================
if (is_rolling) {
    roll_timer--;
    
    // Pilih arah sprite roll sesuai sudut luncuran
    if (roll_dir > 45 && roll_dir < 135) {
        sprite_index = spr_roll.up;
        image_xscale = 1.0;
    } else if (roll_dir >= 135 && roll_dir <= 225) {
        sprite_index = spr_roll.side;
        image_xscale = 1.0; // Hadap kiri (asli sprite)
    } else if (roll_dir > 225 && roll_dir < 315) {
        sprite_index = spr_roll.down;
        image_xscale = 1.0;
    } else {
        sprite_index = spr_roll.side;
        image_xscale = -1.0; // Hadap kanan (mirror horizontal)
    }
    
    // Sinkronisasi 6 frame animasi guling sempurna dengan durasi roll (18 step)
    var _prog_roll = 1.0 - (roll_timer / 18);
    image_index = clamp(floor(_prog_roll * 6), 0, 5);
    image_speed = 0;
    
    // Spawn jejak bayangan (ghost trail) dengan warna emas saat perfect dodge
    if (roll_timer mod 2 == 0) {
        var _gcol = (perfect_dodge_timer > 0) ? make_color_rgb(255, 225, 80) : make_color_rgb(130, 220, 255);
        array_push(ghost_trail, {
            xx: x,
            yy: y,
            alpha: 0.85,
            spr: sprite_index,
            sub: image_index,
            xsc: image_xscale,
            ysc: image_yscale,
            col: _gcol
        });
    }
    
    // Terapkan pergerakan luncuran roll
    var _rx = lengthdir_x(roll_speed, roll_dir);
    var _ry = lengthdir_y(roll_speed, roll_dir);
    
    if (!scr_check_collision(x + _rx, y)) x += _rx;
    if (!scr_check_collision(x, y + _ry)) y += _ry;
    
    if (roll_timer <= 0) {
        is_rolling = false;
    }
    
    // Fade ghost trail
    for (var _k = array_length(ghost_trail) - 1; _k >= 0; _k--) {
        ghost_trail[_k].alpha -= 0.08;
        if (ghost_trail[_k].alpha <= 0) {
            array_delete(ghost_trail, _k, 1);
        }
    }
} else if (is_drinking > 0) {
    // =========================================================================
    // 3.5. LOGIKA MINUM RAMUAN 4-ARAH (Folder 05_potion_drink: spr_player_drink_potion_*)
    // =========================================================================
    is_drinking--;
    
    if (facingDir == "up") {
        sprite_index = spr_drink.up;
        image_xscale = 1.0;
    } else if (facingDir == "left") {
        sprite_index = spr_drink.side;
        image_xscale = 1.0; // Hadap kiri (asli sprite)
    } else if (facingDir == "right") {
        sprite_index = spr_drink.side;
        image_xscale = -1.0; // Hadap kanan (mirror horizontal)
    } else {
        sprite_index = spr_drink.down;
        image_xscale = 1.0;
    }
    
    var _prog_drink = 1.0 - (is_drinking / 24);
    image_index = clamp(floor(_prog_drink * 6), 0, 5);
    image_speed = 0;
    
    // Terapkan efek penyembuhan di pertengahan animasi (frame ke-3)
    if (is_drinking == 12) {
        scr_heal_player(45);
    }
} else if (is_casting > 0) {
    // =========================================================================
    // 3.6. LOGIKA MERAPAL SIHIR 4-ARAH (Folder 04_magic_cast: spr_player_cast_*)
    // =========================================================================
    is_casting--;
    var _c_struct = (cast_type == 1) ? spr_cast_fire : spr_cast_frost;
    
    if (facingDir == "up") {
        sprite_index = _c_struct.up;
        image_xscale = 1.0;
    } else if (facingDir == "left") {
        sprite_index = _c_struct.side;
        image_xscale = 1.0; // Hadap kiri (asli sprite)
    } else if (facingDir == "right") {
        sprite_index = _c_struct.side;
        image_xscale = -1.0; // Hadap kanan (mirror horizontal)
    } else {
        sprite_index = _c_struct.down;
        image_xscale = 1.0;
    }
    
    var _prog_cast = 1.0 - (is_casting / 20);
    image_index = clamp(floor(_prog_cast * 6), 0, 5);
    image_speed = 0;
    
    // Lepaskan proyektil sihir di puncak pose (frame ke-3 / step 10)
    if (is_casting == 10) {
        var _cast_dir = 270;
        if (facingDir == "up") _cast_dir = 90;
        else if (facingDir == "down") _cast_dir = 270;
        else if (facingDir == "right") _cast_dir = 0;
        else if (facingDir == "left") _cast_dir = 180;
        else if (facingDir == "side") _cast_dir = (image_xscale >= 0) ? 180 : 0;
        
        if (cast_type == 1) {
            var _fb = instance_create_depth(x + lengthdir_x(16, _cast_dir), y + lengthdir_y(16, _cast_dir), depth - 10, oSpellFireball);
            _fb.fire_dir = _cast_dir;
        } else if (cast_type == 2) {
            instance_create_depth(x, y, depth - 10, oSpellFrostNova);
        }
    }
} else {
    // 4. Pemicu Dodge Roll [Shift] (No Hitbox & Mekanik Perfect Dodge)
    if (keyActive && global.player_stamina >= 25 && is_attacking <= 0) {
        global.player_stamina -= 25;
        is_rolling = true;
        roll_timer = 18;
        invincible_timer = 24; // Penuh kebal hitbox selama guling + 6 frame buffer
        roll_dir = inputMagnitude ? inputDirection : ((facingDir == "up") ? 90 : ((facingDir == "side") ? ((image_xscale >= 0) ? 180 : 0) : 270));
        
        // Cek apakah pemain melakukan dodge saat berada dalam jarak bahaya musuh (Close-Call Evade)
        var _n_enemy = instance_nearest(x, y, oEnemyParent);
        var _n_boss  = instance_nearest(x, y, oBossGolem);
        var _danger_found = false;
        var _hx = x;
        var _hy = y;
        
        if (_n_enemy != noone && distance_to_object(_n_enemy) <= 45) {
            _danger_found = true;
            _hx = _n_enemy.x;
            _hy = _n_enemy.y;
        } else if (_n_boss != noone && distance_to_object(_n_boss) <= 75) {
            _danger_found = true;
            _hx = _n_boss.x;
            _hy = _n_boss.y;
        }
        
        if (_danger_found) {
            scr_player_trigger_perfect_dodge(_hx, _hy);
        }
    }
    
    // 4.5. Pemicu Minum Ramuan Pemulih [C]
    if (keyItem && global.player_potions > 0 && global.player_hp < global.player_max_hp && is_attacking <= 0) {
        global.player_potions--;
        is_drinking = 24;
        sprite_index = (facingDir == "up") ? spr_drink.up : ((facingDir == "down") ? spr_drink.down : spr_drink.side);
        image_index = 0;
        image_speed = 0;
    }
    
    // Cek apakah pemain sedang dekat dengan objek interaksi (NPC, Peti, dsb.)
    var _can_interact_target = false;
    if (instance_exists(oInteractableParent)) {
        var _n_int = instance_nearest(x, y, oInteractableParent);
        if (_n_int != noone && distance_to_object(_n_int) <= _n_int.interact_range) {
            _can_interact_target = true;
        }
    }
    if (!_can_interact_target && instance_exists(oCompanion_Goran)) {
        var _n_gor = instance_nearest(x, y, oCompanion_Goran);
        if (_n_gor != noone && point_distance(x, y, _n_gor.x, _n_gor.y) <= _n_gor.interact_range && _n_gor.is_player_near) {
            _can_interact_target = true;
        }
    }
    if (!_can_interact_target && instance_exists(oDecorCatacombs)) {
        var _n_dec = instance_nearest(x, y, oDecorCatacombs);
        if (_n_dec != noone && !_n_dec.gate_opened && point_distance(x, y, _n_dec.switch_x, _n_dec.switch_y) < 42) {
            _can_interact_target = true;
        }
    }
    
    // =========================================================================
    // 5. SERANG KOMBO 3-HIT PEDANG [Z] (Folder 03_attack_combo: spr_player_combo*)
    // =========================================================================
    if (keyAttack && !_can_interact_target && global.player_has_sword && attack_cooldown <= 0 && global.player_stamina >= 10 && is_drinking <= 0 && is_casting <= 0) {
        if (combo_timer > 0) {
            combo_step = (combo_step mod 3) + 1;
        } else {
            combo_step = 1;
        }
        
        var _base_atk = scr_get_player_atk();
        var _cost = 10;
        var _dmg = _base_atk;
        var _cd = 14;
        var _window = 30;
        var _atk_dur = 14;
        
        if (combo_step == 2) {
            _cost = 12;
            _dmg = round(_base_atk * 1.45);
            _cd = 16;
            _window = 32;
            _atk_dur = 16;
        } else if (combo_step == 3) {
            _cost = 18;
            _dmg = round(_base_atk * 2.3);
            _cd = 22;
            _window = 0; // Kombo selesai setelah finisher
            _atk_dur = 22;
        }
        
        global.player_stamina = max(0, global.player_stamina - _cost);
        attack_cooldown = _cd;
        combo_timer = _window;
        is_attacking = _atk_dur;
        
        var _dir = 270;
        if (facingDir == "up") _dir = 90;
        else if (facingDir == "down") _dir = 270;
        else if (facingDir == "right") _dir = 0;
        else if (facingDir == "left") _dir = 180;
        else if (facingDir == "side") _dir = (image_xscale >= 0) ? 180 : 0;
        
        attack_dir = _dir;
        
        // Momentum langkah mengayun pedang diperpanjang agar terasa bertenaga dan menjangkau musuh
        var _lunge = (combo_step == 3) ? 9.0 : ((combo_step == 2) ? 6.5 : 5.0);
        var _lx = x + lengthdir_x(_lunge, _dir);
        var _ly = y + lengthdir_y(_lunge, _dir);
        if (!scr_check_collision(_lx, _ly)) {
            x = _lx;
            y = _ly;
        }
        
        // Jarak tebasan diperpanjang agar selaras dengan bilah pedang 28-32px yang lebih panjang
        var _slash_dist = (combo_step == 3) ? 32 : ((combo_step == 2) ? 28 : 25);
        var _slash_x = x + lengthdir_x(_slash_dist, _dir);
        var _slash_y = y + lengthdir_y(_slash_dist, _dir);
        
        // Bonus Serangan Balasan jika Counter Boost Aktif dari Perfect Dodge
        var _is_counter = false;
        if (counter_boost_active) {
            _dmg = round(_dmg * 1.5); // +50% Bonus Kerusakan Pedang
            counter_boost_active = false;
            counter_boost_timer = 0;
            _is_counter = true;
        }
        
        var _inst = instance_create_depth(_slash_x, _slash_y, depth - 10, oPlayerSlash);
        _inst.slash_dir = _dir;
        _inst.combo_index = combo_step;
        _inst.slash_damage = _dmg;
        _inst.is_counter = _is_counter;
    }
    
    // Perbarui Animasi Serangan Kombo yang Sedang Berjalan
    if (is_attacking > 0) {
        if (combo_step == 1) {
            var _prog_c1 = 1.0 - (is_attacking / 14);
            image_index = clamp(floor(_prog_c1 * 4), 0, 3);
            if (facingDir == "up") { sprite_index = spr_combo1.up; image_xscale = 1.0; }
            else if (facingDir == "left") { sprite_index = spr_combo1.side; image_xscale = 1.0; }
            else if (facingDir == "down") { sprite_index = spr_combo1.down; image_xscale = 1.0; }
            else { sprite_index = spr_combo1.side; image_xscale = -1.0; }
        } else if (combo_step == 2) {
            var _prog_c2 = 1.0 - (is_attacking / 16);
            image_index = clamp(floor(_prog_c2 * 4), 0, 3);
            if (facingDir == "up") { sprite_index = spr_combo2.up; image_xscale = 1.0; }
            else if (facingDir == "left") { sprite_index = spr_combo2.side; image_xscale = 1.0; }
            else if (facingDir == "down") { sprite_index = spr_combo2.down; image_xscale = 1.0; }
            else { sprite_index = spr_combo2.side; image_xscale = -1.0; }
        } else if (combo_step == 3) {
            var _prog_c3 = 1.0 - (is_attacking / 22);
            image_index = clamp(floor(_prog_c3 * 8), 0, 7);
            sprite_index = spr_combo3;
            image_xscale = 1.0;
        }
        image_speed = 0;
    }
    
    // 6. Ganti Pilihan Mantra [Q]
    if (keyboard_check_pressed(ord("Q"))) {
        if (global.spell_unlocked_fireball && global.spell_unlocked_frost) {
            global.spell_selected = (global.spell_selected == 1) ? 2 : 1;
        } else if (global.spell_unlocked_fireball) {
            global.spell_selected = 1;
        } else if (global.spell_unlocked_frost) {
            global.spell_selected = 2;
        }
    }
    
    // 7. Lancarkan Mantra Sihir [X]
    if (keyMagic && spell_cooldown <= 0 && is_attacking <= 0 && is_drinking <= 0) {
        if (global.spell_selected == 1 && global.spell_unlocked_fireball && global.player_mp >= 20) {
            global.player_mp -= 20;
            spell_cooldown = 26;
            is_casting = 20;
            cast_type = 1;
            sprite_index = (facingDir == "up") ? spr_cast_fire.up : ((facingDir == "down") ? spr_cast_fire.down : spr_cast_fire.side);
            image_index = 0;
            image_speed = 0;
        } else if (global.spell_selected == 2 && global.spell_unlocked_frost && global.player_mp >= 28) {
            global.player_mp -= 28;
            spell_cooldown = 32;
            is_casting = 20;
            cast_type = 2;
            sprite_index = (facingDir == "up") ? spr_cast_frost.up : ((facingDir == "down") ? spr_cast_frost.down : spr_cast_frost.side);
            image_index = 0;
            image_speed = 0;
        }
    }
    
    event_inherited(); // Pergerakan & animasi standar (scr_animation_update)
}