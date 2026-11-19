/// @description Step Event - NPC Wandering AI & Player Proximity Interaction

event_inherited();

// 1. Cek apakah pemain sedang dekat dan berbicara/interaksi
var _is_interacting = (global.dialogue_active || (variable_global_exists("shop_menu_open") && global.shop_menu_open != ""));
var _player_near = false;
if (instance_exists(oPlayer)) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) <= interact_range) {
        _player_near = true;
    }
}

// Jika pemain sedang dekat atau dalam dialog, berhenti dan menghadap ke arah pemain
if (_is_interacting || _player_near) {
    if (instance_exists(oPlayer)) {
        if (oPlayer.x < x) {
            image_xscale = -abs(base_scale);
        } else {
            image_xscale = abs(base_scale);
        }
    }
    image_speed = 0.03;
    exit;
}

// 2. Sistem Mondar-mandir (Wandering AI)
if (!is_wandering) exit;

wander_timer--;
if (wander_timer <= 0) {
    if (wander_state == "idle") {
        wander_state = "walk";
        wander_timer = irandom_range(90, 220);
        
        // Tentukan titik target acak di sekitar posisi awal (home)
        var _ang = random(360);
        var _dist = random_range(20, wander_radius);
        wander_target_x = home_x + lengthdir_x(_dist, _ang);
        wander_target_y = home_y + lengthdir_y(_dist, _ang);
    } else {
        wander_state = "idle";
        wander_timer = irandom_range(70, 180);
    }
}

if (wander_state == "walk") {
    var _dist_to_tar = point_distance(x, y, wander_target_x, wander_target_y);
    if (_dist_to_tar > 5) {
        var _dir = point_direction(x, y, wander_target_x, wander_target_y);
        var _dx = lengthdir_x(wander_speed, _dir);
        var _dy = lengthdir_y(wander_speed, _dir);
        
        // Cek tabrakan solid dengan peta kota Altdorf
        if (!scr_check_collision(x + _dx, y + _dy)) {
            x += _dx;
            y += _dy;
            
            // Animasi melangkah kaki
            image_speed = 0.12;
            if (_dx < -0.1) {
                image_xscale = -abs(base_scale);
            } else if (_dx > 0.1) {
                image_xscale = abs(base_scale);
            }
        } else {
            // Jika mentok tembok atau rintangan, batalkan jalan dan istirahat sejenak
            wander_state = "idle";
            wander_timer = irandom_range(60, 120);
            image_speed = 0.04;
        }
    } else {
        wander_state = "idle";
        wander_timer = irandom_range(60, 150);
        image_speed = 0.04;
    }
} else {
    image_speed = 0.04;
}
