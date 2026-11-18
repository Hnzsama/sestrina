/// @description Inisialisasi Companion Ksatria Pandai Besi Goran

persistent = true;
depth = -100;

// Status Tempur Goran
max_hp = 300;
hp = variable_global_exists("goran_hp") ? global.goran_hp : 300;

move_speed = 2.4;
combat_run_speed = 3.0;

// State Machine: "idle", "walk", "cleave", "earthshatter", "whirlwind", "warcry", "exhausted"
state = "idle";
state_timer = 0;

// Cooldown Kemampuan Tempur (dalam frame @ 60 FPS)
cleave_cd = 0;
earthshatter_cd = 160;
whirlwind_cd = 260;
warcry_cd = 120;

// Mencegah multi-hit dalam 1 ayunan
attack_has_hit = false;
attack_frame_hit = 0;

// Interaksi Dialog & Party Management
interact_range = 45;
is_player_near = false;
prompt_anim = 0;

sprite_index = sGoran_Combat_Idle;
image_speed = 0.08;
image_xscale = 1.0;
image_yscale = 1.0;

// Posisikan dekat player saat pertama kali muncul
if (instance_exists(oPlayer)) {
    x = oPlayer.x - 36;
    y = oPlayer.y;
}

