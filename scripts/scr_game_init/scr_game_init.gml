/// @description Global Game State & Quest Initialization for Sestrina RPG

// Pastikan inisialisasi hanya berjalan sekali
if (!variable_global_exists("game_initialized")) {
    global.game_initialized = true;
    
    // Status Quest (Berdasarkan Dokumen Desain Sestrina & Red Eyes)
    // 0: Awal - Bicara ke Sestrina di kamar (Kondisi Overclock Mana Leak)
    // 1: Menuju Kota Altdorf - Persiapan di Pandai Besi Goran & Alkemis Elysia
    // 2: Sudah bersenjata & dibekali ramuan - Menuju Outskirts Hutan Reruntuhan Kuno
    // 3: Menjelajahi Katakombe Terlarang & Menghadapi Mini-Boss Stone Golem
    // 4: Membuka Segel Kuil Purba (Forgotten Sanctum) & Menghadapi Legendary Guardian
    // 5: Memperoleh The Lost Remedy & Kembali Menyelamatkan Sestrina (Ending)
    global.quest_stage = 0;
    global.quest_title = "Pencarian The Lost Remedy";
    global.quest_desc = "Periksa kondisi Sestrina di ranjang (Overclock Mana Leak)";
    
    // Siklus Waktu Day/Night & Urgensi Pacuan Waktu (Time-Race)
    global.day_count = 1;
    global.time_of_day = "Daytime"; // "Daytime" | "Nighttime"
    global.sister_condition = 100;   // 100% prima -> menurun jika hari berlarut
    
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
    global.armor_name = "Zirah Ksatria";
    global.acc_name = "Pita Harapan";
    
    // Compatibility aliases untuk UI Stat Pack
    global.mat_slime = 0;
    global.mat_bone = 0;
    global.mat_scrap = 0;
    global.mat_ore = 0;
    global.mat_crystal = 0;
    global.potions_hp = 1;
    global.boss_key = false;
    global.catacombs_unlocked = false;
    global.dungeon_catacombs_unlocked = false;
    global.remedy_found = false;
    
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
    
    // Sistem Party Companion (Goran Blacksmith)
    global.party_goran = false;
    global.goran_hp = 300;
    global.goran_max_hp = 300;
    
    // State Menu UI & Dialog
    global.main_menu_open = false;
    global.stat_menu_open = false;
    global.save_menu_open = false;
    global.shop_menu_open = "";
    
    // Auto-spawn JRPG Menu Manager jika belum ada
    if (!instance_exists(oMenuManager)) {
        instance_create_depth(0, 0, -10500, oMenuManager);
    }
    
    // Multi-Ending & Demon Power (Prioritas 4 - Red Eyes Lore)
    global.demon_unsealed = false;
    global.game_ending = ""; // "human", "half_demon", "death"
    
    // Peta Distrik & Konfirmasi Batas Wilayah (Prioritas 3 - Reference UI)
    global.map_menu_open = false;
    global.leave_confirm_active = false;
    global.leave_confirm_target_room = noone;
    global.leave_confirm_target_x = 0;
    global.leave_confirm_target_y = 0;
    global.leave_confirm_area_name = "";
    global.leave_confirm_selection = 0; // 0: Leave, 1: Don't leave
    
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
    
    // Status Lingkungan & Simpanan Objek
    global.opened_chests = [];
    global.catacombs_gate_opened = false;
    
    // Pengaturan Game (Audio BGM/SFX & Tampilan Layar)
    global.bgm_volume = 1.0;
    global.sfx_volume = 1.0;
    global.is_fullscreen = false;
}

