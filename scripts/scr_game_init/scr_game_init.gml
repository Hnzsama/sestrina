/// @description Global Game State & Quest Initialization for Sestrina RPG

// Pastikan inisialisasi hanya berjalan sekali
if (!variable_global_exists("game_initialized")) {
    global.game_initialized = true;
    
    // Status Quest
    // 0: Awal - Bicara ke Sestrina
    // 1: Menuju Kota Altdorf - Temui Blacksmith Goran & Alkemis Elysia
    // 2: Sudah bersenjata & dibekali ramuan - Menuju Hutan Reruntuhan Kuno
    // 3: Menjelajahi Katakombe
    // 4: Mengalahkan Boss Golem Purba & Mendapatkan Bunga Cahaya Abadi
    // 5: Kembali ke Kamar Sestrina & Memberikan Obat Penawar (Ending)
    global.quest_stage = 0;
    global.quest_title = "Cari Obat untuk Sestrina";
    global.quest_desc = "Bicara dengan Sestrina di tempat tidur";
    
    // Status Pemain & Progresi ARPG
    global.player_level = 1;
    global.player_exp = 0;
    global.player_max_exp = 60;
    global.stat_points = 0;
    
    // 4 Atribut Dasar
    global.stat_vit = 5; // Vitalitas (HP & Ketahanan)
    global.stat_str = 5; // Kekuatan (Damage Fisik & Kombo)
    global.stat_int = 5; // Kecerdasan (Mana Max, Regen, & Magic Power)
    global.stat_agi = 5; // Kelincahan (Stamina & Cooldown Roll)
    
    // Status Bar Pemain
    global.player_hp = 120;
    global.player_max_hp = 120;
    global.player_mp = 80;
    global.player_max_mp = 80;
    global.player_stamina = 100;
    global.player_max_stamina = 100;
    global.player_potions = 1;
    global.player_has_sword = false;
    global.player_has_remedy = false;
    global.gold = 50;

    // Tingkat Senjata (0: Kosong, 1: Rusted Blade, 2: Forged Iron, 3: Steel Broadsword, 4: Rune Silver)
    global.weapon_tier = 0;
    global.weapon_name = "Tangan Kosong";
    
    // Sistem Sihir (Magic Spells)
    global.spell_unlocked_fireball = false;
    global.spell_unlocked_frost = false;
    global.spell_selected = 0; // 0: Belum Ada, 1: Fireball, 2: Frost Nova
    
    // Sistem Material & Inventory Crafting
    global.mat_slime_jelly = 0;
    global.mat_bone_shard = 0;
    global.mat_scrap_iron = 0;
    global.mat_iron_ore = 0;
    global.mat_magic_crystal = 0;
    
    // Kunci Progresi Dungeon
    global.has_catacomb_key = false;
    global.has_boss_key = false;
    
    // State Menu UI
    global.stat_menu_open = false;
    global.shop_menu_open = "";
    
    // Kalkulasi Awal Stat
    scr_recalculate_stats();
    
    // Koordinat Spawn Antar Room
    global.spawn_x = -1;
    global.spawn_y = -1;
    
    // Transisi
    global.transition_active = false;
    global.transition_alpha = 0.0;
    global.transition_text = "";
    global.transition_subtext = "";
}

/// @function scr_set_quest(stage, title, desc)
function scr_set_quest(_stage, _title, _desc) {
    global.quest_stage = _stage;
    global.quest_title = _title;
    global.quest_desc = _desc;
}

/// @function scr_heal_player(amount)
function scr_heal_player(_amount) {
    global.player_hp = min(global.player_max_hp, global.player_hp + _amount);
}
