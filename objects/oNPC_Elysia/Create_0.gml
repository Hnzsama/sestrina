/// @description Inisialisasi Alkemis Elysia

event_inherited();
interact_range = 55;
prompt_text = "[E] Alkimia dgn Elysia";
prompt_y_offset = -40;

sprite_index = sNPC_Elysia;
image_speed = 0.08;
image_xscale = 1.35;
image_yscale = 1.35;
anim_timer = 0;
has_given_potions = false;

interact_action = function() {
    var _d = dialogue_create();
    
    if (!has_given_potions) {
        _d.add("Elysia", "Ah, kau yang datang membawa kabar tentang Sestrina? Aku sudah memeriksa gulungan kuno perpustakaan.", "elysia", "protagonist", "left");
        _d.add("Protagonist", "Apakah ada obat penawar untuk kutukan yang menimpanya, Elysia?", "elysia", "protagonist", "right");
        _d.add("Elysia", "Satu-satunya penawar adalah 'Bunga Cahaya Abadi' di dasar Katakombe, dijaga oleh Golem Penjaga Kuno.", "elysia", "protagonist", "left");
        _d.add("Elysia", "Bawalah Ramuan ini [C], dan kupinjamkan Grimoire Sihir: Tekan [X] untuk menembakkan Bola Api (Fireball) dengan Mana (MP)!", "elysia", "protagonist", "left");
        _d.start(function() {
            has_given_potions = true;
            global.player_potions = max(global.player_potions, 3);
            global.spell_unlocked_fireball = true;
            global.spell_selected = 1;
            
            if (global.weapon_tier > 0) {
                scr_set_quest(2, "Kumpulkan Bahan & Tempa Senjata", "Farming di Hutan, tempa senjata di Goran");
            } else {
                scr_set_quest(1, "Persiapan Perjalanan", "Temui Goran di Toko Senjata (Barat Kota)");
            }
        });
    } else {
        // Buka Menu Toko Alkimia & Grimoire Interaktif!
        global.shop_menu_open = "elysia";
    }
};
