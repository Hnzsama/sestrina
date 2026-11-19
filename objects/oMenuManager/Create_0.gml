/// @description Inisialisasi JRPG Modular Menu Manager (Adapted from MK_UICustomizer)

depth = -10500;

if (!variable_global_exists("main_menu_open")) {
    global.main_menu_open = false;
}

// Menu Navigation
selected_cmd = 0;
target_cmd = 0;
cursor_y = 0;
menu_alpha = 0.0;
focus_column = 0; // 0 = Commands column (kiri), 1 = Detail panel (kanan)
detail_sub_index = 0;

// Notifikasi Status Menu (Toast)
menu_toast_text = "";
menu_toast_timer = 0;

// Daftar Perintah Menu (Modular & Dynamic)
commands = [
    { id: "status",   name: "Status Ksatria",   icon: 5, desc: "Atribut dasar, alokasi poin, dan statistik tempur" },
    { id: "items",    name: "Kantong & Bahan",  icon: 1, desc: "Ramuan pemulih dan material tempa hasil petualangan" },
    { id: "magic",    name: "Sihir & Elemen",   icon: 2, desc: "Mantra sihir api & es yang telah dipelajari" },
    { id: "quest",    name: "Jurnal Quest",     icon: 3, desc: "Misi utama mencari The Lost Remedy & kondisi adik" },
    { id: "map",      name: "Peta Distrik",     icon: 4, desc: "Panduan wilayah Altdorf dan kuil purba" },
    { id: "save",     name: "Simpan & Muat",    icon: 7, desc: "Kelola file simpanan petualangan multi-slot" },
    { id: "controls", name: "Panduan Kontrol",  icon: 6, desc: "Daftar tombol aksi, serangan, dan sihir" },
    { id: "close",    name: "Kembali Main",     icon: 8, desc: "Tutup menu dan lanjutkan petualangan" }
];

// Data Slot Simpanan
save_slots = [
    { id: "quicksave", title: "QUICK SAVE", desc: "Slot Simpanan Cepat Utama" },
    { id: "slot_1",    title: "SLOT 1",     desc: "Slot Simpanan Cadangan 1" },
    { id: "slot_2",    title: "SLOT 2",     desc: "Slot Simpanan Cadangan 2" },
    { id: "slot_3",    title: "SLOT 3",     desc: "Slot Simpanan Cadangan 3" }
];
save_slots_cache = [];

/// @function refresh_save_slots()
refresh_save_slots = function() {
    save_slots_cache = [];
    for (var _i = 0; _i < array_length(save_slots); _i++) {
        var _s = save_slots[_i];
        var _info = scr_get_save_info(_s.id);
        array_push(save_slots_cache, _info);
    }
};

/// @function show_toast(text)
show_toast = function(_txt) {
    menu_toast_text = _txt;
    menu_toast_timer = 120;
};

