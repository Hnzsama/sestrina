/// @description Step Event - Goran Combat AI, Follow Player & Skills

if (!variable_global_exists("party_goran") || !global.party_goran) {
    instance_destroy();
    exit;
}

if (!instance_exists(oPlayer)) exit;

depth = -y;
prompt_anim += 0.08;

// Sinkronisasi HP global
global.goran_hp = hp;

// Kurangi cooldown
if (cleave_cd > 0) cleave_cd--;
if (earthshatter_cd > 0) earthshatter_cd--;
if (whirlwind_cd > 0) whirlwind_cd--;
if (warcry_cd > 0) warcry_cd--;

// Deteksi Ruangan Tempur (Dungeon / Arena Boss)
var _in_combat_room = (room == rm_outskirts || room == rm_catacombs || room == rm_boss_chamber);

// Cari musuh terdekat dalam jangkauan
var _nearest_enemy = noone;
var _min_dist = 220;

if (_in_combat_room && instance_exists(oEnemyParent)) {
    with (oEnemyParent) {
        if (hp > 0) {
            var _d = point_distance(x, y, other.x, other.y);
            if (_d < _min_dist) {
                _min_dist = _d;
                _nearest_enemy = id;
            }
        }
    }
}

// =========================================================================
// 1. EKSEKUSI ANIMASI SERANGAN & HITBOX DAMAGE GORAN
// =========================================================================
if (state == "cleave") {
    sprite_index = sGoran_Combat_Cleave;
    image_speed = 0.22;
    
    // Hit frame (frame 2 sampai 4)
    if (image_index >= 2.0 && image_index <= 4.0 && !attack_has_hit) {
        attack_has_hit = true;
        scr_play_sfx(snd_sword_attack_3, 0.08, 1.0, 12);
        var _cleave_x = x + (image_xscale > 0 ? 32 : -32);
        var _cleave_y = y;
        
        with (oEnemyParent) {
            if (hp > 0 && point_distance(x, y, _cleave_x, _cleave_y) <= 58) {
                var _kdir = (other.image_xscale > 0) ? 0 : 180;
                take_damage(35, _kdir, true);
                if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 2);
            }
        }
    }
    
    if (image_index >= 5.5) {
        state = "idle";
        attack_has_hit = false;
    }
    exit;
}
else if (state == "earthshatter") {
    sprite_index = sGoran_Combat_Earthshatter;
    image_speed = 0.20;
    
    // Hentakan Gempa Menghantam Tanah (frame 3 sampai 5)
    if (image_index >= 3.0 && image_index <= 5.0 && !attack_has_hit) {
        attack_has_hit = true;
        scr_play_sfx(snd_boss_stomp, 0.08, 1.0, 14);
        with (oEnemyParent) {
            if (hp > 0 && point_distance(x, y, other.x, other.y) <= 85) {
                var _kdir = point_direction(other.x, other.y, x, y);
                take_damage(55, _kdir, true);
            }
        }
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 4);
    }
    
    if (image_index >= 5.5) {
        state = "idle";
        attack_has_hit = false;
    }
    exit;
}
else if (state == "whirlwind") {
    sprite_index = sGoran_Combat_Whirlwind;
    image_speed = 0.25;
    
    // Putaran Beruntun (frame 1, 3, dan 5)
    var _cur_f = floor(image_index);
    if ((_cur_f == 1 || _cur_f == 3 || _cur_f == 5) && attack_frame_hit != _cur_f) {
        attack_frame_hit = _cur_f;
        scr_play_sfx(snd_sword_attack_2, 0.08, 0.85, 11);
        with (oEnemyParent) {
            if (hp > 0 && point_distance(x, y, other.x, other.y) <= 72) {
                var _kdir = point_direction(other.x, other.y, x, y);
                take_damage(20, _kdir, true);
            }
        }
        if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 2);
    }
    
    if (image_index >= 5.5) {
        state = "idle";
        attack_frame_hit = -1;
    }
    exit;
}
else if (state == "warcry") {
    sprite_index = sGoran_Combat_Warcry;
    image_speed = 0.18;
    
    if (image_index >= 2.0 && !attack_has_hit) {
        attack_has_hit = true;
        scr_play_sfx(snd_drink_potion, 0.06, 1.0, 13);
        // Buff Pemain & Goran
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "GORAN WARCRY!";
            oRoomTransition.banner_subtitle = "Darah prajurit membara! Serangan & Pertahanan Party meningkat!";
            oRoomTransition.banner_timer = 90;
            oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 2);
        }
        global.player_hp = min(global.player_max_hp, global.player_hp + 25);
    }
    
    if (image_index >= 5.5) {
        state = "idle";
        attack_has_hit = false;
    }
    exit;
}

