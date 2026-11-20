/// @description Inisialisasi Pandai Besi Goran (Workshop & Party Recruitment)

event_inherited();
interact_range = 65;
prompt_text = "[Z] Tempa dgn Goran";
prompt_y_offset = -48;

sprite_index = sGoran_Workshop_Idle;
image_speed = 0.08;
image_xscale = 1.0;
image_yscale = 1.0;
anim_timer = 0;

interact_action = function() {
    var _d = dialogue_create();
    
    // 1. Quest Pertama - Ambil Pedang Karat jika belum memiliki senjata
    if (global.weapon_tier == 0) {
        _d.add("Goran", "Hahah! Butuh senjata untuk menembus Dungeon Lantai 1? Aku punya pedang tua di sudut bengkel.", "goran", "protagonist", "left", "exclamation");
        _d.add("Protagonist", "Paman Goran, pedang ini berkarat dan tumpul...", "goran", "protagonist", "right", "sweat");
        _d.add("Goran", "Pedang Karat ini masih cukup tajam untuk menebas monster! Kumpulkan Besi Bekas, Bijih Besi, dan Tulang Monster di Katakombe, lalu bawa kemari agar kutempa menjadi pedang perang sejati!", "goran", "protagonist", "left", "exclamation");
        _d.start(function() {
            global.player_has_sword = true;
            global.weapon_tier = 1;
            global.weapon_name = "Pedang Karat";
            if (global.player_potions >= 2) {
                scr_set_quest(2, "Kumpulkan Bahan & Tempa Senjata", "Farming di Katakombe F1, tempa senjata di Goran");
            } else {
                scr_set_quest(1, "Persiapan Perjalanan", "Temui Elysia di Apotek Herbal (Timur Kota)");
            }
        });
        return;
    }
    
    // 2. Langsung Buka Menu Bengkel Tempa Senjata (Tidak Memaksa Rekrut Party)
    global.shop_menu_open = "goran";
};
