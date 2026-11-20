/// @description Inisialisasi Flying Imp (Floor 2)
event_inherited();
base_xscale = 0.52;
base_yscale = 0.52;
image_xscale = 0.52;
image_yscale = 0.52;

spr_idle = sEnemy_Imp_Idle;
spr_walk = sEnemy_Imp_Fly;
spr_attack = sEnemy_Imp_Attack;
spr_hurt = sEnemy_Imp_Idle;
spr_die = sEnemy_Imp_Idle;

sprite_index = spr_idle;
image_speed = 0.18;

max_hp = 45;
hp = 45;
enemy_name = "Imp Gua";
move_speed = 1.45;
attack_power = 14;
exp_reward = 40;
gold_reward = 20;

drop_custom_loot = function() {
    var _drop = instance_create_depth(x, y, depth - 10, oItemDrop);
    _drop.item_type = "magic_crystal";
    _drop.item_amount = 1;
};
