/// @description Step Event - Lintasan Bola Api & Ledakan

if (!is_exploded) {
    life_timer--;
    x += lengthdir_x(move_speed, fire_dir);
    y += lengthdir_y(move_speed, fire_dir);
    
    // Deteksi tabrakan dengan musuh atau tembok
    var _collided = false;
    if (place_meeting(x, y, oSolidParent)) _collided = true;
    
    if (instance_exists(oEnemyParent)) {
        var _enemy = instance_place(x, y, oEnemyParent);
        if (_enemy != noone) _collided = true;
    }
    
    if (life_timer <= 0 || _collided) {
        is_exploded = true;
        explode_timer = 12;
        
        // Damage ledakan area ke semua musuh di sekitar
        if (instance_exists(oEnemyParent)) {
            with (oEnemyParent) {
                if (point_distance(x, y, other.x, other.y) <= other.explode_radius) {
                    var _kdir = point_direction(other.x, other.y, x, y);
                    take_damage(other.spell_damage, _kdir);
                }
            }
        }
    }
} else {
    explode_timer--;
    if (explode_timer <= 0) {
        if (ds_exists(hit_list, ds_type_list)) ds_list_destroy(hit_list);
        instance_destroy();
    }
}