/// @function scr_start_new_game()
/// @description Mereset seluruh variabel permainan dan memulai petualangan baru di Kamar Sestrina
function scr_start_new_game() {
    global.quest_stage = 0;
    global.quest_title = "Pencarian The Lost Remedy";
    global.quest_desc = "Periksa kondisi Sestrina di ranjang (Overclock Mana Leak)";
    global.day_count = 1;
    global.time_of_day = "Daytime";
    global.sister_condition = 100;
    
    global.player_level = 1;
    global.player_exp = 0;
    global.player_max_exp = 60;
    global.stat_points = 0;
    global.stat_vit = 5;
    global.stat_str = 5;
    global.stat_int = 5;
    global.stat_agi = 5;
    scr_recalculate_stats();
    
    global.player_hp = global.player_max_hp;
    global.player_mp = global.player_max_mp;
    global.player_stamina = global.player_max_stamina;
    global.player_potions = 1;
    global.player_has_sword = false;
    global.player_has_remedy = false;
    global.gold = 50;
    global.weapon_tier = 0;
    global.weapon_name = "Tangan Kosong";
    
    global.mat_slime_jelly = 0;
    global.mat_bone_shard = 0;
    global.mat_scrap_iron = 0;
    global.mat_iron_ore = 0;
    global.mat_magic_crystal = 0;
    
    global.spell_unlocked_fireball = false;
    global.spell_unlocked_frost = false;
    global.spell_selected = 0;
    
    global.has_catacomb_key = false;
    global.has_boss_key = false;
    global.party_goran = false;
    global.demon_unsealed = false;
    global.game_ending = "";
    global.spawn_x = -1;
    global.spawn_y = -1;
    global.dialogue_active = false;
    global.shop_menu_open = "";
    global.stat_menu_open = false;
    global.save_menu_open = false;
    global.map_menu_open = false;
    global.leave_confirm_active = false;
    global.opened_chests = [];
    
    // Pastikan persistent manager objects selalu ada sejak New Game
    if (!instance_exists(oRoomTransition)) {
        instance_create_depth(0, 0, -10000, oRoomTransition);
    }
    var _tr = instance_find(oRoomTransition, 0);
    _tr.transition_state = "fade_in";
    _tr.fade_alpha = 1.0;
    _tr.banner_title = "Kamar Tidur Kastil";
    _tr.banner_subtitle = "Tempat peristirahatan Sestrina";
    _tr.banner_timer = 160;
    _tr.refresh_save_slots();
    
    if (!instance_exists(oDialogueManager)) {
        instance_create_depth(0, 0, -15000, oDialogueManager);
    }
    if (!instance_exists(oMenuManager)) {
        instance_create_depth(0, 0, -10500, oMenuManager);
    }
    
    // Pindah ke Kamar Sestrina
    room_goto(Room1);
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

/// @function scr_advance_time()
/// @description Memajukan siklus Day/Night dan memperbarui kondisi sakit adik
function scr_advance_time() {
    if (global.time_of_day == "Daytime") {
        global.time_of_day = "Nighttime";
    } else {
        global.time_of_day = "Daytime";
        global.day_count += 1;
        // Penyakit adik memburuk perlahan jika waktu terbuang
        global.sister_condition = max(10, global.sister_condition - 15);
    }
    
    // Efek Banner Notifikasi Pergantian Waktu
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.banner_title = "WAKTU BERGANTI";
        oRoomTransition.banner_subtitle = "Day " + string(global.day_count) + " - " + global.time_of_day;
        oRoomTransition.banner_timer = 150;
    }
}

// =========================================================================
// SISTEM SAVE & LOAD STATE (UAS Testing & Progression Feature)
// =========================================================================

