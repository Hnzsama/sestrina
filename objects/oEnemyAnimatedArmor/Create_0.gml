/// @description Inisialisasi Living Animated Armor (Floor 2 Guardian)
event_inherited();
base_xscale = 0.62;
base_yscale = 0.62;
image_xscale = 0.62;
image_yscale = 0.62;

spr_idle = sEnemy_Armor_Idle;
spr_walk = sEnemy_Armor_Walk;
spr_attack = sEnemy_Armor_Attack;
spr_hurt = sEnemy_Armor_Idle;
spr_die = sEnemy_Armor_Idle;

sprite_index = spr_idle;
image_speed = 0.15;

max_hp = 140;
hp = 140;
enemy_name = "Living Armor Guardian";
move_speed = 0.9;
attack_power = 28;
exp_reward = 90;
gold_reward = 50;

drop_custom_loot = function() {
    var _drop1 = instance_create_depth(x - 6, y, depth - 10, oItemDrop);
    _drop1.item_type = "scrap_iron";
    _drop1.item_amount = 2;
    
    var _drop2 = instance_create_depth(x + 6, y, depth - 10, oItemDrop);
    _drop2.item_type = "iron_ore";
    _drop2.item_amount = 1;
};
