/// @description Inisialisasi Pandai Besi Goran

event_inherited();
interact_range = 55;
prompt_text = "[E] Tempa dgn Goran";
prompt_y_offset = -40;

sprite_index = sNPC_Goran;
image_speed = 0.08;
image_xscale = 1.35;
image_yscale = 1.35;
anim_timer = 0;

interact_action = function() {
    var _d = dialogue_create();
    
    if (global.weapon_tier == 0) {
        _d.add("Goran", "Hahah! Butuh senjata untuk menembus hutan reruntuhan? Aku punya pedang tua di sudut bengkel.", "goran", "protagonist", "left");
        _d.add("Protagonist", "Paman Goran, pedang ini berkarat dan tumpul...", "goran", "protagonist", "right");
        _d.add("Goran", "Pedang Karat ini masih cukup tajam untuk menebas slime! Kumpulkan Besi Bekas, Bijih Besi, dan Tulang Monster, lalu bawa kemari agar kutempa menjadi pedang perang sejati!", "goran", "protagonist", "left");
        _d.start(function() {
            global.player_has_sword = true;
            global.weapon_tier = 1;
            global.weapon_name = "Pedang Karat";
            if (global.player_potions >= 2) {
                scr_set_quest(2, "Kumpulkan Bahan & Tempa Senjata", "Farming di Hutan, tempa senjata di Goran");
            } else {
                scr_set_quest(1, "Persiapan Perjalanan", "Temui Elysia di Apotek Herbal (Timur Kota)");
            }
        });
    } else {
        // Buka Menu Tempa Senjata Interaktif!
        global.shop_menu_open = "goran";
    }
};