/// @function scr_save_game([slot])
/// @description Menyimpan seluruh state permainan, posisi pemain, quest, dan inventori ke file JSON
function scr_save_game(_slot = "quicksave") {
    var _filename = "save_" + string(_slot) + ".json";
    
    // Tentukan koordinat pemain
    var _px = 640;
    var _py = 360;
    var _facing = "down";
    if (instance_exists(oPlayer)) {
        _px = round(oPlayer.x);
        _py = round(oPlayer.y);
        if (variable_instance_exists(oPlayer, "facingDir")) {
            _facing = oPlayer.facingDir;
        }
    } else if (variable_global_exists("spawn_x") && global.spawn_x != -1) {
        _px = global.spawn_x;
        _py = global.spawn_y;
    }
    
    var _save_data = {
        save_version: 1,
        save_time_str: "Day " + string(global.day_count) + " (" + string(global.time_of_day) + ")",
        room_name: room_get_name(room),
        player_x: _px,
        player_y: _py,
        player_facing: _facing,
        
        // Level & Exp
        player_level: global.player_level,
        player_exp: global.player_exp,
        player_max_exp: global.player_max_exp,
        stat_points: global.stat_points,
        
        // Atribut Dasar
        stat_vit: global.stat_vit,
        stat_str: global.stat_str,
        stat_int: global.stat_int,
        stat_agi: global.stat_agi,
        
        // Resource Pool
        player_hp: global.player_hp,
        player_max_hp: global.player_max_hp,
        player_mp: global.player_mp,
        player_max_mp: global.player_max_mp,
        player_stamina: global.player_stamina,
        player_max_stamina: global.player_max_stamina,
        
        // Inventori, Senjata & Uang
        gold: global.gold,
        player_potions: global.player_potions,
        player_has_sword: global.player_has_sword,
        weapon_tier: global.weapon_tier,
        weapon_name: global.weapon_name,
        player_has_remedy: global.player_has_remedy,
        has_catacomb_key: global.has_catacomb_key,
        has_boss_key: global.has_boss_key,
        party_goran: variable_global_exists("party_goran") ? global.party_goran : false,
        goran_hp: variable_global_exists("goran_hp") ? global.goran_hp : 300,
        demon_unsealed: global.demon_unsealed,
        game_ending: global.game_ending,
        
        // Material Tempa & Alkimia
        mat_slime_jelly: global.mat_slime_jelly,
        mat_bone_shard: global.mat_bone_shard,
        mat_scrap_iron: global.mat_scrap_iron,
        mat_iron_ore: global.mat_iron_ore,
        mat_magic_crystal: global.mat_magic_crystal,
        
        // Sihir (Magic)
        spell_unlocked_fireball: global.spell_unlocked_fireball,
        spell_unlocked_frost: global.spell_unlocked_frost,
        spell_selected: global.spell_selected,
        
        // Quest & Alur Waktu
        quest_stage: global.quest_stage,
        quest_title: global.quest_title,
        quest_desc: global.quest_desc,
        day_count: global.day_count,
        time_of_day: global.time_of_day,
        sister_condition: global.sister_condition,
        
        // Status Lingkungan
        opened_chests: variable_global_exists("opened_chests") ? global.opened_chests : [],
        catacombs_gate_opened: variable_global_exists("catacombs_gate_opened") ? global.catacombs_gate_opened : false
    };
    
    // Tulis ke JSON file
    var _json_str = json_stringify(_save_data);
    var _f = file_text_open_write(_filename);
    if (_f != -1) {
        file_text_write_string(_f, _json_str);
        file_text_close(_f);
        
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "GAME TERSIMPAN! [F5]";
            oRoomTransition.banner_subtitle = "Lokasi: " + room_get_name(room) + " • Tekan [F6] untuk Memuat";
            oRoomTransition.banner_timer = 150;
        }
        return true;
    }
    return false;
}

