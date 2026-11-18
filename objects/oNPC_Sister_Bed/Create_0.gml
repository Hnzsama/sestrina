/// @description Inisialisasi NPC Adik Sestrina di Ranjang (Overclock Mana Leak)

event_inherited();
sprite_index = noone; // Ranjang sudah terpasang presisi di room background
mask_index = sNPC_Sister_Bed;
image_speed = 0.05;
prompt_text = "[E] Cek Sestrina • [T] Istirahat Tidur";
interact_range = 65;
auto_trigger_range = 55;
has_auto_triggered = false;
talk_count = 0;

/// @function interact_action()
interact_action = function() {
    if (global.dialogue_active) exit;
    
    // Jika menekan tombol T saat dekat ranjang -> Fitur Bed Rest (Reference: rest bed option.png)
    if (keyboard_check_pressed(ord("T"))) {
        var _d_rest = dialogue_create();
        var _target_time = (global.time_of_day == "Daytime") ? "malam hari" : "pagi hari";
        _d_rest.add("Protagonis", "Tubuhku lelah... Aku akan beristirahat di samping Sestrina hingga " + _target_time + "...", "protagonist", "sestrina", "left")
               .add("Protagonis", "Tertidur pulas... Memulihkan seluruh HP, MP, dan Stamina.", "protagonist", "sestrina", "left");
        _d_rest.start(function() {
            scr_advance_time();
            global.player_hp = global.player_max_hp;
            global.player_mp = global.player_max_mp;
            global.player_stamina = global.player_max_stamina;
            scr_save_game("quicksave"); // Auto-save saat tidur di samping adik
        });
        exit;
    }
    
    talk_count++;
    var _d = dialogue_create();
    
    // CEK ENDING 3: Batas Waktu Terlampaui (Hari 6+) Sebelum Remedy Diperoleh
    if (global.day_count >= 6 && !global.player_has_remedy) {
        _d.add("Protagonis", "Sestrina...! Aku kembali...! Sestrina...?!", "protagonist", "sestrina", "left", "exclamation")
          .add("Protagonis", "(Tangannya terasa dingin membeku... Nafasnya telah tiada... Overclock kebocoran mana telah melahap seluruh raganya...)", "protagonist", "sestrina", "left", "sweat")
          .add("Protagonis", "Tidak... TIDAK! Waktunya telah habis... Aku terlambat menyelamatkanmu... Maafkan aku, Sestrina...!!", "protagonist", "sestrina", "left", "dots");
        _d.start(function() {
            global.game_ending = "death";
            scr_set_quest(6, "ENDING 3 - Kegagalan Tragis", "Hari telah melampaui batas waktu. Adik tercinta telah tiada...");
        });
        exit;
    }
    
    // CEK ENDING 1 & ENDING 2: The Lost Remedy Berhasil Dibawa Pulang
    if (global.player_has_remedy) {
        if (variable_global_exists("demon_unsealed") && global.demon_unsealed) {
            // ENDING 2: Setengah Iblis (Half-Demon) - The Crimson Pact
            _d.add("Protagonis", "Sestrina! Aku membawa The Lost Remedy! Minumlah ini secepatnya!", "protagonist", "sestrina", "left", "exclamation")
              .add("Sestrina", "K-kakak... rasa terbakar dari kebocoran mana ini... perlahan lenyap...", "protagonist", "sestrina", "right", "dots")
              .add("Sestrina", "Tapi... matamu, Kak... kenapa merah membara bagai darah...? Dan aura tanduk kegelapan ini...?", "protagonist", "sestrina", "right", "sweat")
              .add("Protagonis", "Aku membuka segel darah iblis di kuil purba demi mengalahkan sang penjaga. Demi menyelamatkanmu, aku rela menanggalkan kemanusiaanku.", "protagonist", "sestrina", "left", "dots")
              .add("Sestrina", "Kakak... apa yang telah kau korbankan demi diriku...? (Air mata Sestrina menetes membasahi jubah kakaknya)", "protagonist", "sestrina", "right", "sweat");
            _d.start(function() {
                global.game_ending = "half_demon";
                scr_set_quest(5, "ENDING 2 - Meninggalkan Kemanusiaan", "Sestrina sembuh, namun kutukan darah iblis kini mengikat jiwa sang kakak.");
            });
            exit;
        } else {
            // ENDING 1: Tetap Manusia (Pure Human Ending) - The Pure Remedy
            _d.add("Protagonis", "Sestrina! Aku berhasil membawanya! Ini The Lost Remedy dari Altar Kuil Purba Forgotten Sanctum!", "protagonist", "sestrina", "left", "exclamation")
              .add("Sestrina", "K-kakak... rasa terbakar dari kebocoran mana itu... perlahan mereda... nafasku terasa hangat...", "protagonist", "sestrina", "right", "sweat")
              .add("Protagonis", "Overclock pada sirkulasi sihirmu telah dinetralkan seutuhnya! Kau sudah selamat, adikku!", "protagonist", "sestrina", "left", "exclamation")
              .add("Sestrina", "Terima kasih banyak, Kakak... Maafkan aku yang memaksakan diri saat kita ditinggalkan party di dungeon itu...", "protagonist", "sestrina", "right", "dots")
              .add("Protagonis", "Tidak ada yang perlu dimaafkan. Kita manusia biasa, tapi kita tidak akan pernah menyerah. Kita pulang bersama sekarang.", "protagonist", "sestrina", "left");
            _d.start(function() {
                global.game_ending = "human";
                scr_set_quest(5, "ENDING 1 - Tetap Manusia!", "Selamat! Sestrina pulih total dan kemanusiaanmu tetap terjaga!");
            });
            exit;
        }
    }

    if (talk_count == 1) {
        // Dialog Prologue Pertama: Lore Pengkhianatan & Overclock Mana Leak
        _d.add("Protagonis", "Sestrina...! Bertahanlah! Nafasmu semakin berat dan tubuhmu menggigil...", "protagonist", "sestrina", "left", "exclamation")
          .add("Sestrina", "K-kakak... kepalaku sangat pusing... kebocoran mana ini semakin parah sejak insiden dungeon terlarang itu...", "protagonist", "sestrina", "right", "sweat")
          .add("Protagonis", "Overclock saat kau menahan serangan fatal demi melindungiku telah merusak sirkulasi sihirmu. Ramuan biasa desa tidak mempan.", "protagonist", "sestrina", "left", "exclamation")
          .add("Sestrina", "Rambutku... mulai memutih ya, Kak? Jangan pergi ke Forgotten Sanctum... Mereka mencampakkan kita karena kita manusia biasa, kau tak perlu mati sia-sia...", "protagonist", "sestrina", "right", "dots")
          .add("Protagonis", "Bagi mereka manusia hanyalah harga yang paling murah. Tapi bagiku, kau adalah segalanya! Legenda mengatakan 'The Lost Remedy' ada di Sanctum Core. Aku bersumpah membawanya pulang!", "protagonist", "sestrina", "left", "exclamation")
          .add("Sestrina", "Kakak... temui Pandai Besi Goran dan Alkemis Elysia di kota Altdorf untuk persiapan senjata dan ramuanmu...", "protagonist", "sestrina", "right", "dots")
          .add("Protagonis", "Tenanglah dan istirahatlah, Sestrina. Aku akan segera kembali sebelum waktumu habis!", "protagonist", "sestrina", "left");
          
        _d.start(function() {
            scr_set_quest(1, "Persiapan di Kota", "Temui Goran (Toko Senjata) & Elysia (Apotek)");
        });
    } else {
        // Dialog pengingat & dinamika penyakit berdasarkan siklus Day/Night
        if (global.day_count <= 2) {
            _d.add("Sestrina", "Uhuk... Kakak... berhati-hatilah di perjalanan. Kalahkan monster di Outskirts untuk mengumpulkan bahan tempa Goran...", "protagonist", "sestrina", "right", "sweat")
              .add("Protagonis", "Istirahatlah. Aku sedang mengumpulkan bekal terbaik untuk menembus Katakombe.", "protagonist", "sestrina", "left");
        } else if (global.day_count <= 4) {
            // Kondisi memburuk jika hari berlarut
            _d.add("Sestrina", "Kak... kau sudah makan...? Jangan memaksakan diri sendirian...", "protagonist", "sestrina", "right", "dots")
              .add("Protagonis", "(Rambutnya semakin memutih dan nafasnya melemah... Waktu kita tidak banyak!)", "protagonist", "sestrina", "left", "sweat")
              .add("Protagonis", "Aku sudah makan. Tetaplah terjaga, aku akan kembali membawakan Lost Remedy secepatnya!", "protagonist", "sestrina", "left");
        } else {
            // Kondisi kritis mendekati batas waktu
            _d.add("Sestrina", "(Sestrina terlelap dingin... nafasnya tersengal-sengal dan rambutnya telah memutih seutuhnya...)", "protagonist", "sestrina", "right", "dots")
              .add("Protagonis", "Sestrina! Bertahanlah! Tinggal selangkah lagi di Forgotten Sanctum! Aku tidak akan membiarkanmu tiada!", "protagonist", "sestrina", "left", "exclamation");
        }
        
        _d.start();
    }
};
