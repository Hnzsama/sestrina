/// @description Sistem Manajemen Audio Kategori-Sentris (Category-Based Modular Sound System)
/// Memudahkan penambahan fitur baru di masa depan secara otomatis berdasarkan kategori aksi.

/// @function scr_play_sfx(sound_id, [pitch_variation], [gain], [priority])
function scr_play_sfx(_snd, _var = 0.08, _gain = 1.0, _prio = 10) {
    if (!audio_exists(_snd)) return -1;
    var _inst = audio_play_sound(_snd, _prio, false);
    if (_var > 0) {
        audio_sound_pitch(_inst, random_range(1.0 - _var, 1.0 + _var));
    }
    var _master_sfx = variable_global_exists("sfx_volume") ? global.sfx_volume : 1.0;
    audio_sound_gain(_inst, _gain * _master_sfx, 0);
    return _inst;
}

/// @function scr_audio_play(category, [action_or_sub], [pitch_var], [gain])
/// @description Central Dispatcher: Cukup sebut kategori ("sword", "spell", "dodge", "ui", "footstep", "interact", dsb.)
function scr_audio_play(_category, _action = "", _var = 0.08, _gain = 1.0) {
    switch (_category) {
        // 1. Kategori Tebasan Pedang Kombo
        case "sword":
        case "attack":
            if (_action == 2 || _action == "combo2") {
                return scr_play_sfx(snd_sword_attack_2, 0.06, _gain * 0.95, 12);
            } else if (_action == 3 || _action == "combo3" || _action == "finisher") {
                return scr_play_sfx(snd_sword_attack_3, 0.08, _gain * 1.05, 15);
            } else {
                return scr_play_sfx(snd_sword_attack_1, 0.06, _gain * 0.9, 12);
            }
            
        // 2. Kategori Hantaman & Benturan Pedang
        case "hit":
        case "impact":
            if (_action == "heavy" || _action == true) {
                return scr_play_sfx(snd_sword_hit_2, 0.1, _gain * 1.05, 14);
            } else if (_action == "parry" || _action == "deflect") {
                return scr_play_sfx(snd_sword_parry, 0.08, _gain * 1.0, 14);
            } else {
                return scr_play_sfx(snd_sword_hit_1, 0.1, _gain * 0.9, 13);
            }
            
        // 3. Kategori Menghindar & Perfect Dodge
        case "dodge":
        case "evade":
            if (_action == "perfect") {
                scr_play_sfx(snd_sword_parry, 0.06, _gain * 0.9, 14);
                return scr_play_sfx(snd_perfect_dodge, 0.04, _gain * 1.15, 15);
            } else {
                return scr_play_sfx(snd_dodge_roll, 0.08, _gain * 0.9, 12);
            }
            
        // 4. Kategori Sihir & Mantra
        case "spell":
        case "magic":
            if (_action == "fireball" || _action == 1) {
                return scr_play_sfx(snd_fireball, 0.08, _gain * 0.95, 12);
            } else if (_action == "fire_impact") {
                return scr_play_sfx(snd_fire_impact, 0.08, _gain * 1.0, 14);
            } else if (_action == "frost" || _action == "frost_nova" || _action == 2) {
                return scr_play_sfx(snd_frost_nova, 0.06, _gain * 1.0, 13);
            } else if (_action == "ice_barrage") {
                return scr_play_sfx(snd_ice_barrage, 0.08, _gain * 0.9, 13);
            } else if (_action == "potion" || _action == "heal" || _action == "buff") {
                return scr_play_sfx(snd_drink_potion, 0.05, _gain * 0.95, 11);
            }
            break;
            
        // 5. Kategori Langkah Kaki (Auto-Detect Lantai Ruangan jika tidak dispesifikasikan)
        case "footstep":
        case "step":
            var _surf = _action;
            if (_surf == "" || _surf == "auto") {
                var _r = room_get_name(room);
                if (_r == "Room1") _surf = "wood";
                else if (_r == "rm_outskirts") _surf = "dirt";
                else _surf = "stone";
            }
            if (_surf == "dirt") {
                return scr_play_sfx(choose(snd_step_dirt_1, snd_step_dirt_2), 0.12, _gain * 0.45, 5);
            } else if (_surf == "wood") {
                return scr_play_sfx(choose(snd_step_wood_1, snd_step_wood_2), 0.12, _gain * 0.5, 5);
            } else {
                return scr_play_sfx(choose(snd_step_stone_1, snd_step_stone_2), 0.12, _gain * 0.5, 5);
            }
            
        // 6. Kategori Antarmuka Pengguna (UI)
        case "ui":
        case "menu":
            if (_action == "confirm" || _action == "select" || _action == "buy") {
                return scr_play_sfx(snd_ui_confirm, 0.04, _gain * 0.9, 10);
            } else if (_action == "cancel" || _action == "back" || _action == "locked") {
                return scr_play_sfx(snd_ui_cancel, 0.04, _gain * 0.85, 10);
            } else {
                return scr_play_sfx(snd_ui_move, 0.05, _gain * 0.65, 8);
            }
            
        // 7. Kategori Interaksi & Lingkungan
        case "interact":
        case "environment":
            if (_action == "door_open") {
                return scr_play_sfx(snd_door_open, 0.05, _gain * 0.85, 10);
            } else if (_action == "door_close") {
                return scr_play_sfx(snd_door_close, 0.05, _gain * 0.8, 10);
            } else if (_action == "chest_open" || _action == "chest") {
                return scr_play_sfx(snd_chest_open, 0.05, _gain * 1.0, 12);
            } else if (_action == "chest_close") {
                return scr_play_sfx(snd_chest_close, 0.05, _gain * 0.9, 10);
            } else if (_action == "gate") {
                return scr_play_sfx(snd_gate_open, 0.06, _gain * 0.95, 12);
            } else if (_action == "lever" || _action == "switch") {
                return scr_play_sfx(snd_lever_switch, 0.04, _gain * 1.0, 13);
            } else if (_action == "mine") {
                return scr_play_sfx(choose(snd_mining_1, snd_mining_2), 0.1, _gain * 0.95, 11);
            } else if (_action == "chop") {
                return scr_play_sfx(snd_chop_1, 0.08, _gain * 0.95, 11);
            } else if (_action == "break_pot" || _action == "pot") {
                return scr_play_sfx(snd_boss_rock, 0.12, _gain * 0.85, 10);
            } else if (_action == "pickup") {
                return scr_play_sfx(snd_ui_confirm, 0.15, _gain * 0.75, 9);
            }
            break;
            
        // 8. Kategori Boss & Monster
        case "boss":
        case "monster":
            if (_action == "stomp" || _action == "quake") {
                return scr_play_sfx(snd_boss_stomp, 0.08, _gain * 1.1, 15);
            } else if (_action == "rock" || _action == "boulder") {
                return scr_play_sfx(snd_boss_rock, 0.08, _gain * 1.0, 13);
            }
            break;
    }
    return -1;
}

// -----------------------------------------------------------------------------
// Shorthand Helper Functions (Wrapper sederhana yang otomatis memetakan ke kategori)
// -----------------------------------------------------------------------------

function scr_play_sword_slash(_combo) {
    return scr_audio_play("sword", _combo);
}

function scr_play_sword_hit(_heavy = false) {
    return scr_audio_play("hit", _heavy ? "heavy" : "light");
}

function scr_play_footstep(_surf = "auto") {
    return scr_audio_play("footstep", _surf);
}

function scr_play_ui(_act) {
    return scr_audio_play("ui", _act);
}
