/// @description Inisialisasi Proyektil Fireball

fire_dir = 0;
move_speed = 5.8;
spell_damage = scr_get_magic_power();
life_timer = 45;
hit_list = ds_list_create();
depth = -120;
is_exploded = false;
explode_radius = 42;
explode_timer = 0;
