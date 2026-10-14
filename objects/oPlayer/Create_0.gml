event_inherited(); // runs oCharacterParent's Create first

sprites.down = sPlayer_down;
sprites.up   = sPlayer_up;
sprites.side = sPlayer_side;
sprite_index = sprites.down;

attack_cooldown = 0;
spell_cooldown = 0;
is_attacking = 0;

// Sistem Dodge Roll & Invincibility Frames
is_rolling = false;
roll_timer = 0;
roll_dir = 0;
roll_speed = 5.6;
invincible_timer = 0;
ghost_trail = [];

// Sistem 3-Hit Combo Attack
combo_step = 0;
combo_timer = 0;

// Posisikan sesuai titik spawn dari transisi ruangan
if (variable_global_exists("spawn_x") && global.spawn_x != -1) {
    x = global.spawn_x;
    y = global.spawn_y;
    global.spawn_x = -1;
    global.spawn_y = -1;
}