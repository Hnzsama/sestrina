/// @description Step Event - Crystal Aegis Knight Combat AI

anim_timer += 0.08;
if (flash_timer > 0) flash_timer--;
if (attack_cooldown > 0) attack_cooldown--;

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
// STATE: ATTACK (Tebasan Cleave Pedang Kristal Purba)
// -----------------------------------------------------------------------------
if (state == "attack") {
    attack_timer--;
    
    // Saat frame serangan mengayun (frame index 1 atau 2)
    if (image_index >= 1 && !has_swung) {
        has_swung = true;
        var _cleave_dist = point_distance(x, y, oPlayer.x, oPlayer.y);
        var _face_dir = (image_xscale < 0) ? 180 : 0;
        var _dir_to_p = point_direction(x, y, oPlayer.x, oPlayer.y);
        var _angle_diff = abs(angle_difference(_face_dir, _dir_to_p));
        
        // Mengenai pemain jika dalam jangkauan 50px dan berada di sudut hadap knight
        if (_cleave_dist < 50 && _angle_diff < 95) {
            with (oPlayer) {
                if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                    scr_player_trigger_perfect_dodge(other.x, other.y);
                } else if (invincible_timer <= 0) {
                    global.player_hp = max(0, global.player_hp - other.attack_power);
                    invincible_timer = 25;
                    var _kdir = point_direction(other.x, other.y, x, y);
                    x += lengthdir_x(12, _kdir);
                    y += lengthdir_y(12, _kdir);
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 5;
                }
            }
        }
    }
    
    if (attack_timer <= 0 || image_index >= image_number - 1) {
        state = "idle";
        sprite_index = spr_idle;
        image_speed = 0.12;
        attack_cooldown = irandom_range(45, 75);
    }
    exit;
}

// -----------------------------------------------------------------------------
// STATE: CHASE & MELEE PREPARATION
// -----------------------------------------------------------------------------
if (_dist <= 35 && attack_cooldown <= 0) {
    state = "attack";
    attack_timer = 30;
    has_swung = false;
    sprite_index = spr_attack;
    image_index = 0;
    image_speed = 0.20;
    exit;
}

// Mengejar Pemain di dalam Arena
var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
var _nx = x + lengthdir_x(move_speed, _dir);
var _ny = y + lengthdir_y(move_speed, _dir);

if (clamp_arena(_nx, _ny)) {
    x = _nx;
    y = _ny;
    sprite_index = spr_idle;
    image_speed = 0.16;
}
