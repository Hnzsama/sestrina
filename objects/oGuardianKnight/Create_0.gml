/// @description Inisialisasi Crystal Aegis Knight (Melee Guardian)
event_inherited();

enemy_name = "Crystal Aegis Knight";
max_hp = 120;
hp = 120;
move_speed = 1.15;
attack_power = 18;
exp_reward = 160;
gold_reward = 45;

base_xscale = 1.0;
base_yscale = 1.0;
image_xscale = 1.0;
image_yscale = 1.0;

spr_idle = sGuardian_Knight_Idle;
spr_walk = sGuardian_Knight_Idle;
spr_attack = sGuardian_Knight_Attack;
spr_hurt = sGuardian_Knight_Idle;
spr_die = sGuardian_Knight_Idle;

sprite_index = spr_idle;
image_speed = 0.12;

attack_cooldown = 40;
attack_timer = 0;
has_swung = false;
depth = -140;
flash_timer = 0;
anim_timer = random(100);

// Area batas pergerakan boss arena (elips 265 x 165 di sekitar 640, 448)
clamp_arena = function(_nx, _ny) {
    var _norm = sqr((_nx - 640) / 265) + sqr((_ny - 448) / 165);
    var _is_upper = (_nx >= 530 && _nx <= 750 && _ny >= 200 && _ny <= 340);
    return (_norm <= 1.0 || _is_upper);
};
