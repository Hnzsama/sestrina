/// @description Inisialisasi Goblin Rogue Hutan Purba

event_inherited();
sprite_index = sEnemyGoblin;
image_speed = 0.14;
image_xscale = 1.35;
image_yscale = 1.35;
max_hp = 38;
hp = 38;
enemy_name = "Goblin Pencuri";
move_speed = 1.35;
attack_power = 9;
exp_reward = 28;
gold_reward = 18;

drop_custom_loot = function() {
    // Drop Besi Bekas untuk Tempa Goran
    var _drop1 = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop1.item_type = "scrap_iron";
    _drop1.item_amount = choose(1, 1, 2);
    
    // Peluang drop ramuan atau tulang
    if (irandom(100) < 45) {
        var _drop2 = instance_create_depth(x + irandom_range(-8, 8), y + irandom_range(-8, 8), depth - 10, oItemDrop);
        _drop2.item_type = choose("bone_shard", "slime_jelly");
        _drop2.item_amount = 1;
    }
};
