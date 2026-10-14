/// @description Inisialisasi Ancient Golem Boss

event_inherited();
sprite_index = sBossGolem;
image_speed = 0.08;
max_hp = 450;
hp = 450;
is_boss = true;
enemy_name = "Golem Penjaga Purba";
move_speed = 0.55;
attack_power = 22;
exp_reward = 400;

stomp_timer = 120;
stomp_shockwave_r = 0;
is_stomping = false;

depth = -150;

/// @function on_death()
on_death = function() {
    scr_add_exp(exp_reward);
    global.quest_stage = 4;
    global.quest_title = "Bawa Obat ke Sestrina";
    global.quest_desc = "Gunakan portal untuk kembali ke kamar Sestrina";
    global.player_has_remedy = true;
    
    // Spawn Bunga Cahaya Abadi / Portal
    if (instance_exists(oDoor)) {
        with (oDoor) {
            required_quest_stage = 0;
            door_title = "Portal Suci ke Kamar Sestrina";
            door_subtitle = "Menyelamatkan sang adik";
        }
    }
    
    instance_destroy();
};
