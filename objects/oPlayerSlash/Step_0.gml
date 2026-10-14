/// @description Step Event - Hitbox Tebasan Pedang Kombo

life_timer--;
if (life_timer <= 0) {
    if (ds_exists(hit_list, ds_type_list)) ds_list_destroy(hit_list);
    instance_destroy();
    exit;
}

// Jangkauan deteksi hitbox berdasarkan tingkatan kombo dan tier senjata
var _hit_radius = 34;
if (combo_index == 2) _hit_radius = 42;
if (combo_index == 3) _hit_radius = 56;

var _tier = variable_global_exists("weapon_tier") ? global.weapon_tier : 1;
var _tier_mult = 1.0 + (_tier >= 3 ? 0.15 : 0.0) + (_tier >= 4 ? 0.15 : 0.0);
_hit_radius = round(_hit_radius * _tier_mult);

// Cek tabrakan dengan musuh
if (instance_exists(oEnemyParent)) {
    with (oEnemyParent) {
        var _dist = point_distance(x, y, other.x, other.y);
        if (_dist < _hit_radius && ds_list_find_index(other.hit_list, id) == -1) {
            ds_list_add(other.hit_list, id);
            
            // Hitung arah dorongan
            var _kdir = (other.combo_index == 3) ? point_direction(other.x, other.y, x, y) : other.slash_dir;
            take_damage(other.slash_damage, _kdir);
        }
    }
}

