/// @description Inisialisasi Tikus Raksasa Katakombe (Atlas Floor 1)

event_inherited();
base_xscale = 1.0;
image_xscale = 1.0;
image_yscale = 1.0;

spr_idle = sEnemy_Rat_Idle;
spr_walk = sEnemy_Rat_Walk;
spr_attack = sEnemy_Rat_Attack;
spr_hurt = sEnemy_Rat_Hurt;
spr_die = sEnemy_Rat_Die;

sprite_index = spr_idle;
image_speed = 0.16;

max_hp = 28;
hp = 28;
enemy_name = "Tikus Katakombe";
move_speed = 1.45;
attack_power = 6;
exp_reward = 22;
gold_reward = 10;

drop_custom_loot = function() {
    var _drop1 = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop1.item_type = "scrap_iron";
    _drop1.item_amount = 1;
};
