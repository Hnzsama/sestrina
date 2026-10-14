/// @description Step Event - AI Sederhana Musuh

anim_timer += 0.08;
if (flash_timer > 0) flash_timer--;
if (attack_cooldown > 0) attack_cooldown--;

if (global.dialogue_active || !instance_exists(oPlayer)) exit;

var _dist = distance_to_object(oPlayer);

// Deteksi pemain dalam jarak 180 pixel
if (_dist < 180 && _dist > 18) {
    var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var _nx = x + lengthdir_x(move_speed, _dir);
    var _ny = y + lengthdir_y(move_speed, _dir);
    
    if (!scr_check_collision(_nx, _ny)) {
        x = _nx;
        y = _ny;
    }
}

// Serang pemain jika menabrak dan pemain tidak dalam kondisi kebal (i-frames)
if (_dist <= 20 && attack_cooldown <= 0) {
    attack_cooldown = 45;
    
    var _can_damage = true;
    if (instance_exists(oPlayer) && oPlayer.invincible_timer > 0) {
        _can_damage = false;
    }
    
    if (_can_damage) {
        global.player_hp = max(0, global.player_hp - attack_power);
        
        // Player flinch
        with (oPlayer) {
            var _kdir = point_direction(other.x, other.y, x, y);
            x += lengthdir_x(8, _kdir);
            y += lengthdir_y(8, _kdir);
        }
    }
}

