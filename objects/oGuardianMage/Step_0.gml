/// @description Step Event - Crystal Sorcerer Combat AI & Spell Projectiles

anim_timer += 0.08;
if (flash_timer > 0) flash_timer--;
if (attack_cooldown > 0) attack_cooldown--;

// Update Peluru Sihir (Spells)
for (var _i = array_length(spells) - 1; _i >= 0; _i--) {
    var _sp = spells[_i];
    _sp.xx += _sp.vx;
    _sp.yy += _sp.vy;
    _sp.life--;
    
    // Deteksi tabrakan dengan Player
    if (instance_exists(oPlayer)) {
        if (point_distance(_sp.xx, _sp.yy, oPlayer.x, oPlayer.y - 14) < _sp.radius + 12) {
            with (oPlayer) {
                if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                    scr_player_trigger_perfect_dodge(other.x, other.y);
                } else if (invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - other.attack_power);
                    invincible_timer = 20;
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 3;
                }
            }
            array_delete(spells, _i, 1);
            continue;
        }
    }
    
    if (_sp.life <= 0) {
        array_delete(spells, _i, 1);
    }
}

if (is_dead) {
    die_timer--;
    image_alpha -= 0.03;
    if (die_timer <= 0 || image_alpha <= 0) {
        on_death();
        instance_destroy();
    }
    exit;
}

if (global.dialogue_active || !instance_exists(oPlayer)) {
    sprite_index = spr_idle;
    image_speed = 0.12;
    exit;
}

var _dist = distance_to_object(oPlayer);

// Orientasi hadap pemain
if (state != "attack") {
    if (oPlayer.x < x) {
        image_xscale = -abs(base_xscale);
    } else {
        image_xscale = abs(base_xscale);
    }
}

// -----------------------------------------------------------------------------
// STATE: ATTACK (Rapal Kristal Sihir Ungu)
// -----------------------------------------------------------------------------
if (state == "attack") {
    cast_timer--;
    
    // Tembakkan bola sihir pada frame pertengahan (frame index 2)
    if (floor(image_index) >= 2 && !has_fired) {
        has_fired = true;
        var _s_ang = point_direction(x, y - 30, oPlayer.x, oPlayer.y - 12);
        array_push(spells, {
            xx: x + ((image_xscale < 0) ? -12 : 12),
            yy: y - 30,
            vx: lengthdir_x(4.0, _s_ang),
            vy: lengthdir_y(4.0, _s_ang),
            radius: 7,
            life: 110
        });
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 2;
    }
    
    if (cast_timer <= 0 || image_index >= image_number - 1) {
        state = "idle";
        sprite_index = spr_idle;
        image_speed = 0.12;
        attack_cooldown = irandom_range(75, 110);
    }
    exit;
}

// -----------------------------------------------------------------------------
// KITING & JARAK TEMBAK (Ranged Behavior)
// -----------------------------------------------------------------------------
if (_dist < 75) {
    // Terlalu dekat -> Mundur menjauh dari pemain
    var _dir_away = point_direction(oPlayer.x, oPlayer.y, x, y);
    var _nx = x + lengthdir_x(move_speed, _dir_away);
    var _ny = y + lengthdir_y(move_speed, _dir_away);
    if (clamp_arena(_nx, _ny)) {
        x = _nx;
        y = _ny;
    }
} else if (_dist > 180) {
    // Terlalu jauh -> Maju sedikit mendekat
    var _dir_to = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _nx = x + lengthdir_x(move_speed * 0.7, _dir_to);
    var _ny = y + lengthdir_y(move_speed * 0.7, _dir_to);
    if (clamp_arena(_nx, _ny)) {
        x = _nx;
        y = _ny;
    }
}

// Jika cooldown siap dan berada dalam jangkauan tembak -> Merapal
if (_dist <= 260 && attack_cooldown <= 0) {
    state = "attack";
    cast_timer = 36;
    has_fired = false;
    sprite_index = spr_attack;
    image_index = 0;
    image_speed = 0.18;
}
