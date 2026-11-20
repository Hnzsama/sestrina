/// @description Step Event - Navigasi Keyboard, Mouse & Transisi Menu

anim_time += 0.04;
menu_alpha = lerp(menu_alpha, 1.0, 0.08);

// Update Partikel Melayang
for (var _i = 0; _i < array_length(particles); _i++) {
    var _p = particles[_i];
    _p.y -= _p.spd;
    if (_p.y < -10) {
        _p.y = 730;
        _p.x = random(1280);
    }
}

// Fade Out Handler saat New Game / Load Game
if (fade_out) {
    fade_alpha += 0.04;
    if (fade_alpha >= 1.0) {
        if (target_action == "new_game") {
            scr_start_new_game();
        } else if (target_action == "load_slot" || target_action == "continue") {
            scr_load_game(selected_load_slot);
        }
    }
    exit;
}

// =========================================================================
// 1. STATE: MAIN MENU
// =========================================================================
if (menu_state == "main") {
    var _key_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    var _key_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    var _key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));

    if (_key_up) {
        selected_option = (selected_option - 1 + 5) mod 5;
        // Skip continue jika tidak ada save
        if (selected_option == 1 && !has_save) {
            selected_option = 0;
        }
        scr_audio_play("ui", "move");
    }
    if (_key_down) {
        selected_option = (selected_option + 1) mod 5;
        // Skip continue jika tidak ada save
        if (selected_option == 1 && !has_save) {
            selected_option = 2;
        }
        scr_audio_play("ui", "move");
    }

    if (_key_confirm) {
        scr_audio_play("ui", "confirm");
        switch (selected_option) {
            case 0: // Mulai Petualangan Baru
                fade_out = true;
                target_action = "new_game";
                break;
                
            case 1: // Lanjutkan (Buka Manajemen Slot Simpanan)
                if (has_save) {
                    refresh_save_slots();
                    menu_state = "load_game";
                    load_slot_selected = 0;
                    for (var _s = 0; _s < array_length(save_slots_cache); _s++) {
                        if (save_slots_cache[_s].exists) {
                            load_slot_selected = _s;
                            break;
                        }
                    }
                }
                break;
                
            case 2: // Pengaturan (Settings)
                menu_state = "settings";
                setting_selected = 0;
                break;
                
            case 3: // Kredit Pengembang (Credits)
                menu_state = "credits";
                credits_scroll_y = 700;
                break;
                
            case 4: // Keluar
                game_end();
                break;
        }
    }
}

// =========================================================================
// 1.5. STATE: LOAD GAME MULTI-SLOT
// =========================================================================
else if (menu_state == "load_game") {
    var _key_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    var _key_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    var _key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));
    var _key_back = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

    if (_key_up) {
        load_slot_selected = (load_slot_selected - 1 + array_length(save_slots)) mod array_length(save_slots);
        scr_audio_play("ui", "move");
    }
    if (_key_down) {
        load_slot_selected = (load_slot_selected + 1) mod array_length(save_slots);
        scr_audio_play("ui", "move");
    }

    if (_key_confirm) {
        if (load_slot_selected < array_length(save_slots_cache) && save_slots_cache[load_slot_selected].exists) {
            selected_load_slot = save_slots[load_slot_selected].id;
            fade_out = true;
            target_action = "load_slot";
            scr_audio_play("ui", "confirm");
        } else {
            scr_audio_play("ui", "cancel");
        }
    }

    if (_key_back) {
        menu_state = "main";
        scr_audio_play("ui", "cancel");
    }
    
    // Mouse Support di Jendela Load Game
    var _gmx = device_mouse_x_to_gui(0);
    var _gmy = device_mouse_y_to_gui(0);
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();
    var _mw = 920;
    var _mh = 570;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;
    
    // Tombol Close [X]
    if (mouse_check_button_pressed(mb_left)) {
        if (_gmx >= _mx + _mw - 44 && _gmx <= _mx + _mw - 12 && _gmy >= _my + 12 && _gmy <= _my + 44) {
            menu_state = "main";
            scr_audio_play("ui", "cancel");
        }
    }
    
    // Klik Kartu Slot
    var _card_y = _my + 68;
    var _card_h = 102;
    var _card_gap = 12;
    var _cx = _mx + 24;
    var _cw = _mw - 48;
    
    for (var _i = 0; _i < array_length(save_slots); _i++) {
        var _cy = _card_y + _i * (_card_h + _card_gap);
        var _card_hover = (_gmx >= _cx && _gmx <= _cx + _cw && _gmy >= _cy && _gmy <= _cy + _card_h);
        
        if (_card_hover) {
            if (mouse_check_button_pressed(mb_left)) {
                load_slot_selected = _i;
                if (_i < array_length(save_slots_cache) && save_slots_cache[_i].exists) {
                    selected_load_slot = save_slots[_i].id;
                    fade_out = true;
                    target_action = "load_slot";
                    scr_audio_play("ui", "confirm");
                } else {
                    scr_audio_play("ui", "cancel");
                }
            }
        }
    }
}

