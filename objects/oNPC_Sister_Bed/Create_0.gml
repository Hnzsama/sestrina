/// @description Inisialisasi NPC Adik Sestrina di Ranjang

event_inherited();
sprite_index = sNPC_Sister_Bed;
image_speed = 0.05;
prompt_text = "[E] Cek Kondisi Sestrina";
interact_range = 42;
auto_trigger_range = 38; // Otomatis picu dialog saat pertama mendekat
has_auto_triggered = false;
talk_count = 0;

/// @function interact_action()
interact_action = function() {
    if (global.dialogue_active) exit;
    
    talk_count++;
    var _d = dialogue_create();
    
    if (global.player_has_remedy) {
        // Ending Dialog - Kesembuhan Sestrina
        _d.add("Protagonis", "Sestrina! Aku berhasil membawanya! Ini Bunga Cahaya Abadi dari Kuil Purba!", "protagonist", "sestrina", "left")
          .add("Sestrina", "K-kakak... cahayanya begitu hangat dan menenangkan... rasa sakit di tubuhku perlahan menghilang...", "protagonist", "sestrina", "right")
          .add("Protagonis", "Kutukan itu telah lenyap sepenuhnya! Kau sudah sembuh, Sestrina!", "protagonist", "sestrina", "left")
          .add("Sestrina", "Terima kasih banyak, Kakak...! Kau adalah pahlawan terhebat di dunia!", "protagonist", "sestrina", "right")
          .add("Protagonis", "Kita akan selalu menjaga satu sama lain. Mari kita hidup damai bersama di kerajaan ini.", "protagonist", "sestrina", "left");
        
        _d.start(function() {
            scr_set_quest(5, "TAMAT - Sestrina Sembuh!", "Selamat! Anda telah menyelesaikan pencarian Lost Remedy!");
        });
        exit;
    }

    if (talk_count == 1) {
        // Dialog Prologue Pertama
        _d.add("Protagonis", "Sestrina...! Bertahanlah! Tubuhmu semakin panas dan menggigil...", "protagonist", "sestrina", "left")
          .add("Sestrina", "K-kakak... kepalaku sangat pusing... rasanya tubuhku kaku dan dingin sekali...", "protagonist", "sestrina", "right")
          .add("Protagonis", "Racun kutukan ini menjalar terlalu cepat... Ramuan obat biasa dari desa sudah tidak mempan lagi.", "protagonist", "sestrina", "left")
          .add("Sestrina", "Jangan memaksakan diri demi aku, Kak... Konon mereka yang pergi ke Kuil Kuno tidak pernah kembali...", "protagonist", "sestrina", "right")
          .add("Protagonis", "Aku tidak akan membiarkan apapun merenggutmu! Legenda mengatakan 'Lost Remedy' tersimpan di Altar Suci Kuil Kuno. Aku bersumpah akan membawanya pulang untukmu!", "protagonist", "sestrina", "left")
          .add("Sestrina", "Kakak... jika kamu benar-benar harus pergi, tolong singgahlah ke Toko Ramuan Elysia dan Pandai Besi Goran di desa untuk persiapan...", "protagonist", "sestrina", "right")
          .add("Protagonis", "Tenanglah dan istirahatlah, Sestrina. Aku akan segera kembali membawa obat penawar itu!", "protagonist", "sestrina", "left");
          
        _d.start(function() {
            scr_set_quest(1, "Persiapan di Kota", "Temui Goran (Toko Senjata) & Elysia (Apotek)");
        });
    } else {
        // Dialog pengingat setelah prologue selesai
        _d.add("Sestrina", "Kakak... berhati-hatilah di perjalanan. Jangan lupa beli ramuan pemulih di Toko Elysia...", "protagonist", "sestrina", "right")
          .add("Protagonis", "Iya, jangan khawatir. Aku akan segera kembali.", "protagonist", "sestrina", "left");
        
        _d.start();
    }
};
