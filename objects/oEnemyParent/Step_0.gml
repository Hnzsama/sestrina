/// @description Step Event - AI & Animasi Musuh (Floor 1 Mechanics)

anim_timer += 0.08;
if (flash_timer > 0) flash_timer--;
if (attack_cooldown > 0) attack_cooldown--;

// Jika sedang mati (memainkan animasi die)
if (is_dead) {
    die_timer--;
    if (die_timer <= 0) {
        on_death();
    }
    exit;
}

// Jika sedang terkena hit (animasi hurt)
if (state == "hurt") {
    hurt_timer--;
    if (hurt_timer <= 0) {
        state = "idle";
        if (spr_idle != noone) sprite_index = spr_idle;
    }
    exit;
}

// Jika sedang menyerang (animasi attack)
if (state == "attack") {
    attack_timer--;
    if (attack_timer <= 0) {
        state = "idle";
        if (spr_idle != noone) sprite_index = spr_idle;
    }
    exit;
}

if (global.dialogue_active || !instance_exists(oPlayer)) {
    if (spr_idle != noone && sprite_index != spr_idle) {
        sprite_index = spr_idle;
        image_speed = 0.15;
    }
    exit;
}

var _dist = distance_to_object(oPlayer);

// Menghadap ke arah pemain secara proporsional sesuai base_xscale
if (oPlayer.x < x) {
    image_xscale = -abs(base_xscale);
} else {
    image_xscale = abs(base_xscale);
}
image_yscale = base_yscale;

// Deteksi pemain dalam jarak 220 pixel -> Kejar (Walk)
var _is_moving = false;
if (_dist < 220 && _dist > 16) {
    var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _nx = x + lengthdir_x(move_speed, _dir);
    var _ny = y + lengthdir_y(move_speed, _dir);
    
    if (!scr_check_collision(_nx, _ny)) {
        x = _nx;
        y = _ny;
        _is_moving = true;
    }
}

// Update animasi idle vs walk
if (_is_moving) {
    state = "walk";
    if (spr_walk != noone && sprite_index != spr_walk) {
        sprite_index = spr_walk;
        image_speed = 0.18;
    }
} else {
    state = "idle";
    if (spr_idle != noone && sprite_index != spr_idle) {
        sprite_index = spr_idle;
        image_speed = 0.12;
    }
}

// Serang pemain jika menempel dan attack_cooldown siap
if (_dist <= 20 && attack_cooldown <= 0) {
    attack_cooldown = 50;
    state = "attack";
    attack_timer = 22;
    if (spr_attack != noone) {
        sprite_index = spr_attack;
        image_index = 0;
        image_speed = 0.22;
    }
    
    var _can_damage = true;
    if (instance_exists(oPlayer)) {
        if (variable_instance_exists(oPlayer, "is_rolling") && oPlayer.is_rolling) {
            _can_damage = false;
            // Berhasil menghindar saat serangan terjadi -> Picu Perfect Dodge!
            with (oPlayer) {
                scr_player_trigger_perfect_dodge(other.x, other.y);
            }
        } else if (oPlayer.invincible_timer > 0) {
            _can_damage = false;
        }
    }
    
    if (_can_damage) {
        global.player_hp = max(0, global.player_hp - attack_power);
        
        // Player flinch & beri i-frames sejenak agar tidak kena hit bertubi-tubi
        with (oPlayer) {
            var _kdir = point_direction(other.x, other.y, x, y);
            x += lengthdir_x(8, _kdir);
            y += lengthdir_y(8, _kdir);
            invincible_timer = 20;
        }
    }
}
