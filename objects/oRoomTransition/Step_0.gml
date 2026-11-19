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
        scr_play_sfx(snd_door_close, 0.05, 0.8, 10);
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

map_anim_timer += 0.05;
leave_confirm_timer += 0.08;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _gui_mx = device_mouse_x_to_gui(0);
var _gui_my = device_mouse_y_to_gui(0);

// =========================================================================
// A. KONTROL KONFIRMASI BATAS AREA (Reference: leaving area option.png)
// =========================================================================
if (variable_global_exists("leave_confirm_active") && global.leave_confirm_active) {
    // Navigasi Pilihan (Up/Down atau W/S)
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        global.leave_confirm_selection = 0; // Leave
        scr_play_ui("move");
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        global.leave_confirm_selection = 1; // Don't leave
        scr_play_ui("move");
    }
    
    // Deteksi Hover Mouse pada Dua Tombol Opsi di Tengah Layar
    var _btn_cx = _gui_w / 2;
    var _btn_w = 460;
    var _b1_y1 = _gui_h / 2 - 45;
    var _b1_y2 = _gui_h / 2 + 5;
    var _b2_y1 = _gui_h / 2 + 15;
    var _b2_y2 = _gui_h / 2 + 65;
    
    if (_gui_mx >= _btn_cx - _btn_w / 2 && _gui_mx <= _btn_cx + _btn_w / 2) {
        if (_gui_my >= _b1_y1 && _gui_my <= _b1_y2) global.leave_confirm_selection = 0;
        if (_gui_my >= _b2_y1 && _gui_my <= _b2_y2) global.leave_confirm_selection = 1;
    }
    
    // Eksekusi Konfirmasi (Z, Enter, Space, atau Klik Kiri)
    var _confirm_pressed = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left);
    var _cancel_pressed = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape);
    
    if (_cancel_pressed) {
        global.leave_confirm_active = false;
        scr_play_ui("cancel");
        exit;
    }
    
    if (_confirm_pressed) {
        scr_play_ui("confirm");
        if (global.leave_confirm_selection == 0) {
            // Pemain Memilih: "Leave"
            global.leave_confirm_active = false;
            start_transition(global.leave_confirm_target_room, global.leave_confirm_target_x, global.leave_confirm_target_y, global.leave_confirm_area_name, global.leave_confirm_subtitle);
        } else {
            // Pemain Memilih: "Don't leave"
            global.leave_confirm_active = false;
        }
        exit;
    }
    
    // Blokir aksi pemain lain selama konfirmasi aktif
    exit;
}

// =========================================================================
// B. BUKA / TUTUP PETA DISTRIK ISOMETRIK [M] (Reference: map.png & choosing are.png)
// =========================================================================
if (!global.dialogue_active && global.shop_menu_open == "" && !global.stat_menu_open && (!variable_global_exists("main_menu_open") || !global.main_menu_open)) {
    // Tombol Town-Guide di pojok kanan bawah GUI
    var _tg_x = _gui_w - 140;
    var _tg_y = _gui_h - 75;
    var _tg_w = 120;
    var _tg_h = 45;
    var _tg_clicked = mouse_check_button_pressed(mb_left) && (_gui_mx >= _tg_x && _gui_mx <= _tg_x + _tg_w && _gui_my >= _tg_y && _gui_my <= _tg_y + _tg_h);
    
    if (keyboard_check_pressed(ord("M")) || _tg_clicked) {
        global.map_menu_open = !global.map_menu_open;
        scr_play_ui(global.map_menu_open ? "confirm" : "cancel");
    }
}

