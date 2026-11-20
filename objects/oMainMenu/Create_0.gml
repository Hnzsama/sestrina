/// @description Inisialisasi Main Menu & Title Screen Controller

depth = -11000;

// State Menu
menu_state = "main"; // "main", "load_game", "settings", "credits", "controls"
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

// Data Slot Simpanan Multi-Slot untuk Menu Lanjutkan (Load Game)
save_slots = [
    { id: "quicksave", title: "QUICK SAVE", desc: "Simpanan Cepat Utama" },
    { id: "slot_1",    title: "SLOT 1",     desc: "Slot Simpanan 1" },
    { id: "slot_2",    title: "SLOT 2",     desc: "Slot Simpanan 2" },
    { id: "slot_3",    title: "SLOT 3",     desc: "Slot Simpanan 3" }
];
save_slots_cache = [];
load_slot_selected = 0;
selected_load_slot = "quicksave";

refresh_save_slots = function() {
    save_slots_cache = [];
    has_save = false;
    save_info_str = "";
    var _latest_time = "";
    
    for (var _i = 0; _i < array_length(save_slots); _i++) {
        var _s_info = scr_get_save_info(save_slots[_i].id);
        array_push(save_slots_cache, _s_info);
        if (_s_info.exists) {
            has_save = true;
            if (save_info_str == "") {
                save_info_str = " (" + string(_s_info.time_str) + " - " + string(_s_info.room_title) + ")";
            }
        }
    }
};

// Cek simpanan game awal
refresh_save_slots();

// Credits Scroll Timer
credits_scroll_y = 700;
credits_scroll_speed = 0.75;
