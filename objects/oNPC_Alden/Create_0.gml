/// @description Inisialisasi Kapten Alden di Altdorf Square (Forgotten Sanctum Lore)

event_inherited();
interact_range = 45;
prompt_text = "[Z] Bicara dgn Kapten";
prompt_y_offset = -40;

sprite_index = sNPC_Alden;
image_speed = 0.08;
image_xscale = 1.35;
image_yscale = 1.35;
anim_timer = 0;

interact_action = function() {
    var _d = dialogue_create();
    
    if (global.quest_stage < 2) {
        _d.add("Kapten Alden", "Salam, petualang muda! Kudengar adikmu menderita kebocoran mana fatal akibat Overclock sihir?", "alden", "protagonist", "left", "question");
        _d.add("Protagonist", "Benar, Kapten. Aliran sihirnya rusak parah. Aku harus menembus Katakombe menuju Forgotten Sanctum untuk mengambil The Lost Remedy.", "alden", "protagonist", "right", "dots");
        _d.add("Kapten Alden", "Forgotten Sanctum... Tempat suci purba itu dijaga oleh legiun Corrupted Sentinels dan Legendary Guardian. Banyak petualang tak pernah kembali.", "alden", "protagonist", "left", "exclamation");
        _d.add("Kapten Alden", "Persiapkan senjatamu di Bengkel Goran (Kiri) dan ramuan di Apotek Elysia (Kanan) sebelum melangkah ke Hutan Selatan!", "alden", "protagonist", "left", "exclamation");
        _d.start(function() {
            if (global.quest_stage == 0) {
                scr_set_quest(1, "Persiapan Perjalanan", "Temui Goran (Toko Senjata) & Elysia (Apotek)");
            }
        });
    } else if (global.quest_stage == 2) {
        _d.add("Kapten Alden", "Pedang tempa dan ramuanmu sudah siap. Gerbang selatan menuju Hutan Reruntuhan kini terbuka. Tembuslah Katakombe dan bawa pulang The Lost Remedy!", "alden", "protagonist", "left");
        _d.start();
    } else {
        _d.add("Kapten Alden", "Waktu adikmu terus berjalan. Semoga dewa pelindung menyertai tekadmu menyelamatkan Sestrina!", "alden", "protagonist", "left");
        _d.start();
    }
};
