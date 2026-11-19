event_inherited(); // runs oCharacterParent's Create first

char_scale = 1.0;
image_xscale = 1.0;
image_yscale = 1.0;

// =========================================================================
// MAPPING ASET LENGKAP PROTAGONIS (Player Character Pack - Sestrina)
// =========================================================================

// 1. Bergerak & Diam (Movement & Idle)
spr_idle = {
    down: spr_player_idle_down,
    up:   spr_player_idle_up,
    side: spr_player_idle_side
};

spr_walk = {
    down: spr_player_walk_down,
    up:   spr_player_walk_up,
    side: spr_player_walk_side
};

// 2. Menghindar & Berguling (Dodge Roll)
spr_roll = {
    down: spr_player_roll_down,
    up:   spr_player_roll_up,
    side: spr_player_roll_side
};

// 3. Kombo 3 Tebasan Pedang (3-Hit Attack Combo)
spr_combo1 = {
    down: spr_player_combo1_quick_slash_down,
    up:   spr_player_combo1_quick_slash_up,
    side: spr_player_combo1_quick_slash_side
};

spr_combo2 = {
    down: spr_player_combo2_amber_cleave_down,
    up:   spr_player_combo2_amber_cleave_up,
    side: spr_player_combo2_amber_cleave_side
};

spr_combo3 = spr_player_combo3_spin_finisher_360; // 360 Spin Finisher

// 4. Lancarkan Sihir 4-Arah (Magic Cast: Hadap Depan, Samping Kiri/Kanan, Belakang)
spr_cast_fire = {
    down: spr_player_cast_fireball_down,
    side: spr_player_cast_fireball_side,
    up:   spr_player_cast_fireball_up
};

spr_cast_frost = {
    down: spr_player_cast_frostnova_down,
    side: spr_player_cast_frostnova_side,
    up:   spr_player_cast_frostnova_up
};

// 5. Minum Ramuan Pemulih 4-Arah (Potion Drink: Hadap Depan, Samping Kiri/Kanan, Belakang)
spr_drink = {
    down: spr_player_drink_potion_down,
    side: spr_player_drink_potion_side,
    up:   spr_player_drink_potion_up
};

// Backward-compatibility struct untuk oCharacterParent
sprites.down = spr_walk.down;
sprites.up   = spr_walk.up;
sprites.side = spr_walk.side;
sprite_index = spr_idle.down;

attack_cooldown = 0;
spell_cooldown = 0;
is_attacking = 0;
attack_dir = 270;

// Sistem Animasi Aksi Khusus
is_casting = 0;
cast_type = 1;
is_drinking = 0;

// Sistem Dodge Roll & Invincibility Frames (No Hitbox & Perfect Dodge)
is_rolling = false;
roll_timer = 0;
roll_dir = 0;
roll_speed = 5.8;
invincible_timer = 0;
ghost_trail = [];

// Sistem Mekanik Perfect Dodge & Counter Boost
perfect_dodge_timer = 0;
perfect_dodge_cooldown = 0;
perfect_dodge_flash = 0;
perfect_dodge_ring_rad = 0;
perfect_dodge_ring_alpha = 0;
perfect_dodge_text_alpha = 0;
perfect_dodge_text_y = 0;
counter_boost_active = false;
counter_boost_timer = 0;
hitstop_timer = 0;
perfect_sparks = [];

// Sistem Audio SFX
footstep_timer = 0;

// Sistem 3-Hit Combo Attack
combo_step = 0;
combo_timer = 0;

// Sistem Kematian & Respawn (UAS Feature)
is_defeated = false;
defeat_timer = 0;

// Posisikan sesuai titik spawn dari transisi ruangan
if (variable_global_exists("spawn_x") && global.spawn_x != -1) {
    x = global.spawn_x;
    y = global.spawn_y;
    global.spawn_x = -1;
    global.spawn_y = -1;
}

// Snap kamera instan ke pemain saat objek dibuat
if (!view_enabled) {
    view_enabled = true;
    view_visible[0] = true;
}
var _cam = view_camera[0];
if (_cam == -1) {
    _cam = camera_create_view(0, 0, 1280, 720, 0, noone, -1, -1, -1, -1);
    view_camera[0] = _cam;
}
camera_set_view_size(_cam, 1280, 720);
var _snap_x = clamp(x - 640, 0, max(0, room_width - 1280));
var _snap_y = clamp(y - 360, 0, max(0, room_height - 720));
camera_set_view_pos(_cam, _snap_x, _snap_y);

// Spawn Companion Goran jika sudah masuk party
if (variable_global_exists("party_goran") && global.party_goran && !instance_exists(oCompanion_Goran)) {
    instance_create_depth(x - 30, y, -100, oCompanion_Goran);
}