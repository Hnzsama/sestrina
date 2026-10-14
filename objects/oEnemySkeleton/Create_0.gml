/// @description Inisialisasi Skeleton Knight Katakombe

event_inherited();
sprite_index = sEnemySkeleton;
image_speed = 0.12;
image_xscale = 1.35;
image_yscale = 1.35;
max_hp = 50;
hp = 50;
enemy_name = "Ksatria Tengkorak";
move_speed = 1.1;
attack_power = 11;
exp_reward = 35;
gold_reward = 15;

drop_custom_loot = function() {
    var _drop1 = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop1.item_type = "bone_shard";
    _drop1.item_amount = choose(1, 1, 2);
    
    if (irandom(100) < 65) {
        var _drop2 = instance_create_depth(x + irandom_range(-8, 8), y + irandom_range(-8, 8), depth - 10, oItemDrop);
        _drop2.item_type = "scrap_iron";
        _drop2.item_amount = 1;
    }
};