// Kontrol Saat Menu Peta Terbuka
if (variable_global_exists("map_menu_open") && global.map_menu_open) {
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape)) {
        global.map_menu_open = false;
        scr_play_ui("cancel");
        exit;
    }
    
    var _node_count = array_length(map_nodes);
    
    // Navigasi Node dengan Keyboard
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        map_selected_node = (map_selected_node - 1 + _node_count) mod _node_count;
        scr_play_ui("move");
    }
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        map_selected_node = (map_selected_node + 1) mod _node_count;
        scr_play_ui("move");
    }
    
    // Pilih langsung dengan angka 1-6
    for (var _k = 0; _k < min(6, _node_count); _k++) {
        if (keyboard_check_pressed(ord(string(_k + 1)))) {
            map_selected_node = _k;
        }
    }
    
    // Deteksi Klik Mouse pada Node Peta
    for (var _ni = 0; _ni < _node_count; _ni++) {
        var _nd = map_nodes[_ni];
        if (point_distance(_gui_mx, _gui_my, _nd.map_x, _nd.map_y) < 45) {
            if (mouse_check_button_pressed(mb_left)) {
                map_selected_node = _ni;
            }
        }
    }
    
    // Tombol Keputusan di Sisi Kanan (Reference: choosing are.png - Enter / Don't enter)
    var _enter_box_x = _gui_w - 230;
    var _enter_box_y = _gui_h / 2 - 30;
    var _enter_box_w = 170;
    var _enter_box_h = 42;
    
    var _dont_box_y = _enter_box_y + 52;
    
    var _click_enter = mouse_check_button_pressed(mb_left) && (_gui_mx >= _enter_box_x && _gui_mx <= _enter_box_x + _enter_box_w && _gui_my >= _enter_box_y && _gui_my <= _enter_box_y + _enter_box_h);
    var _click_dont = mouse_check_button_pressed(mb_left) && (_gui_mx >= _enter_box_x && _gui_mx <= _enter_box_x + _enter_box_w && _gui_my >= _dont_box_y && _gui_my <= _dont_box_y + _enter_box_h);
    var _key_confirm = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
    
    if (_click_dont) {
        global.map_menu_open = false;
        scr_play_ui("cancel");
        exit;
    }
    
    if (_click_enter || _key_confirm) {
        var _cur_node = map_nodes[map_selected_node];
        if (global.quest_stage < _cur_node.req_stage) {
            banner_title = "AREA TERKUNCI!";
            banner_subtitle = "Selesaikan misi persiapan cerita sebelum menuju " + _cur_node.name;
            banner_timer = 150;
            scr_play_ui("cancel");
        } else {
            global.map_menu_open = false;
            scr_play_ui("confirm");
            start_transition(_cur_node.room_id, _cur_node.target_x, _cur_node.target_y, _cur_node.name, _cur_node.subname);
        }
        exit;
    }
    
    exit;
}

// 1. Pemain Minum Potion saat menekan tombol C (Dihandle oleh oPlayer dengan Animasi Minum)
if (keyboard_check_pressed(ord("C")) && !global.dialogue_active && !global.stat_menu_open && global.shop_menu_open == "" && global.player_potions > 0 && global.player_hp < global.player_max_hp) {
    if (!instance_exists(oPlayer)) {
        global.player_potions--;
        scr_heal_player(45);
    }
}

// 1.5. Quick Save [F5], Quick Load [F6], & Jendela Slots [F7] (Sistem Save State Multi-Slot)
var _sv_btn_x = 246;
var _sv_btn_y = 12;
var _gui_mx_pre = device_mouse_x_to_gui(0);
var _gui_my_pre = device_mouse_y_to_gui(0);

var _click_save = mouse_check_button_pressed(mb_left) && (_gui_mx_pre >= _sv_btn_x && _gui_mx_pre < _sv_btn_x + 92 && _gui_my_pre >= _sv_btn_y && _gui_my_pre <= _sv_btn_y + 34);
var _click_load = mouse_check_button_pressed(mb_left) && (_gui_mx_pre >= _sv_btn_x + 96 && _gui_mx_pre < _sv_btn_x + 192 && _gui_my_pre >= _sv_btn_y && _gui_my_pre <= _sv_btn_y + 34);
var _click_slots = mouse_check_button_pressed(mb_left) && (_gui_mx_pre >= _sv_btn_x + 196 && _gui_mx_pre <= _sv_btn_x + 300 && _gui_my_pre >= _sv_btn_y && _gui_my_pre <= _sv_btn_y + 34);

if ((keyboard_check_pressed(vk_f5) || _click_save) && !global.dialogue_active && !global.save_menu_open) {
    scr_save_game("quicksave");
}
if ((keyboard_check_pressed(vk_f6) || keyboard_check_pressed(vk_f9) || _click_load) && !global.dialogue_active && !global.save_menu_open) {
    scr_load_game("quicksave");
}
if ((keyboard_check_pressed(vk_f7) || keyboard_check_pressed(vk_f8) || _click_slots) && !global.dialogue_active) {
    global.save_menu_open = !global.save_menu_open;
    if (global.save_menu_open) {
        refresh_save_slots();
    }
}

