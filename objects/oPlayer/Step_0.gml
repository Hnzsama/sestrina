// Hentikan pergerakan pemain jika sedang dalam dialog atau membuka menu status/toko
if ((variable_global_exists("dialogue_active") && global.dialogue_active) || 
    (variable_global_exists("stat_menu_open") && global.stat_menu_open) || 
    (variable_global_exists("shop_menu_open") && global.shop_menu_open != "")) {
    image_speed = 0;
    exit;
}

scr_player_input();   // Input pengguna

// 1. Regenerasi Stamina & Mana Otomatis
if (!is_rolling && attack_cooldown <= 0 && global.player_stamina < global.player_max_stamina) {
    global.player_stamina = min(global.player_max_stamina, global.player_stamina + 0.65 + (global.stat_agi * 0.04));
}
if (global.player_mp < global.player_max_mp) {
    global.player_mp = min(global.player_max_mp, global.player_mp + 0.12 + (global.stat_int * 0.03));
}

// 2. Pengurangan Timer Status
if (invincible_timer > 0) invincible_timer--;
if (attack_cooldown > 0) attack_cooldown--;
if (spell_cooldown > 0) spell_cooldown--;
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

// 3. Logika Dodge Roll (Menghindar Cepat dengan i-Frames)
if (is_rolling) {
    roll_timer--;
    
    // Spawn jejak bayangan (ghost trail)
    if (roll_timer mod 2 == 0) {
        array_push(ghost_trail, {
            xx: x,
            yy: y,
            alpha: 0.7,
            spr: sprite_index,
            sub: image_index,
            xsc: image_xscale,
            ysc: image_yscale
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
} else {
    // 4. Pemicu Dodge Roll [Space]
    var _near_interact = false;
    if (instance_exists(oInteractableParent)) {
        var _nearest_int = instance_nearest(x, y, oInteractableParent);
        if (_nearest_int != noone && point_distance(x, y, _nearest_int.x, _nearest_int.y) < 32) {
            _near_interact = true;
        }
    }
    
    if (keyActive && !_near_interact && global.player_stamina >= 25) {
        global.player_stamina -= 25;
        is_rolling = true;
        roll_timer = 14;
        invincible_timer = 14;
        roll_dir = inputMagnitude ? inputDirection : ((facingDir == "up") ? 90 : ((facingDir == "side") ? ((image_xscale >= 0) ? 0 : 180) : 270));
    }
    
    // 5. Serang Musuh dengan Kombo 3-Hit Pedang [Z] (Skala Stat STR & Tier Senjata)
    if (keyAttack && global.player_has_sword && attack_cooldown <= 0 && global.player_stamina >= 10) {
        if (combo_timer > 0) {
            combo_step = (combo_step mod 3) + 1;
        } else {
            combo_step = 1;
        }
        
        var _base_atk = scr_get_player_atk();
        var _cost = 10;
        var _dmg = _base_atk;
        var _cd = 10;
        var _window = 30;
        
        if (combo_step == 2) {
            _cost = 12;
            _dmg = round(_base_atk * 1.45);
            _cd = 12;
            _window = 30;
        } else if (combo_step == 3) {
            _cost = 18;
            _dmg = round(_base_atk * 2.3);
            _cd = 20;
            _window = 0; // Kombo selesai setelah finisher
        }
        
        global.player_stamina = max(0, global.player_stamina - _cost);
        attack_cooldown = _cd;
        combo_timer = _window;
        
        var _dir = 270;
        if (facingDir == "up") _dir = 90;
        else if (facingDir == "side") _dir = (image_xscale >= 0) ? 0 : 180;
        else if (facingDir == "down") _dir = 270;
        
        var _slash_x = x + lengthdir_x(18, _dir);
        var _slash_y = y + lengthdir_y(18, _dir);
        
        var _inst = instance_create_depth(_slash_x, _slash_y, depth - 10, oPlayerSlash);
        _inst.slash_dir = _dir;
        _inst.combo_index = combo_step;
        _inst.slash_damage = _dmg;
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
    if (keyMagic && spell_cooldown <= 0) {
        var _cast_dir = 270;
        if (facingDir == "up") _cast_dir = 90;
        else if (facingDir == "side") _cast_dir = (image_xscale >= 0) ? 0 : 180;
        else if (facingDir == "down") _cast_dir = 270;
        
        if (global.spell_selected == 1 && global.spell_unlocked_fireball && global.player_mp >= 20) {
            global.player_mp -= 20;
            spell_cooldown = 24;
            var _fb = instance_create_depth(x + lengthdir_x(16, _cast_dir), y + lengthdir_y(16, _cast_dir), depth - 10, oSpellFireball);
            _fb.fire_dir = _cast_dir;
        } else if (global.spell_selected == 2 && global.spell_unlocked_frost && global.player_mp >= 28) {
            global.player_mp -= 28;
            spell_cooldown = 32;
            instance_create_depth(x, y, depth - 10, oSpellFrostNova);
        }
    }
    
    event_inherited(); // Pergerakan & animasi standar
}