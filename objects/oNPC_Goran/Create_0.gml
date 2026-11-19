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
    
    // 1. Rekrut Goran ke Party setelah menyelesaikan semua dungeon selain boss (global.has_boss_key)
    if (global.has_boss_key && !global.party_goran) {
        _d.add("Goran", "Hahah! Dentuman pertempuranmu di Katakombe terdengar sampai ke kota Altdorf! Kau berhasil menumbangkan Panglima Tengkorak dan merebut Kunci Sanctum Guardian!", "goran", "protagonist", "left", "exclamation");
        _d.add("Protagonist", "Benar, Paman Goran. Di depan sana adalah Sanctum Guardian. Bahayanya jauh lebih besar dari semua dungeon sebelumnya.", "goran", "protagonist", "right");
        _d.add("Goran", "Maka kau tak boleh menghadapinya sendirian! Puluhan tahun aku hanya menempa baja di bengkel ini... Hari ini, darah ksatria veteran di dalam diriku membara! Izinkan palu dan kapak tempurku bertarung di sisimu!", "goran", "protagonist", "left", "exclamation");
        _d.add("Protagonist", "Paman Goran... Sungguh kehormatan besar bertarung di sampingmu. Mari kita hancurkan monster purba itu dan selamatkan Sestrina!", "goran", "protagonist", "right");
        _d.add("Goran", "Bagus sekali! Siapkan senjatamu, anak muda! Mulai detik ini, aku adalah rekan tempurmu!", "goran", "protagonist", "left", "exclamation");
        _d.start(function() {
            global.party_goran = true;
            if (!instance_exists(oCompanion_Goran)) {
                instance_create_depth(x, y + 20, -100, oCompanion_Goran);
            }
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "GORAN BERGABUNG KE PARTY!";
                oRoomTransition.banner_subtitle = "Ksatria Pandai Besi kini mengawalmu dan bertempur di setiap dungeon!";
                oRoomTransition.banner_timer = 220;
            }
        });
        return;
    }
    
    // 2. Goran sudah ada di Party
    if (global.party_goran) {
        _d.add("Goran", "Bengkel ini aman selama aku bertualang di sisimu. Butuh menempa atau mengasah senjatamu sekarang?", "goran", "protagonist", "left");
        _d.start(function() {
            global.shop_menu_open = "goran";
        });
        return;
    }
    
    // 3. Quest Pertama - Ambil Pedang Karat
    if (global.weapon_tier == 0) {
        _d.add("Goran", "Hahah! Butuh senjata untuk menembus hutan reruntuhan? Aku punya pedang tua di sudut bengkel.", "goran", "protagonist", "left", "exclamation");
        _d.add("Protagonist", "Paman Goran, pedang ini berkarat dan tumpul...", "goran", "protagonist", "right", "sweat");
        _d.add("Goran", "Pedang Karat ini masih cukup tajam untuk menebas slime! Kumpulkan Besi Bekas, Bijih Besi, dan Tulang Monster, lalu bawa kemari agar kutempa menjadi pedang perang sejati!", "goran", "protagonist", "left", "exclamation");
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
        return;
    }
    
    // 4. Menu Tempa Senjata Standar
    global.shop_menu_open = "goran";
};
