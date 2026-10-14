/// @description Inisialisasi Slime Hutan

event_inherited();
sprite_index = sEnemySlime;
image_speed = 0.15;
image_xscale = 1.35;
image_yscale = 1.35;
max_hp = 30;
hp = 30;
enemy_name = "Slime Rawa";
move_speed = 0.95;
attack_power = 7;
exp_reward = 18;
gold_reward = 7;

drop_custom_loot = function() {
    var _drop = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop.item_type = "slime_jelly";
    _drop.item_amount = choose(1, 1, 2);
};
