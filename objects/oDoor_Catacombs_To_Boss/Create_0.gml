/// @description Door Katakombe ke Lantai 2 (Gua Kristal & Tambang)

event_inherited();
target_room = rm_dungeon_floor2;
target_x = 640;
target_y = 160;
door_title = "Lantai 2: Gua Kristal & Tambang";
door_subtitle = "Dungeon Lantai 2";

// SYARAT MUTLAK: Pedang Minimal Level 2 (Forged Iron Blade)
required_boss_key = false;
required_weapon_tier = 2;
locked_message = "Gerbang Tersegel! Pedangmu belum cukup tajam untuk menembus energi Lantai 2. Tempa pedangmu minimal ke Level 2 di Bengkel Goran!";
