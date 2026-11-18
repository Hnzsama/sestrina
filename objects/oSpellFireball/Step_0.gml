/// @description Step Event - Lintasan Bola Api, Deteksi Musuh Presisi & Ledakan Maksimal

if (!is_exploded) {
    var _prev_x = x;
    var _prev_y = y;
    
    // 1. Gerakkan Proyektil Maju Sesuai Arah
    var _dx = lengthdir_x(move_speed, fire_dir);
    var _dy = lengthdir_y(move_speed, fire_dir);
    x += _dx;
    y += _dy;
    distance_traveled += move_speed;
    
    // 2. Partikel Ekor Api (Trail Sparks)
    for (var _s = 0; _s < 2; _s++) {
        array_push(trail_sparks, {
            xx: _prev_x - lengthdir_x(8, fire_dir) + random_range(-4, 4),
            yy: _prev_y - lengthdir_y(8, fire_dir) + random_range(-4, 4),
            radius: random_range(2.5, 4.5),
            alpha: 0.9,
            col: choose(make_color_rgb(255, 80, 20), make_color_rgb(255, 160, 30), make_color_rgb(255, 230, 80))
        });
    }
    
    // Update & Fade Partikel Jejak
    for (var _i = array_length(trail_sparks) - 1; _i >= 0; _i--) {
        trail_sparks[_i].alpha -= 0.12;
        trail_sparks[_i].radius *= 0.92;
        if (trail_sparks[_i].alpha <= 0) {
            array_delete(trail_sparks, _i, 1);
        }
    }
    
    // 3. Deteksi Tabrakan Presisi dengan Musuh (Garis Lintasan + Lingkaran)
    var _hit_enemy = noone;
    if (instance_exists(oEnemyParent)) {
        _hit_enemy = collision_line(_prev_x, _prev_y, x, y, oEnemyParent, false, true);
        if (_hit_enemy == noone) {
            _hit_enemy = collision_circle(x, y, 14, oEnemyParent, false, true);
        }
    }
    
    // 4. Deteksi Tabrakan Tembok / Halangan Padat
    var _hit_wall = scr_check_collision(x, y);
    if (!_hit_wall && instance_exists(oSolidParent) && place_meeting(x, y, oSolidParent)) {
        _hit_wall = true;
    }
    
    // 5. Cek Batas Jangkauan Maksimal
    var _reached_max = (distance_traveled >= max_distance);
    
    // =========================================================================
    // PEMICU LEDAKAN: Kena Musuh, Kena Tembok, atau Capai Jarak Maksimal
    // =========================================================================
    if (_hit_enemy != noone || _hit_wall || _reached_max) {
        is_exploded = true;
        explode_timer = explode_max_timer;
        
        // Jika mengenai musuh, kunci koordinat ledakan tepat pada posisi musuh
        if (_hit_enemy != noone) {
            direct_hit_enemy = _hit_enemy;
            x = _hit_enemy.x;
            y = _hit_enemy.y;
        }
        
        // Getaran Layar Berbobot (Screen Shake)
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.screen_shake = 5;
        }
        
        // Spawn 18 Serpihan Ledakan Membuncah ke Segala Arah (Radial Blast Sparks)
        for (var _b = 0; _b < 18; _b++) {
            var _bdir = random(360);
            var _bspd = random_range(2.5, 6.8);
            array_push(burst_sparks, {
                xx: x,
                yy: y,
                vx: lengthdir_x(_bspd, _bdir),
                vy: lengthdir_y(_bspd, _bdir),
                radius: random_range(2.5, 5.0),
                alpha: 1.0,
                col: choose(make_color_rgb(255, 60, 20), make_color_rgb(255, 140, 30), make_color_rgb(255, 235, 90), c_white)
            });
        }
        
        // =====================================================================
        // TERAPKAN DAMAGE LEDAKAN AREA (AoE Blast Damage)
        // =====================================================================
        if (instance_exists(oEnemyParent)) {
            with (oEnemyParent) {
                var _edist = point_distance(x, y, other.x, other.y);
                if (_edist <= other.explode_radius) {
                    var _kdir = point_direction(other.x, other.y, x, y);
                    
                    // Bonus damage critical langsung untuk musuh yang terkena telak
                    if (id == other.direct_hit_enemy) {
                        take_damage(round(other.spell_damage * 1.35), _kdir);
                    } else {
                        // Damage area proporsional dalam radius ledakan
                        var _falloff = 1.0 - (_edist / other.explode_radius) * 0.35;
                        take_damage(max(1, round(other.spell_damage * _falloff)), _kdir);
                    }
                }
            }
        }
    }
} else {
    // Fase Ledakan Sedang Berlangsung (Expansion & Dissipation)
    explode_timer--;
    
    // Perbarui Posisi & Pudar Serpihan Api Membuncah
    for (var _k = array_length(burst_sparks) - 1; _k >= 0; _k--) {
        burst_sparks[_k].xx += burst_sparks[_k].vx;
        burst_sparks[_k].yy += burst_sparks[_k].vy;
        burst_sparks[_k].vx *= 0.88;
        burst_sparks[_k].vy *= 0.88;
        burst_sparks[_k].alpha -= 0.07;
        burst_sparks[_k].radius *= 0.94;
        
        if (burst_sparks[_k].alpha <= 0) {
            array_delete(burst_sparks, _k, 1);
        }
    }
    
    // Hancurkan instance saat animasi ledakan selesai
    if (explode_timer <= 0) {
        instance_destroy();
    }
}