// =========================================================================
// 2. LOGIKA KEPUTUSAN TEMPUR & FOLLOW PLAYER
// =========================================================================
if (_nearest_enemy != noone) {
    // Arah pandang menghadap musuh
    image_xscale = (_nearest_enemy.x >= x) ? 1.0 : -1.0;
    
    // Jarak dekat: Gunakan Skill Tempur
    if (_min_dist <= 52) {
        if (warcry_cd <= 0) {
            state = "warcry";
            image_index = 0;
            warcry_cd = 400;
            attack_has_hit = false;
        } else if (whirlwind_cd <= 0) {
            state = "whirlwind";
            image_index = 0;
            whirlwind_cd = 280;
            attack_frame_hit = -1;
        } else if (earthshatter_cd <= 0) {
            state = "earthshatter";
            image_index = 0;
            earthshatter_cd = 200;
            attack_has_hit = false;
        } else if (cleave_cd <= 0) {
            state = "cleave";
            image_index = 0;
            cleave_cd = 55;
            attack_has_hit = false;
        } else {
            sprite_index = sGoran_Combat_Idle;
            image_speed = 0.08;
        }
    } else {
        // Kejar musuh dengan berlari sigap
        var _edir = point_direction(x, y, _nearest_enemy.x, _nearest_enemy.y);
        var _nx = x + lengthdir_x(combat_run_speed, _edir);
        var _ny = y + lengthdir_y(combat_run_speed, _edir);
        if (!scr_check_collision(_nx, _ny)) {
            x = _nx;
            y = _ny;
        } else if (!scr_check_collision(_nx, y)) {
            x = _nx;
        } else if (!scr_check_collision(x, _ny)) {
            y = _ny;
        }
        sprite_index = sGoran_Combat_Walk;
        image_speed = 0.16;
    }
} else {
    // Mengikuti Pemain (Follow Player)
    var _pdist = point_distance(x, y, oPlayer.x, oPlayer.y);
    
    // Teleport darurat jika tertinggal terlalu jauh saat pindah ruangan
    if (_pdist > 280) {
        x = oPlayer.x - 32;
        y = oPlayer.y;
    } else if (_pdist > 45) {
        var _pdir = point_direction(x, y, oPlayer.x, oPlayer.y);
        var _fx = x + lengthdir_x(move_speed, _pdir);
        var _fy = y + lengthdir_y(move_speed, _pdir);
        if (!scr_check_collision(_fx, _fy)) {
            x = _fx;
            y = _fy;
        } else if (!scr_check_collision(_fx, y)) {
            x = _fx;
        } else if (!scr_check_collision(x, _fy)) {
            y = _fy;
        }
        sprite_index = sGoran_Combat_Walk;
        image_speed = 0.14;
        image_xscale = (oPlayer.x >= x) ? 1.0 : -1.0;
    } else {
        sprite_index = sGoran_Combat_Idle;
        image_speed = 0.08;
    }
}

// =========================================================================
// 3. INTERAKSI DENGAN PEMAIN SAAT TIDAK SEDANG BERTARUNG
// =========================================================================
is_player_near = (point_distance(x, y, oPlayer.x, oPlayer.y) <= interact_range && _nearest_enemy == noone && !global.dialogue_active && global.shop_menu_open == "");

if (is_player_near && (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter))) {
    var _d = dialogue_create();
    _d.add("Goran", "Hahah! Tenang saja anak muda, palu dan kapak tempurku siap membelah monster apa pun di depan kita!", "goran", "protagonist", "left", "exclamation");
    
    if (global.player_potions > 0 && hp < max_hp) {
        _d.add("Protagonist", "Paman Goran, minumlah ramuan herbal ini untuk memulihkan tenagamu.", "goran", "protagonist", "right");
        _d.add("Goran", "Terima kasih banyak! Terasa segar sekali! Tenagaku pulih penuh!", "goran", "protagonist", "left");
        _d.start(function() {
            global.player_potions--;
            hp = min(max_hp, hp + 120);
        });
    } else {
        _d.add("Protagonist", "Kita harus waspada paman. Pertarungan di depan akan sangat sengit.", "goran", "protagonist", "right");
        _d.add("Goran", "Jangan khawatir! Selama kita bertarung bersama, tak ada yang tak bisa kita hancurkan!", "goran", "protagonist", "left", "exclamation");
        _d.start();
    }
}

