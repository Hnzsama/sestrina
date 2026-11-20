/// @description Input & Navigation Handler untuk JRPG Modular Menu

if (room == rm_main_menu) {
    global.main_menu_open = false;
    menu_alpha = 0.0;
    exit;
}

// 1. Tombol Buka / Tutup Menu Utama (Pause / Main Menu)
var _key_toggle_menu = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_tab);

if (_key_toggle_menu) {
    // Jangan buka saat dialog aktif atau sedang belanja di toko NPC
    var _can_toggle = (!variable_global_exists("dialogue_active") || !global.dialogue_active) &&
                      (!variable_global_exists("shop_menu_open") || global.shop_menu_open == "") &&
                      (!variable_global_exists("leave_confirm_active") || !global.leave_confirm_active);
    
    if (_can_toggle) {
        // Jika peta atau menu lain sedang terbuka, tutup dulu menu tersebut
        if (variable_global_exists("map_menu_open") && global.map_menu_open) {
            global.map_menu_open = false;
        } else if (variable_global_exists("stat_menu_open") && global.stat_menu_open) {
            global.stat_menu_open = false;
        } else if (variable_global_exists("save_menu_open") && global.save_menu_open) {
            global.save_menu_open = false;
        } else {
            // Toggle menu utama
            global.main_menu_open = !global.main_menu_open;
            if (global.main_menu_open) {
                focus_column = 0;
                detail_sub_index = 0;
                refresh_save_slots();
                scr_play_ui("confirm");
            } else {
                scr_play_ui("cancel");
            }
        }
    }
}

// 2. Animasi Fade Alpha & Toast Timer
if (global.main_menu_open) {
    menu_alpha = lerp(menu_alpha, 1.0, 0.22);
} else {
    menu_alpha = lerp(menu_alpha, 0.0, 0.35);
}

if (menu_toast_timer > 0) {
    menu_toast_timer--;
}

// Hentikan eksekusi jika menu tidak aktif
if (!global.main_menu_open || menu_alpha < 0.05) exit;

// 3. Input Tombol Navigasi
var _key_up      = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _key_down    = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _key_left    = keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A"));
var _key_right   = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
var _key_confirm = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var _key_cancel  = keyboard_check_pressed(ord("X"));

var _num_cmds = array_length(commands);