// 1.6. Kontrol saat Jendela Save State Multi-Slot Terbuka
if (variable_global_exists("save_menu_open") && global.save_menu_open) {
    var _smw = 920;
    var _smh = 570;
    var _smx = (display_get_gui_width() - _smw) / 2;
    var _smy = (display_get_gui_height() - _smh) / 2;
    
    // Tombol X, ESC atau Klik [X] di pojok kanan atas modal
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape)) {
        global.save_menu_open = false;
        exit;
    }
    
    if (mouse_check_button_pressed(mb_left)) {
        if (_gui_mx_pre >= _smx + _smw - 46 && _gui_mx_pre <= _smx + _smw - 10 && _gui_my_pre >= _smy + 10 && _gui_my_pre <= _smy + 46) {
            global.save_menu_open = false;
            exit;
        }
    }
    
    // Interaksi Klik Tombol pada masing-masing Slot Card
    var _scard_y = _smy + 75;
    var _scard_h = 100;
    var _scard_gap = 14;
    var _scx = _smx + 20;
    var _scw = _smw - 40;
    
    for (var _si = 0; _si < array_length(save_slots); _si++) {
        var _scy = _scard_y + _si * (_scard_h + _scard_gap);
        var _slot_item = save_slots[_si];
        var _s_info = (_si < array_length(save_slots_cache)) ? save_slots_cache[_si] : scr_get_save_info(_slot_item.id);
        
        if (mouse_check_button_pressed(mb_left)) {
            if (_s_info.exists) {
                // Tombol SIMPAN / TIMPA
                var _bs_x = _scx + _scw - 290;
                var _bs_y = _scy + 30;
                if (_gui_mx_pre >= _bs_x && _gui_mx_pre <= _bs_x + 90 && _gui_my_pre >= _bs_y && _gui_my_pre <= _bs_y + 40) {
                    scr_save_game(_slot_item.id);
                    refresh_save_slots();
                }
                
                // Tombol MUAT / LOAD
                var _bl_x = _scx + _scw - 190;
                var _bl_y = _scy + 30;
                if (_gui_mx_pre >= _bl_x && _gui_mx_pre <= _bl_x + 90 && _gui_my_pre >= _bl_y && _gui_my_pre <= _bl_y + 40) {
                    global.save_menu_open = false;
                    scr_load_game(_slot_item.id);
                    exit;
                }
                
                // Tombol HAPUS
                var _bd_x = _scx + _scw - 90;
                var _bd_y = _scy + 30;
                if (_gui_mx_pre >= _bd_x && _gui_mx_pre <= _bd_x + 75 && _gui_my_pre >= _bd_y && _gui_my_pre <= _bd_y + 40) {
                    scr_delete_save_game(_slot_item.id);
                    refresh_save_slots();
                }
            } else {
                // Tombol SIMPAN BARU (Slot Kosong)
                var _bn_x = _scx + _scw - 210;
                var _bn_y = _scy + 30;
                if (_gui_mx_pre >= _bn_x && _gui_mx_pre <= _bn_x + 195 && _gui_my_pre >= _bn_y && _gui_my_pre <= _bn_y + 40) {
                    scr_save_game(_slot_item.id);
                    refresh_save_slots();
                }
            }
        }
    }
    
    // Blokir aksi gameplay lain saat jendela modal save aktif
    exit;
}

// 2 & 3. Buka / Tutup Menu Status & Alokasi Stat [P] atau [TAB]
var _gui_mx = device_mouse_x_to_gui(0);
var _gui_my = device_mouse_y_to_gui(0);

