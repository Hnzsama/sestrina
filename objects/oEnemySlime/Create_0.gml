/// @description Inisialisasi Slime Katakombe (Atlas Floor 1)

event_inherited();
base_xscale = 0.40;
base_yscale = 0.40;
image_xscale = 0.40;
image_yscale = 0.40;

spr_idle = sEnemy_Slime_Idle;
spr_walk = sEnemy_Slime_Walk;
spr_attack = sEnemy_Slime_Attack;
spr_hurt = sEnemy_Slime_Hurt;
spr_die = sEnemy_Slime_Die;

sprite_index = spr_idle;
image_speed = 0.15;

max_hp = 30;
hp = 30;
enemy_name = "Slime Katakombe";
move_speed = 0.95;
attack_power = 7;
exp_reward = 18;
gold_reward = 8;

drop_custom_loot = function() {
    var _drop = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop.item_type = "slime_jelly";
    _drop.item_amount = choose(1, 1, 2);
};