// 4. Kolom Kiri: Navigasi Daftar Perintah
if (focus_column == 0) {
    if (_key_up) {
        selected_cmd = (selected_cmd - 1 + _num_cmds) % _num_cmds;
        scr_play_ui("move");
    }
    if (_key_down) {
        selected_cmd = (selected_cmd + 1) % _num_cmds;
        scr_play_ui("move");
    }
    
    // Pindah fokus ke panel detail di kanan jika tombol kanan ditekan
    if (_key_right) {
        focus_column = 1;
        detail_sub_index = 0;
        scr_play_ui("confirm");
    }
    
    // Aksi Tombol Konfirmasi [Z]
    if (_key_confirm) {
        var _cmd_id = commands[selected_cmd].id;
        scr_play_ui("confirm");
        
        if (_cmd_id == "close") {
            global.main_menu_open = false;
        } else if (_cmd_id == "map") {
            // Buka Peta Distrik Interaktif
            global.main_menu_open = false;
            global.map_menu_open = true;
        } else if (_cmd_id == "save") {
            focus_column = 1;
            detail_sub_index = 0;
            refresh_save_slots();
        } else {
            // Pindah fokus ke panel detail
            focus_column = 1;
            detail_sub_index = 0;
        }
    }
    
    // Tombol Cancel [X] -> Tutup Menu
    if (_key_cancel) {
        global.main_menu_open = false;
        scr_play_ui("cancel");
    }
}
// 5. Kolom Kanan: Navigasi Panel Detail
else if (focus_column == 1) {
    // Tombol Kiri atau Cancel [X] -> Kembali ke Kolom Perintah
    if (_key_left || _key_cancel) {
        focus_column = 0;
        scr_play_ui("cancel");
    }
    
    var _active_id = commands[selected_cmd].id;
    
    // Sub-Navigasi 5.1: STATUS (Alokasi Atribut Poin)
    if (_active_id == "status") {
        if (_key_up)   { detail_sub_index = (detail_sub_index - 1 + 4) % 4; scr_play_ui("move"); }
        if (_key_down) { detail_sub_index = (detail_sub_index + 1) % 4;     scr_play_ui("move"); }
        
        // Alokasi poin dengan [Z] pada baris atribut yang dipilih
        if (_key_confirm) {
            var _stats = ["vit", "str", "int", "agi"];
            var _stat_names = ["Vitalitas", "Kekuatan", "Kecerdasan", "Kelincahan"];
            var _chosen = _stats[detail_sub_index];
            
            if (global.stat_points > 0) {
                scr_allocate_stat(_chosen);
                scr_play_ui("confirm");
                show_toast("+1 " + _stat_names[detail_sub_index] + "! Poin sisa: " + string(global.stat_points));
            } else {
                scr_play_ui("cancel");
                show_toast("Poin atribut habis!");
            }
        }
        
        // Shortcut angka 1, 2, 3, 4 untuk alokasi instan
        if (keyboard_check_pressed(ord("1"))) { scr_allocate_stat("vit"); scr_play_ui("confirm"); show_toast("+1 Vitalitas!"); }
        if (keyboard_check_pressed(ord("2"))) { scr_allocate_stat("str"); scr_play_ui("confirm"); show_toast("+1 Kekuatan!"); }
        if (keyboard_check_pressed(ord("3"))) { scr_allocate_stat("int"); scr_play_ui("confirm"); show_toast("+1 Kecerdasan!"); }
        if (keyboard_check_pressed(ord("4"))) { scr_allocate_stat("agi"); scr_play_ui("confirm"); show_toast("+1 Kelincahan!"); }
    }
    
    // Sub-Navigasi 5.2: SIHIR (Ganti Mantra Aktif)
    else if (_active_id == "magic") {
        if (_key_up || _key_down) {
            detail_sub_index = (detail_sub_index == 0) ? 1 : 0;
            scr_play_ui("move");
        }
        if (_key_confirm) {
            if (detail_sub_index == 0 && global.spell_unlocked_fireball) {
                global.spell_selected = 1;
                scr_play_ui("confirm");
                show_toast("Mantra aktif: Fireball (20 MP)");
            } else if (detail_sub_index == 1 && global.spell_unlocked_frost) {
                global.spell_selected = 2;
                scr_play_ui("confirm");
                show_toast("Mantra aktif: Frost Nova (35 MP)");
            } else {
                scr_play_ui("cancel");
                show_toast("Mantra ini belum dipelajari!");
            }
        }
    }
    
    // Sub-Navigasi 5.3: SIMPAN & MUAT (Save / Load Multi-Slot)
    else if (_active_id == "save") {
        var _num_slots = array_length(save_slots);
        if (_key_up)   { detail_sub_index = (detail_sub_index - 1 + _num_slots) % _num_slots; scr_play_ui("move"); }
        if (_key_down) { detail_sub_index = (detail_sub_index + 1) % _num_slots;             scr_play_ui("move"); }
        
        var _cur_slot = save_slots[detail_sub_index].id;
        
        // [Z] -> Simpan Game pada slot yang dipilih
        if (_key_confirm) {
            scr_save_game(_cur_slot);
            refresh_save_slots();
            scr_play_ui("confirm");
            show_toast("Game Berhasil Disimpan ke " + string(save_slots[detail_sub_index].title) + "!");
        }
        
        // [L] -> Muat Game dari slot yang dipilih
        if (keyboard_check_pressed(ord("L"))) {
            if (scr_has_save_data(_cur_slot)) {
                global.main_menu_open = false;
                scr_load_game(_cur_slot);
            } else {
                show_toast("Slot ini masih kosong!");
            }
        }
        
        // [Delete] -> Hapus slot
        if (keyboard_check_pressed(vk_delete)) {
            if (scr_has_save_data(_cur_slot)) {
                scr_delete_save_game(_cur_slot);
                refresh_save_slots();
                show_toast("Slot " + string(save_slots[detail_sub_index].title) + " dibersihkan.");
            }
        }
    }
    
    // Sub-Navigasi 5.4: PENGATURAN GAME
    else if (_active_id == "settings") {
        var _num_rows = 3;
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            detail_sub_index = (detail_sub_index - 1 + _num_rows) % _num_rows;
            scr_audio_play("ui", "move");
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            detail_sub_index = (detail_sub_index + 1) % _num_rows;
            scr_audio_play("ui", "move");
        }
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
            if (detail_sub_index == 0) {
                global.bgm_volume = clamp(global.bgm_volume - 0.1, 0.0, 1.0);
                scr_audio_play("ui", "move");
            } else if (detail_sub_index == 1) {
                global.sfx_volume = clamp(global.sfx_volume - 0.1, 0.0, 1.0);
                scr_audio_play("ui", "confirm");
            }
        }
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            if (detail_sub_index == 0) {
                global.bgm_volume = clamp(global.bgm_volume + 0.1, 0.0, 1.0);
                scr_audio_play("ui", "move");
            } else if (detail_sub_index == 1) {
                global.sfx_volume = clamp(global.sfx_volume + 0.1, 0.0, 1.0);
                scr_audio_play("ui", "confirm");
            }
        }
        if (detail_sub_index == 2 && (_key_confirm || keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right))) {
            global.is_fullscreen = !global.is_fullscreen;
            window_set_fullscreen(global.is_fullscreen);
            scr_audio_play("ui", "confirm");
        }
    }
    
    // Sub-Navigasi 5.5: PETA (Buka Peta Penuh dengan [Z])
    else if (_active_id == "map") {
        if (_key_confirm) {
            global.main_menu_open = false;
            global.map_menu_open = true;
        }
    }
}

