/// @description Step Event - State Machine Transisi, Potion, Hotkey Menu Status & Toko

if (transition_state == "fade_out") {
    fade_alpha += 0.08;
    if (fade_alpha >= 1.0) {
        fade_alpha = 1.0;
        global.spawn_x = target_x;
        global.spawn_y = target_y;
        
        if (target_room != noone && room_exists(target_room)) {
            room_goto(target_room);
        }
        
        transition_state = "fade_in";
        banner_timer = 160;
    }
} else if (transition_state == "fade_in") {
    fade_alpha -= 0.06;
    if (fade_alpha <= 0.0) {
        fade_alpha = 0.0;
        transition_state = "idle";
    }
}

if (banner_timer > 0) {
    banner_timer--;
}

// 1. Pemain Minum Potion saat menekan tombol C
if (keyboard_check_pressed(ord("C")) && !global.dialogue_active && !global.stat_menu_open && global.shop_menu_open == "" && global.player_potions > 0 && global.player_hp < global.player_max_hp) {
    global.player_potions--;
    scr_heal_player(45);
}

// 2. Buka / Tutup Menu Status & Alokasi Stat [P] atau [TAB]
if (!global.dialogue_active && global.shop_menu_open == "") {
    if (keyboard_check_pressed(ord("P")) || keyboard_check_pressed(vk_tab)) {
        global.stat_menu_open = !global.stat_menu_open;
    }
}

// 3. Kontrol Input saat Menu Status Terbuka
if (global.stat_menu_open) {
    if (keyboard_check_pressed(vk_escape)) {
        global.stat_menu_open = false;
    }
    
    // Alokasi Stat Poin (Tekan 1-4)
    if (global.stat_points > 0) {
        if (keyboard_check_pressed(ord("1"))) scr_allocate_stat("vit");
        if (keyboard_check_pressed(ord("2"))) scr_allocate_stat("str");
        if (keyboard_check_pressed(ord("3"))) scr_allocate_stat("int");
        if (keyboard_check_pressed(ord("4"))) scr_allocate_stat("agi");
    }
}

// 4. Kontrol Input saat Toko Tempa Goran Terbuka
if (global.shop_menu_open == "goran") {
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"))) {
        global.shop_menu_open = "";
    }
    
    // Tekan SPACE untuk Tempa Senjata
    if (keyboard_check_pressed(vk_space)) {
        var _upgraded = false;
        if (global.weapon_tier == 1) {
            // Syarat Tier 2: 4 Scrap Iron, 2 Iron Ore, 40 Gold
            if (global.mat_scrap_iron >= 4 && global.mat_iron_ore >= 2 && global.gold >= 40) {
                global.mat_scrap_iron -= 4;
                global.mat_iron_ore -= 2;
                global.gold -= 40;
                global.weapon_tier = 2;
                global.weapon_name = "Pedang Besi Tempa";
                _upgraded = true;
                scr_set_quest(3, "Jelajahi Katakombe Purba", "Gunakan Pedang Tier 2 untuk membuka Segel Katakombe");
            }
        } else if (global.weapon_tier == 2) {
            // Syarat Tier 3: 6 Iron Ore, 4 Bone Shard, 120 Gold
            if (global.mat_iron_ore >= 6 && global.mat_bone_shard >= 4 && global.gold >= 120) {
                global.mat_iron_ore -= 6;
                global.mat_bone_shard -= 4;
                global.gold -= 120;
                global.weapon_tier = 3;
                global.weapon_name = "Pedang Baja Damaskus";
                _upgraded = true;
            }
        } else if (global.weapon_tier == 3) {
            // Syarat Tier 4: 2 Magic Crystal, 6 Bone Shard, 250 Gold
            if (global.mat_magic_crystal >= 2 && global.mat_bone_shard >= 6 && global.gold >= 250) {
                global.mat_magic_crystal -= 2;
                global.mat_bone_shard -= 6;
                global.gold -= 250;
                global.weapon_tier = 4;
                global.weapon_name = "Pedang Perak Runic";
                _upgraded = true;
            }
        }
        
        if (_upgraded) {
            banner_title = "SENJATA DITEMPA: " + global.weapon_name;
            banner_subtitle = "Kekuatan serangan dan jangkauan tebasan bertambah drastis!";
            banner_timer = 160;
        }
    }
}

// 5. Kontrol Input saat Toko Alkimia Elysia Terbuka
if (global.shop_menu_open == "elysia") {
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"))) {
        global.shop_menu_open = "";
    }
    
    // Tekan 1: Beli Ramuan (25 Gold)
    if (keyboard_check_pressed(ord("1"))) {
        if (global.gold >= 25 && global.player_potions < 5) {
            global.gold -= 25;
            global.player_potions++;
            banner_title = "MEMBELI RAMUAN DARAH";
            banner_subtitle = "Ramuan bertambah! Tekan [C] saat bertarung.";
            banner_timer = 120;
        }
    }
    
    // Tekan 2: Pelajari Sihir Frost Nova (5 Slime Jelly, 1 Magic Crystal, 80 Gold)
    if (keyboard_check_pressed(ord("2"))) {
        if (!global.spell_unlocked_frost && global.mat_slime_jelly >= 5 && global.mat_magic_crystal >= 1 && global.gold >= 80) {
            global.mat_slime_jelly -= 5;
            global.mat_magic_crystal -= 1;
            global.gold -= 80;
            global.spell_unlocked_frost = true;
            global.spell_selected = 2;
            banner_title = "SIHIR BARU: FROST NOVA";
            banner_subtitle = "Ganti sihir dengan [Q], ledakkan es radial dengan [X]!";
            banner_timer = 180;
        }
    }
    
    // Tekan 3: Ramuan Elixir Mana (+20 Max MP permanen - 4 Slime Jelly, 2 Magic Crystal, 150 Gold)
    if (keyboard_check_pressed(ord("3"))) {
        if (global.mat_slime_jelly >= 4 && global.mat_magic_crystal >= 2 && global.gold >= 150) {
            global.mat_slime_jelly -= 4;
            global.mat_magic_crystal -= 2;
            global.gold -= 150;
            global.stat_int += 3;
            scr_recalculate_stats();
            banner_title = "ELIXIR MANA DIMINUM!";
            banner_subtitle = "+3 INT permanen! Kapasitas Mana dan Magic Power meningkat.";
            banner_timer = 160;
        }
    }
}
