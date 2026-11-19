/// @description Inisialisasi Room Transition & Global HUD Manager

transition_state = "idle"; // "idle", "fade_out", "fade_in"
fade_alpha = 0.0;
target_room = noone;
target_x = 0;
target_y = 0;
banner_title = "Kamar Tidur Kastil";
banner_subtitle = "Tempat peristirahatan Sestrina";
banner_timer = 140;

depth = -10000;

// Data Peta Distrik Kota & Wilayah Kerajaan (Reference: map.png & choosing are.png)
map_selected_node = 0;
map_nodes = [
    {
        name: "Secluded Cabin",
        subname: "Gubuk Pengasingan Sestrina",
        room_id: Room1,
        target_x: 640,
        target_y: 600,
        req_stage: 0,
        lore: "Tempat adikmu Sestrina terbaring akibat Overclock kebocoran mana fatal. Ranjang peristirahatan dan perapian kayu hangat ada di sini.",
        map_x: 620,
        map_y: 360
    },
    {
        name: "Downtown Plaza",
        subname: "Alun-Alun Kota Altdorf",
        room_id: rm_town_square,
        target_x: 1280,
        target_y: 720,
        req_stage: 0,
        lore: "Pusat kota Altdorf yang ramai dengan air mancur sentral, lentera jalanan, papan pengumuman guild, dan kedai malam.",
        map_x: 360,
        map_y: 330
    },
    {
        name: "Craftsmen & Apothecary",
        subname: "Bengkel Goran & Apotek Elysia",
        room_id: rm_town_square,
        target_x: 520,
        target_y: 480,
        req_stage: 1,
        lore: "Distrik pengrajin besi Goran dan laboratorium alkimia Elysia. Tempat menempa pedang pembelah batu dan meracik ramuan pemulih.",
        map_x: 230,
        map_y: 280
    },
    {
        name: "Sanctum Outskirts",
        subname: "Pelataran Kuil Purba",
        room_id: rm_outskirts,
        target_x: 640,
        target_y: 580,
        req_stage: 2,
        lore: "Hutan rimbun di luar perbatasan kota Altdorf. Reruntuhan gerbang kuil purba dijaga oleh kawanan Slime dan Skeleton liar.",
        map_x: 770,
        map_y: 210
    },
    {
        name: "Forgotten Catacombs",
        subname: "Katakombe Bawah Tanah",
        room_id: rm_catacombs,
        target_x: 640,
        target_y: 120,
        req_stage: 3,
        lore: "Lorong bawah tanah purba yang diselimuti kabut api biru jiwa dan sarkofagus terkutuk. Pintu gerbang menuju ruang boss tersegel.",
        map_x: 930,
        map_y: 260
    },
    {
        name: "The Sanctum Core",
        subname: "Altar The Lost Remedy",
        room_id: rm_boss_chamber,
        target_x: 640,
        target_y: 600,
        req_stage: 4,
        lore: "Ruang takhta purba Forgotten Sanctum tempat The Lost Remedy bersemayam di atas altar runic, dijaga oleh Ancient Stone Golem.",
        map_x: 1040,
        map_y: 420
    }
];

map_anim_timer = 0;
leave_confirm_timer = 0;

// Data Slot Simpanan Save State Manager (UAS Feature)
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
        array_push(save_slots_cache, scr_get_save_info(save_slots[_i].id));
    }
};

/// @function start_transition(room, x, y, title, subtitle)
start_transition = function(_room, _x, _y, _title, _subtitle = "") {
    if (transition_state != "idle") return;
    target_room = _room;
    target_x = _x;
    target_y = _y;
    banner_title = _title;
    banner_subtitle = _subtitle;
    transition_state = "fade_out";
    scr_play_sfx(snd_door_open, 0.05, 0.85, 10);
};
