/// @description Step Event - Magnetisme dan Pengambilan Item

float_timer += 0.08;

if (bounce_count < 2) {
    z += v_z;
    v_z += 0.3;
    if (z >= 0) {
        z = 0;
        v_z = -v_z * 0.4;
        bounce_count++;
    }
}

if (instance_exists(oPlayer)) {
    var _dist = point_distance(x, y, oPlayer.x, oPlayer.y);
    if (_dist < pickup_dist) {
        var _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
        var _spd = (pickup_dist - _dist) * 0.15 + 2.5;
        x += lengthdir_x(_spd, _dir);
        y += lengthdir_y(_spd, _dir);
        
        if (_dist < 16) {
            // Tambahkan ke inventory pemain
            switch (item_type) {
                case "gold":
                    global.gold += item_amount;
                    break;
                case "slime_jelly":
                    global.mat_slime_jelly += item_amount;
                    break;
                case "bone_shard":
                    global.mat_bone_shard += item_amount;
                    break;
                case "scrap_iron":
                    global.mat_scrap_iron += item_amount;
                    break;
                case "iron_ore":
                    global.mat_iron_ore += item_amount;
                    break;
                case "magic_crystal":
                    global.mat_magic_crystal += item_amount;
                    break;
                case "potion":
                    global.player_potions = min(5, global.player_potions + item_amount);
                    break;
            }
            
            // Berikan sedikit EXP gathering
            scr_add_exp(2);
            
            instance_destroy();
        }
    }
}