// =========================================================================
// 2. STATE: SETTINGS
// =========================================================================
else if (menu_state == "settings") {
    var _key_up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    var _key_down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
    var _key_left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
    var _key_right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
    var _key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));
    var _key_back = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

    if (_key_up) {
        setting_selected = (setting_selected - 1 + 5) mod 5;
        scr_audio_play("ui", "move");
    }
    if (_key_down) {
        setting_selected = (setting_selected + 1) mod 5;
        scr_audio_play("ui", "move");
    }

    // Volume BGM
    if (setting_selected == 0) {
        if (_key_left) {
            global.bgm_volume = clamp(global.bgm_volume - 0.1, 0.0, 1.0);
            scr_audio_play("ui", "move");
        }
        if (_key_right) {
            global.bgm_volume = clamp(global.bgm_volume + 0.1, 0.0, 1.0);
            scr_audio_play("ui", "move");
        }
    }
    // Volume SFX
    else if (setting_selected == 1) {
        if (_key_left) {
            global.sfx_volume = clamp(global.sfx_volume - 0.1, 0.0, 1.0);
            scr_audio_play("ui", "confirm");
        }
        if (_key_right) {
            global.sfx_volume = clamp(global.sfx_volume + 0.1, 0.0, 1.0);
            scr_audio_play("ui", "confirm");
        }
    }
    // Fullscreen Toggle
    else if (setting_selected == 2) {
        if (_key_confirm || _key_left || _key_right) {
            global.is_fullscreen = !global.is_fullscreen;
            window_set_fullscreen(global.is_fullscreen);
            scr_audio_play("ui", "confirm");
        }
    }
    // Controls Guide
    else if (setting_selected == 3) {
        if (_key_confirm) {
            menu_state = "controls";
            scr_audio_play("ui", "confirm");
        }
    }
    // Kembali
    else if (setting_selected == 4) {
        if (_key_confirm) {
            menu_state = "main";
            scr_audio_play("ui", "cancel");
        }
    }

    if (_key_back) {
        menu_state = "main";
        scr_audio_play("ui", "cancel");
    }
}

// =========================================================================
// 3. STATE: CONTROLS GUIDE
// =========================================================================
else if (menu_state == "controls") {
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        menu_state = "settings";
        scr_audio_play("ui", "cancel");
    }
}

// =========================================================================
// 4. STATE: CREDITS ROLL
// =========================================================================
else if (menu_state == "credits") {
    credits_scroll_y -= credits_scroll_speed;
    
    // Tombol Cepat Kembali
    if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        menu_state = "main";
        scr_audio_play("ui", "cancel");
    }
    
    // Loop kembali jika habis
    if (credits_scroll_y < -950) {
        credits_scroll_y = 700;
    }
}
