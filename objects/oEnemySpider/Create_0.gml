/// @description Inisialisasi Laba-laba Raksasa Katakombe (Atlas Floor 1)

event_inherited();
base_xscale = 0.42;
base_yscale = 0.42;
image_xscale = 0.42;
image_yscale = 0.42;

spr_idle = sEnemy_Spider_Idle;
spr_walk = sEnemy_Spider_Walk;
spr_attack = sEnemy_Spider_Attack;
spr_hurt = sEnemy_Spider_Hurt;
spr_die = sEnemy_Spider_Die;

sprite_index = spr_idle;
image_speed = 0.14;

max_hp = 42;
hp = 42;
enemy_name = "Laba-laba Katakombe";
move_speed = 1.25;
attack_power = 10;
exp_reward = 30;
gold_reward = 12;

drop_custom_loot = function() {
    var _drop1 = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop1.item_type = "magic_crystal";
    _drop1.item_amount = 1;
};
