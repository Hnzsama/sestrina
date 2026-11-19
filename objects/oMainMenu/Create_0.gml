/// @description Inisialisasi Main Menu & Title Screen Controller

depth = -11000;

// State Menu
menu_state = "main"; // "main", "settings", "credits", "controls"
selected_option = 0;
setting_selected = 0;

// Animasi & Visual
anim_time = 0;
menu_alpha = 0.0;
fade_out = false;
fade_alpha = 0.0;
target_action = "";

// Partikel Bintang / Mana Motes di Latar Belakang
particles = [];
for (var _i = 0; _i < 40; _i++) {
    array_push(particles, {
        x: random(1280),
        y: random(720),
        spd: random_range(0.3, 1.2),
        size: random_range(1.5, 4.0),
        alpha: random_range(0.3, 0.85),
        col: choose(make_color_rgb(180, 220, 255), make_color_rgb(255, 230, 160), make_color_rgb(200, 170, 255))
    });
}

// Cek simpanan game
has_save = scr_has_save_data("quicksave");
save_info_str = "";
if (has_save) {
    var _info = scr_get_save_info("quicksave");
    if (is_struct(_info) && variable_struct_exists(_info, "exists") && _info.exists) {
        save_info_str = " (" + string(_info.time_str) + " - " + string(_info.room_title) + ")";
    } else {
        has_save = false;
    }
}

// Credits Scroll Timer
credits_scroll_y = 700;
credits_scroll_speed = 0.75;
