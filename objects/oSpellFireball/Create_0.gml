/// @description Inisialisasi Proyektil Bola Api (Optimized Fireball with Impact & Max Range Detonation)

fire_dir = 0;
move_speed = 7.0;
spell_damage = scr_get_magic_power();

// Jarak tempuh maksimal sebelum meledak otomatis
max_distance = 320;
distance_traveled = 0;

// Status Ledakan & Radius
is_exploded = false;
explode_radius = 56;
explode_timer = 15;
explode_max_timer = 15;
direct_hit_enemy = noone;

// Partikel Jejak Api & Serpihan Ledakan
trail_sparks = [];
burst_sparks = [];

depth = -160;
