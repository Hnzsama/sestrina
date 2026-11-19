/// @description Step Event - Hitbox Tebasan Pedang Kombo

life_timer--;
if (life_timer <= 0) {
    if (ds_exists(hit_list, ds_type_list)) ds_list_destroy(hit_list);
    instance_destroy();
    exit;
}

// Jangkauan deteksi hitbox berdasarkan tingkatan kombo dan tier senjata (diperpanjang & disesuaikan)
var _hit_radius = 44;
if (combo_index == 2) _hit_radius = 54;
if (combo_index == 3) _hit_radius = 68;

var _tier = variable_global_exists("weapon_tier") ? global.weapon_tier : 1;
var _tier_mult = 1.0 + (_tier >= 3 ? 0.15 : 0.0) + (_tier >= 4 ? 0.15 : 0.0);
if (is_counter) _tier_mult += 0.25; // Jangkauan tebasan serangan balasan 25% lebih lebar
_hit_radius = round(_hit_radius * _tier_mult);

// Spawn percikan pedang di lintasan ayunan
var _prog = (max_life - life_timer) / max_life;
var _spark_ang = slash_dir - 50 + (_prog * 100) + random_range(-15, 15);
var _spark_spd = random_range(2, 5);
var _s_col = is_counter ? choose(make_color_rgb(255, 230, 80), make_color_rgb(255, 180, 40), c_white) : ((combo_index == 1) ? choose(c_white, make_color_rgb(180, 230, 255)) : ((combo_index == 2) ? choose(make_color_rgb(255, 235, 120), make_color_rgb(255, 160, 40)) : choose(c_white, make_color_rgb(140, 240, 255))));

array_push(sparks, {
    xx: x + lengthdir_x(_hit_radius * 0.8, _spark_ang),
    yy: y + lengthdir_y(_hit_radius * 0.8, _spark_ang),
    vx: lengthdir_x(_spark_spd, _spark_ang),
    vy: lengthdir_y(_spark_spd, _spark_ang),
    alpha: 1.0,
    size: random_range(2.0, 3.5),
    col: _s_col
});

// Update & fade percikan
for (var _k = array_length(sparks) - 1; _k >= 0; _k--) {
    sparks[_k].xx += sparks[_k].vx;
    sparks[_k].yy += sparks[_k].vy;
    sparks[_k].alpha -= 0.12;
    sparks[_k].size *= 0.92;
    if (sparks[_k].alpha <= 0) {
        array_delete(sparks, _k, 1);
    }
}

// Cek tabrakan dengan musuh
if (instance_exists(oEnemyParent)) {
    with (oEnemyParent) {
        var _dist = point_distance(x, y, other.x, other.y);
        if (_dist < _hit_radius && ds_list_find_index(other.hit_list, id) == -1) {
            ds_list_add(other.hit_list, id);
            
            // Hitung arah dorongan
            var _kdir = (other.combo_index == 3) ? point_direction(other.x, other.y, x, y) : other.slash_dir;
            take_damage(other.slash_damage, _kdir, true);
            scr_play_sword_hit(other.combo_index == 3 || other.is_counter);
            
            // Screen shake & hit sparks
            if (instance_exists(oRoomTransition)) {
                var _shake = (other.combo_index == 3) ? 5 : ((other.combo_index == 2) ? 3 : 2);
                oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, _shake);
            }
            
            // Tambah percikan ledakan saat pedang mengenai tubuh musuh
            for (var _p = 0; _p < 6; _p++) {
                var _bdir = _kdir + random_range(-50, 50);
                var _bspd = random_range(3, 7);
                array_push(other.sparks, {
                    xx: x,
                    yy: y,
                    vx: lengthdir_x(_bspd, _bdir),
                    vy: lengthdir_y(_bspd, _bdir),
                    alpha: 1.0,
                    size: random_range(2.5, 4.5),
                    col: c_white
                });
            }
        }
    }
}