if (global.stat_menu_open) {
    var _mw = 860;
    var _mh = 530;
    var _mx = (display_get_gui_width() - _mw) / 2;
    var _my = (display_get_gui_height() - _mh) / 2;
    
    // Tutup Menu dengan X, ESC, P, TAB, atau tombol Close [X]
    var _close_btn_clicked = false;
    if (mouse_check_button_pressed(mb_left)) {
        if (_gui_mx >= _mx + 806 && _gui_mx <= _mx + 842 && _gui_my >= _my + 14 && _gui_my <= _my + 50) {
            _close_btn_clicked = true;
        }
    }
    
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P")) || keyboard_check_pressed(vk_tab) || _close_btn_clicked) {
        global.stat_menu_open = false;
        exit;
    }
    
    // Klik Mouse pada Elemen Menu Status
    if (mouse_check_button_pressed(mb_left)) {
        // Klik slot sihir (Box ke-4 di Kolom Perlengkapan)
        if (_gui_mx >= _mx + 768 && _gui_mx <= _mx + 818 && _gui_my >= _my + 95 && _gui_my <= _my + 145) {
            if (global.spell_unlocked_fireball && global.spell_unlocked_frost) {
                global.spell_selected = (global.spell_selected == 1) ? 2 : 1;
            } else if (global.spell_unlocked_fireball) {
                global.spell_selected = 1;
            } else if (global.spell_unlocked_frost) {
                global.spell_selected = 2;
            }
        }
        
        // Klik tombol [+] Alokasi Stat (Kolom 2 x: 512..538, pas di tombol [+] native)
        if (global.stat_points > 0) {
            var _btn_plus_x = _mx + 512;
            var _btn_ys = [125, 171, 217, 263];
            for (var _i = 0; _i < 4; _i++) {
                var _by = _my + _btn_ys[_i];
                if (_gui_mx >= _btn_plus_x && _gui_mx <= _btn_plus_x + 28 && _gui_my >= _by - 14 && _gui_my <= _by + 14) {
                    if (_i == 0) scr_allocate_stat("vit");
                    if (_i == 1) scr_allocate_stat("str");
                    if (_i == 2) scr_allocate_stat("int");
                    if (_i == 3) scr_allocate_stat("agi");
                }
            }
        }
    }
    
    // Alokasi Stat Poin via Tombol Angka [1] - [4]
    if (global.stat_points > 0) {
        if (keyboard_check_pressed(ord("1"))) scr_allocate_stat("vit");
        if (keyboard_check_pressed(ord("2"))) scr_allocate_stat("str");
        if (keyboard_check_pressed(ord("3"))) scr_allocate_stat("int");
        if (keyboard_check_pressed(ord("4"))) scr_allocate_stat("agi");
    }
    
    // Blokir interaksi lain saat menu status terbuka
    exit;
} else {
    // Menu Status sedang Tertutup -> Cek pembukaan
    if (!global.dialogue_active && global.shop_menu_open == "") {
        var _hud_badge_clicked = false;
        if (mouse_check_button_pressed(mb_left)) {
            // Klik pada pill [P] Status di pojok kanan atas HUD plate
            if (_gui_mx >= 24 + 448 - 145 && _gui_mx <= 24 + 448 - 10 && _gui_my >= 60 && _gui_my <= 80) {
                _hud_badge_clicked = true;
            }
        }
        
        if ((keyboard_check_pressed(ord("P")) || _hud_badge_clicked) && (!variable_global_exists("main_menu_open") || !global.main_menu_open)) {
            global.stat_menu_open = true;
            exit;
        }
    }
}

// 4. Kontrol Input saat Toko Tempa Goran Terbuka
if (global.shop_menu_open == "goran") {
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape)) {
        global.shop_menu_open = "";
        scr_play_ui("cancel");
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
            scr_play_sfx(snd_sword_parry, 0.05, 1.1, 14);
            scr_play_sfx(snd_mining_1, 0.08, 1.0, 12);
        }
    }
}

// 5. Kontrol Input saat Toko Alkimia Elysia Terbuka
if (global.shop_menu_open == "elysia") {
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape)) {
        global.shop_menu_open = "";
        scr_play_ui("cancel");
    }
    
    // Tekan 1: Beli Ramuan (25 Gold)
    if (keyboard_check_pressed(ord("1"))) {
        if (global.gold >= 25 && global.player_potions < 5) {
            global.gold -= 25;
            global.player_potions++;
            banner_title = "MEMBELI RAMUAN DARAH";
            banner_subtitle = "Ramuan bertambah! Tekan [C] saat bertarung.";
            banner_timer = 120;
            scr_play_sfx(snd_drink_potion, 0.05, 0.9, 11);
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
            scr_play_sfx(snd_frost_nova, 0.06, 1.0, 13);
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
            scr_play_sfx(snd_drink_potion, 0.05, 1.0, 12);
        }
    }
}