/// @function scr_load_game([slot])
/// @description Memuat data permainan dari file JSON dan menempatkan pemain di posisi tersimpan
function scr_load_game(_slot = "quicksave") {
    var _filename = "save_" + string(_slot) + ".json";
    
    if (!file_exists(_filename)) {
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "BELUM ADA SIMPANAN!";
            oRoomTransition.banner_subtitle = "Tekan [F5] terlebih dahulu untuk Quick Save game Anda.";
            oRoomTransition.banner_timer = 140;
        }
        return false;
    }
    
    var _f = file_text_open_read(_filename);
    var _json_str = "";
    while (!file_text_eof(_f)) {
        _json_str += file_text_readln(_f);
    }
    file_text_close(_f);
    
    var _data = undefined;
    try {
        _data = json_parse(_json_str);
    } catch (_err) {
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "GAGAL MEMUAT!";
            oRoomTransition.banner_subtitle = "Berkas simpanan rusak atau format tidak cocok.";
            oRoomTransition.banner_timer = 140;
        }
        return false;
    }
    
    if (is_undefined(_data) || !is_struct(_data)) return false;
    
    // Pastikan persistent manager objects selalu ada saat memuat game
    if (!instance_exists(oRoomTransition)) {
        instance_create_depth(0, 0, -10000, oRoomTransition);
    }
    var _tr = instance_find(oRoomTransition, 0);
    _tr.refresh_save_slots();
    
    if (!instance_exists(oDialogueManager)) {
        instance_create_depth(0, 0, -15000, oDialogueManager);
    }
    if (!instance_exists(oMenuManager)) {
        instance_create_depth(0, 0, -10500, oMenuManager);
    }
    
    // 1. Pulihkan Level & Exp
    global.player_level = variable_struct_exists(_data, "player_level") ? _data.player_level : 1;
    global.player_exp = variable_struct_exists(_data, "player_exp") ? _data.player_exp : 0;
    global.player_max_exp = variable_struct_exists(_data, "player_max_exp") ? _data.player_max_exp : 60;
    global.stat_points = variable_struct_exists(_data, "stat_points") ? _data.stat_points : 0;
    
    // 2. Pulihkan Atribut
    global.stat_vit = variable_struct_exists(_data, "stat_vit") ? _data.stat_vit : 5;
    global.stat_str = variable_struct_exists(_data, "stat_str") ? _data.stat_str : 5;
    global.stat_int = variable_struct_exists(_data, "stat_int") ? _data.stat_int : 5;
    global.stat_agi = variable_struct_exists(_data, "stat_agi") ? _data.stat_agi : 5;
    
    scr_recalculate_stats();
    
    // 3. Pulihkan Resource Bar
    global.player_hp = variable_struct_exists(_data, "player_hp") ? _data.player_hp : global.player_max_hp;
    global.player_mp = variable_struct_exists(_data, "player_mp") ? _data.player_mp : global.player_max_mp;
    global.player_stamina = variable_struct_exists(_data, "player_stamina") ? _data.player_stamina : global.player_max_stamina;
    
    // 4. Inventori & Peralatan
    global.gold = variable_struct_exists(_data, "gold") ? _data.gold : 50;
    global.player_potions = variable_struct_exists(_data, "player_potions") ? _data.player_potions : 1;
    global.player_has_sword = variable_struct_exists(_data, "player_has_sword") ? _data.player_has_sword : false;
    global.weapon_tier = variable_struct_exists(_data, "weapon_tier") ? _data.weapon_tier : 0;
    global.weapon_name = variable_struct_exists(_data, "weapon_name") ? _data.weapon_name : "Tangan Kosong";
    global.player_has_remedy = variable_struct_exists(_data, "player_has_remedy") ? _data.player_has_remedy : false;
    global.has_catacomb_key = variable_struct_exists(_data, "has_catacomb_key") ? _data.has_catacomb_key : false;
    global.has_boss_key = variable_struct_exists(_data, "has_boss_key") ? _data.has_boss_key : false;
    global.party_goran = variable_struct_exists(_data, "party_goran") ? _data.party_goran : false;
    global.goran_hp = variable_struct_exists(_data, "goran_hp") ? _data.goran_hp : 300;
    global.demon_unsealed = variable_struct_exists(_data, "demon_unsealed") ? _data.demon_unsealed : false;
    global.game_ending = variable_struct_exists(_data, "game_ending") ? _data.game_ending : "";
    
    // 5. Material
    global.mat_slime_jelly = variable_struct_exists(_data, "mat_slime_jelly") ? _data.mat_slime_jelly : 0;
    global.mat_bone_shard = variable_struct_exists(_data, "mat_bone_shard") ? _data.mat_bone_shard : 0;
    global.mat_scrap_iron = variable_struct_exists(_data, "mat_scrap_iron") ? _data.mat_scrap_iron : 0;
    global.mat_iron_ore = variable_struct_exists(_data, "mat_iron_ore") ? _data.mat_iron_ore : 0;
    global.mat_magic_crystal = variable_struct_exists(_data, "mat_magic_crystal") ? _data.mat_magic_crystal : 0;
    
    // 6. Sihir
    global.spell_unlocked_fireball = variable_struct_exists(_data, "spell_unlocked_fireball") ? _data.spell_unlocked_fireball : false;
    global.spell_unlocked_frost = variable_struct_exists(_data, "spell_unlocked_frost") ? _data.spell_unlocked_frost : false;
    global.spell_selected = variable_struct_exists(_data, "spell_selected") ? _data.spell_selected : 0;
    
    // 7. Quest & Waktu
    global.quest_stage = variable_struct_exists(_data, "quest_stage") ? _data.quest_stage : 0;
    global.quest_title = variable_struct_exists(_data, "quest_title") ? _data.quest_title : "Pencarian The Lost Remedy";
    global.quest_desc = variable_struct_exists(_data, "quest_desc") ? _data.quest_desc : "Periksa kondisi Sestrina di ranjang (Overclock Mana Leak)";
    global.day_count = variable_struct_exists(_data, "day_count") ? _data.day_count : 1;
    global.time_of_day = variable_struct_exists(_data, "time_of_day") ? _data.time_of_day : "Daytime";
    global.sister_condition = variable_struct_exists(_data, "sister_condition") ? _data.sister_condition : 100;
    
    // 8. Status Lingkungan
    global.opened_chests = variable_struct_exists(_data, "opened_chests") ? _data.opened_chests : [];
    global.catacombs_gate_opened = variable_struct_exists(_data, "catacombs_gate_opened") ? _data.catacombs_gate_opened : false;
    
    // Reset seluruh state menu dan dialog agar tidak terkunci saat memuat game
    global.dialogue_active = false;
    global.shop_menu_open = "";
    global.stat_menu_open = false;
    global.save_menu_open = false;
    global.map_menu_open = false;
    global.leave_confirm_active = false;
    if (variable_global_exists("main_menu_open")) global.main_menu_open = false;
    if (variable_global_exists("is_paused")) global.is_paused = false;
    
    // 9. Pindah Ruangan & Posisikan Pemain
    var _target_room = Room1;
    if (variable_struct_exists(_data, "room_name")) {
        var _parsed_room = asset_get_index(_data.room_name);
        if (_parsed_room != -1 && room_exists(_parsed_room)) {
            _target_room = _parsed_room;
        }
    }
    if (_target_room == rm_outskirts) {
        _target_room = rm_catacombs;
        _data.player_x = 640;
        _data.player_y = 120;
    }
    
    var _px = variable_struct_exists(_data, "player_x") ? _data.player_x : 405;
    var _py = variable_struct_exists(_data, "player_y") ? _data.player_y : 285;
    global.spawn_x = _px;
    global.spawn_y = _py;
    
    if (room == _target_room) {
        if (instance_exists(oPlayer)) {
            oPlayer.x = _px;
            oPlayer.y = _py;
            if (variable_struct_exists(_data, "player_facing") && variable_instance_exists(oPlayer, "facingDir")) {
                oPlayer.facingDir = _data.player_facing;
            }
        }
        _tr.banner_title = "GAME DIMUAT! [F6]";
        _tr.banner_subtitle = "Progres petualangan berhasil dimuat!";
        _tr.banner_timer = 160;
    } else {
        if (room == rm_main_menu) {
            // Karena Main Menu sudah fade out ke hitam, atur fade_in di target_room
            _tr.transition_state = "fade_in";
            _tr.fade_alpha = 1.0;
            _tr.target_room = _target_room;
            _tr.target_x = _px;
            _tr.target_y = _py;
            _tr.banner_title = "GAME DIMUAT!";
            _tr.banner_subtitle = "Melanjutkan petualangan...";
            _tr.banner_timer = 160;
            room_goto(_target_room);
        } else {
            _tr.start_transition(_target_room, _px, _py, "GAME DIMUAT", "Melanjutkan petualangan...");
        }
    }
    
    return true;
}

