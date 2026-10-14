/// @description Step Event - Gelombang Es Mengembang & Membekukan

duration--;
current_radius = lerp(current_radius, max_radius, 0.25);

if (instance_exists(oEnemyParent)) {
    with (oEnemyParent) {
        if (point_distance(x, y, other.x, other.y) <= other.current_radius && ds_list_find_index(other.hit_list, id) == -1) {
            ds_list_add(other.hit_list, id);
            var _kdir = point_direction(other.x, other.y, x, y);
            take_damage(other.spell_damage, _kdir);
            
            // Efek Frost: memperlambat musuh
            move_speed = max(0.2, move_speed * 0.4);
            attack_cooldown += 30;
        }
    }
}

if (duration <= 0) {
    if (ds_exists(hit_list, ds_type_list)) ds_list_destroy(hit_list);
    instance_destroy();
}