// 6. Kontrol Input saat Kios Bahan Mentah & Mineral Marcus Terbuka
if (global.shop_menu_open == "material_trader") {
    var _close = false;
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_escape)) {
        _close = true;
    }
    
    var _buy_item = -1;
    var _sell_item = -1;
    
    // Keyboard Shortcuts:
    // [1] - [5]: Beli Item
    if (keyboard_check_pressed(ord("1"))) _buy_item = 0;
    if (keyboard_check_pressed(ord("2"))) _buy_item = 1;
    if (keyboard_check_pressed(ord("3"))) _buy_item = 2;
    if (keyboard_check_pressed(ord("4"))) _buy_item = 3;
    if (keyboard_check_pressed(ord("5"))) _buy_item = 4;
    
    // [6] - [0]: Jual Item
    if (keyboard_check_pressed(ord("6"))) _sell_item = 0;
    if (keyboard_check_pressed(ord("7"))) _sell_item = 1;
    if (keyboard_check_pressed(ord("8"))) _sell_item = 2;
    if (keyboard_check_pressed(ord("9"))) _sell_item = 3;
    if (keyboard_check_pressed(ord("0"))) _sell_item = 4;
    
    // Mouse Interaction
    var _gui_mx = device_mouse_x_to_gui(0);
    var _gui_my = device_mouse_y_to_gui(0);
    var _clicked = mouse_check_button_pressed(mb_left);
    
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();
    var _mw = 820;
    var _mh = 500;
    var _mx = (_gw - _mw) / 2;
    var _my = (_gh - _mh) / 2;
    
    // Tombol Close [X] (pojok kanan atas)
    if (_clicked && _gui_mx >= _mx + _mw - 44 && _gui_mx <= _mx + _mw - 12 && _gui_my >= _my + 12 && _gui_my <= _my + 44) {
        _close = true;
    }
    
    // Hitbox Tombol Beli & Jual tiap baris
    var _list_y = _my + 105;
    var _row_h = 64;
    for (var _i = 0; _i < 5; _i++) {
        var _ry = _list_y + _i * _row_h;
        var _buy_btn_x = _mx + 530;
        var _buy_btn_w = 125;
        if (_clicked && _gui_mx >= _buy_btn_x && _gui_mx <= _buy_btn_x + _buy_btn_w && _gui_my >= _ry + 10 && _gui_my <= _ry + 46) {
            _buy_item = _i;
        }
        
        var _sell_btn_x = _mx + 670;
        var _sell_btn_w = 125;
        if (_clicked && _gui_mx >= _sell_btn_x && _gui_mx <= _sell_btn_x + _sell_btn_w && _gui_my >= _ry + 10 && _gui_my <= _ry + 46) {
            _sell_item = _i;
        }
    }
    
    if (_close) {
        global.shop_menu_open = "";
        scr_play_ui("cancel");
    }
    
    // Eksekusi Pembelian
    if (_buy_item != -1) {
        scr_play_ui("confirm");
        switch (_buy_item) {
            case 0: // Scrap Iron: 15 Gold
                if (global.gold >= 15) {
                    global.gold -= 15;
                    global.mat_scrap_iron++;
                    banner_title = "DIBELI: BESI BEKAS (+1)";
                    banner_subtitle = "Sisa Gold: " + string(global.gold) + " G | Total Scrap Iron: " + string(global.mat_scrap_iron);
                    banner_timer = 110;
                } else {
                    banner_title = "GOLD TIDAK CUKUP!";
                    banner_subtitle = "Besi Bekas seharga 15 Gold. Kalahkan monster untuk mencari koin!";
                    banner_timer = 110;
                }
                break;
                
            case 1: // Iron Ore: 25 Gold
                if (global.gold >= 25) {
                    global.gold -= 25;
                    global.mat_iron_ore++;
                    banner_title = "DIBELI: BIJIH BESI (+1)";
                    banner_subtitle = "Sisa Gold: " + string(global.gold) + " G | Total Iron Ore: " + string(global.mat_iron_ore);
                    banner_timer = 110;
                } else {
                    banner_title = "GOLD TIDAK CUKUP!";
                    banner_subtitle = "Bijih Besi seharga 25 Gold. Selesaikan quest atau kalahkan musuh!";
                    banner_timer = 110;
                }
                break;
                
            case 2: // Bone Shard: 30 Gold
                if (global.gold >= 30) {
                    global.gold -= 30;
                    global.mat_bone_shard++;
                    banner_title = "DIBELI: TULANG MONSTER (+1)";
                    banner_subtitle = "Sisa Gold: " + string(global.gold) + " G | Total Bone Shards: " + string(global.mat_bone_shard);
                    banner_timer = 110;
                } else {
                    banner_title = "GOLD TIDAK CUKUP!";
                    banner_subtitle = "Tulang Monster seharga 30 Gold!";
                    banner_timer = 110;
                }
                break;
                
            case 3: // Magic Crystal: 65 Gold
                if (global.gold >= 65) {
                    global.gold -= 65;
                    global.mat_magic_crystal++;
                    banner_title = "DIBELI: KRISTAL SIHIR (+1)";
                    banner_subtitle = "Sisa Gold: " + string(global.gold) + " G | Total Magic Crystal: " + string(global.mat_magic_crystal);
                    banner_timer = 110;
                } else {
                    banner_title = "GOLD TIDAK CUKUP!";
                    banner_subtitle = "Kristal Sihir seharga 65 Gold!";
                    banner_timer = 110;
                }
                break;
                
            case 4: // Slime Jelly: 10 Gold
                if (global.gold >= 10) {
                    global.gold -= 10;
                    global.mat_slime_jelly++;
                    banner_title = "DIBELI: JELI SLIME (+1)";
                    banner_subtitle = "Sisa Gold: " + string(global.gold) + " G | Total Slime Jelly: " + string(global.mat_slime_jelly);
                    banner_timer = 110;
                } else {
                    banner_title = "GOLD TIDAK CUKUP!";
                    banner_subtitle = "Jeli Slime seharga 10 Gold!";
                    banner_timer = 110;
                }
                break;
        }
    }
    
    // Eksekusi Penjualan
    if (_sell_item != -1) {
        scr_play_ui("confirm");
        switch (_sell_item) {
            case 0: // Scrap Iron: Jual 8 G
                if (global.mat_scrap_iron > 0) {
                    global.mat_scrap_iron--;
                    global.gold += 8;
                    banner_title = "DIJUAL: BESI BEKAS (+8 G)";
                    banner_subtitle = "Total Gold: " + string(global.gold) + " G | Sisa Scrap Iron: " + string(global.mat_scrap_iron);
                    banner_timer = 110;
                } else {
                    banner_title = "STOK HABIS!";
                    banner_subtitle = "Anda tidak memiliki Besi Bekas untuk dijual!";
                    banner_timer = 110;
                }
                break;
                
            case 1: // Iron Ore: Jual 12 G
                if (global.mat_iron_ore > 0) {
                    global.mat_iron_ore--;
                    global.gold += 12;
                    banner_title = "DIJUAL: BIJIH BESI (+12 G)";
                    banner_subtitle = "Total Gold: " + string(global.gold) + " G | Sisa Iron Ore: " + string(global.mat_iron_ore);
                    banner_timer = 110;
                } else {
                    banner_title = "STOK HABIS!";
                    banner_subtitle = "Anda tidak memiliki Bijih Besi untuk dijual!";
                    banner_timer = 110;
                }
                break;
                
            case 2: // Bone Shard: Jual 15 G
                if (global.mat_bone_shard > 0) {
                    global.mat_bone_shard--;
                    global.gold += 15;
                    banner_title = "DIJUAL: TULANG MONSTER (+15 G)";
                    banner_subtitle = "Total Gold: " + string(global.gold) + " G | Sisa Bone Shards: " + string(global.mat_bone_shard);
                    banner_timer = 110;
                } else {
                    banner_title = "STOK HABIS!";
                    banner_subtitle = "Anda tidak memiliki Tulang Monster untuk dijual!";
                    banner_timer = 110;
                }
                break;
                
            case 3: // Magic Crystal: Jual 35 G
                if (global.mat_magic_crystal > 0) {
                    global.mat_magic_crystal--;
                    global.gold += 35;
                    banner_title = "DIJUAL: KRISTAL SIHIR (+35 G)";
                    banner_subtitle = "Total Gold: " + string(global.gold) + " G | Sisa Magic Crystal: " + string(global.mat_magic_crystal);
                    banner_timer = 110;
                } else {
                    banner_title = "STOK HABIS!";
                    banner_subtitle = "Anda tidak memiliki Kristal Sihir untuk dijual!";
                    banner_timer = 110;
                }
                break;
                
            case 4: // Slime Jelly: Jual 5 G
                if (global.mat_slime_jelly > 0) {
                    global.mat_slime_jelly--;
                    global.gold += 5;
                    banner_title = "DIJUAL: JELI SLIME (+5 G)";
                    banner_subtitle = "Total Gold: " + string(global.gold) + " G | Sisa Slime Jelly: " + string(global.mat_slime_jelly);
                    banner_timer = 110;
                } else {
                    banner_title = "STOK HABIS!";
                    banner_subtitle = "Anda tidak memiliki Jeli Slime untuk dijual!";
                    banner_timer = 110;
                }
                break;
        }
    }
}
