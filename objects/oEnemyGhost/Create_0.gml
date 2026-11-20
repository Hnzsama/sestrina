/// @description Inisialisasi Floating Ghost (Floor 2)
event_inherited();
base_xscale = 0.52;
base_yscale = 0.52;
image_xscale = 0.52;
image_yscale = 0.52;

spr_idle = sEnemy_Ghost_Idle;
spr_walk = sEnemy_Ghost_Float;
spr_attack = sEnemy_Ghost_Attack;
spr_hurt = sEnemy_Ghost_Idle;
spr_die = sEnemy_Ghost_Idle;

sprite_index = spr_idle;
image_speed = 0.15;

max_hp = 60;
hp = 60;
enemy_name = "Ghost Purba";
move_speed = 0.95;
attack_power = 22;
exp_reward = 55;
gold_reward = 30;

drop_custom_loot = function() {
    var _drop = instance_create_depth(x, y, depth - 10, oItemDrop);
    _drop.item_type = "magic_crystal";
    _drop.item_amount = choose(1, 2);
};
