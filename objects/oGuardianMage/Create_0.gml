/// @description Inisialisasi Crystal Sorcerer (Ranged Mage Guardian)
event_inherited();

enemy_name = "Crystal Sorcerer";
max_hp = 80;
hp = 80;
move_speed = 0.85;
attack_power = 15;
exp_reward = 150;
gold_reward = 40;

base_xscale = 1.0;
base_yscale = 1.0;
image_xscale = 1.0;
image_yscale = 1.0;

spr_idle = sGuardian_Mage_Idle;
spr_walk = sGuardian_Mage_Idle;
spr_attack = sGuardian_Mage_Attack;
spr_hurt = sGuardian_Mage_Idle;
spr_die = sGuardian_Mage_Idle;

sprite_index = spr_idle;
image_speed = 0.12;

attack_cooldown = 60;
cast_timer = 0;
has_fired = false;
depth = -140;
flash_timer = 0;
anim_timer = random(100);

spells = []; // Peluru sihir { xx, yy, vx, vy, radius, life }

clamp_arena = function(_nx, _ny) {
    var _norm = sqr((_nx - 640) / 265) + sqr((_ny - 448) / 165);
    var _is_upper = (_nx >= 530 && _nx <= 750 && _ny >= 200 && _ny <= 340);
    return (_norm <= 1.0 || _is_upper);
};
