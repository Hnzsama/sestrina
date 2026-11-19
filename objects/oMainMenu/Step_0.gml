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
        } else if (target_action == "continue") {
            scr_load_game("quicksave");
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
                
            case 1: // Lanjutkan (Continue)
                if (has_save) {
                    fade_out = true;
                    target_action = "continue";
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