/// @function scr_has_save_data([slot])
function scr_has_save_data(_slot = "quicksave") {
    return file_exists("save_" + string(_slot) + ".json");
}

/// @function scr_get_save_info([slot])
/// @description Mengambil metadata ringkas file simpanan untuk UI jendela save multi-slot
function scr_get_save_info(_slot = "quicksave") {
    var _filename = "save_" + string(_slot) + ".json";
    if (!file_exists(_filename)) {
        return {
            exists: false,
            slot: _slot,
            room_title: "Slot Kosong",
            time_str: "-",
            level_str: "-",
            quest_str: "Belum ada file simpanan di slot ini."
        };
    }
    
    var _f = file_text_open_read(_filename);
    var _json_str = "";
    while (!file_text_eof(_f)) {
        _json_str += file_text_readln(_f);
    }
    file_text_close(_f);
    
    var _data = undefined;
    try {
        _data = json_parse(_json_str);
    } catch (_err) {
        return {
            exists: false,
            slot: _slot,
            room_title: "Data Rusak",
            time_str: "-",
            level_str: "-",
            quest_str: "File simpanan mengalami kerusakan."
        };
    }
    
    if (is_undefined(_data) || !is_struct(_data)) {
        return { exists: false, slot: _slot, room_title: "Slot Kosong", time_str: "-", level_str: "-", quest_str: "-" };
    }
    
    var _r_raw = variable_struct_exists(_data, "room_name") ? _data.room_name : "Room1";
    var _r_title = "Kamar Tidur Sestrina";
    if (_r_raw == "rm_town_square") _r_title = "Alun-Alun Kota Altdorf";
    else if (_r_raw == "rm_outskirts") _r_title = "Pelataran Kuil Purba";
    else if (_r_raw == "rm_catacombs") _r_title = "Katakombe Bawah Tanah";
    else if (_r_raw == "rm_dungeon_floor2") _r_title = "Dungeon Lantai 2 (Kuil Kuno)";
    else if (_r_raw == "rm_boss_chamber") _r_title = "Sanctum Core (Altar Lost Remedy)";
    else if (_r_raw == "rm_potion_shop") _r_title = "Apotek Herbal Elysia";
    else if (_r_raw == "rm_weapon_shop") _r_title = "Bengkel Tempa Goran";
    
    var _t_str = variable_struct_exists(_data, "save_time_str") ? _data.save_time_str : "Day 1 (Daytime)";
    var _lvl = variable_struct_exists(_data, "player_level") ? _data.player_level : 1;
    var _wpn = variable_struct_exists(_data, "weapon_name") ? _data.weapon_name : "Tangan Kosong";
    var _hp = variable_struct_exists(_data, "player_hp") ? _data.player_hp : 100;
    var _max_hp = variable_struct_exists(_data, "player_max_hp") ? _data.player_max_hp : 100;
    var _gold = variable_struct_exists(_data, "gold") ? _data.gold : 0;
    
    var _q_title = variable_struct_exists(_data, "quest_title") ? _data.quest_title : "Petualangan Sestrina";
    
    return {
        exists: true,
        slot: _slot,
        room_name: _r_raw,
        room_title: _r_title,
        time_str: _t_str,
        level: _lvl,
        level_str: "Lv " + string(_lvl) + " • " + _wpn + " • " + string(_hp) + "/" + string(_max_hp) + " HP • " + string(_gold) + " Gold",
        quest_str: "▶ " + _q_title
    };
}

/// @function scr_delete_save_game([slot])
/// @description Menghapus file simpanan spesifik
function scr_delete_save_game(_slot = "quicksave") {
    var _filename = "save_" + string(_slot) + ".json";
    if (file_exists(_filename)) {
        file_delete(_filename);
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "SLOT DIHAPUS";
            oRoomTransition.banner_subtitle = "File simpanan pada " + string(_slot) + " telah dibersihkan.";
            oRoomTransition.banner_timer = 120;
        }
        return true;
    }
    return false;
}
