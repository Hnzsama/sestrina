/// @description Inisialisasi Kapten Alden di Altdorf Square

event_inherited();
interact_range = 45;
prompt_text = "[E] Bicara dgn Kapten";
prompt_y_offset = -40;

sprite_index = sNPC_Alden;
image_speed = 0.08;
image_xscale = 1.35;
image_yscale = 1.35;
anim_timer = 0;

interact_action = function() {
    var _d = dialogue_create();
    
    if (global.quest_stage < 2) {
        _d.add("Kapten Alden", "Salam, ksatria muda! Kudengar adikmu Sestrina jatuh sakit oleh kutukan kuno?", "alden", "protagonist", "left");
        _d.add("Protagonist", "Benar, Kapten. Aku butuh jalan menuju Katakombe Kuno untuk mencari Bunga Cahaya Abadi.", "alden", "protagonist", "right");
        _d.add("Kapten Alden", "Hutan di selatan dijaga oleh monster berkeliaran. Kunjungi dulu Goran di Toko Senjata (Kiri) dan Elysia di Toko Ramuan (Kanan) sebelum berangkat!", "alden", "protagonist", "left");
        _d.start(function() {
            if (global.quest_stage == 0) {
                scr_set_quest(1, "Persiapan Perjalanan", "Temui Goran (Toko Senjata) & Elysia (Apotek)");
            }
        });
    } else if (global.quest_stage == 2) {
        _d.add("Kapten Alden", "Kau sudah memiliki pedang dan ramuan. Gerbang selatan menuju Hutan Reruntuhan kini terbuka. Berhati-hatilah!", "alden", "protagonist", "left");
        _d.start();
    } else {
        _d.add("Kapten Alden", "Semoga dewa pelindung menyertai langkahmu menyelamatkan Sestrina!", "alden", "protagonist", "left");
        _d.start();
    }
};
