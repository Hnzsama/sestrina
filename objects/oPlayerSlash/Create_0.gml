/// @description Inisialisasi Tebasan Pedang Ksatria (3-Hit Combo System)

sprite_index = sPlayerSlash;
life_timer = 12;
max_life = 12;
slash_dir = 0; // Sudut arah tebasan
slash_damage = 20;
combo_index = 1; // 1: Quick Slash, 2: Amber Cleave, 3: Celestial Spin Finisher
knockback_power = 12;
hit_list = ds_list_create();

depth = -500;

