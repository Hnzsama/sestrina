/// @description Inisialisasi NPC Non-Quest Warga Kota Altdorf

event_inherited();
interact_range = 45;
prompt_y_offset = -38;
anim_timer = random(100);

// Tentukan peran NPC berdasarkan posisi koordinat di Kota Altdorf
if (!variable_instance_exists(id, "npc_role")) {
    if (x < 1000 && y > 480 && y < 750) {
        npc_role = "merchant";
    } else if (y < 250 && x > 1100 && x < 1400) {
        npc_role = "guard_north";
    } else if (y > 1200 && x > 1100 && x < 1400) {
        npc_role = "guard_south";
    } else if (x > 1650 && y > 400 && y < 650) {
        npc_role = "flower_girl";
    } else if (x < 900 && y > 900) {
        npc_role = "cafe_patron";
    } else if (x > 2200) {
        npc_role = "fisherman";
    } else {
        npc_role = "elder";
    }
}

// Konfigurasi Spesifik Tiap Peran Warga
switch (npc_role) {
    case "merchant":
        npc_name = "Marcus Pedagang Bahan & Mineral";
        prompt_text = "[Z] Kios Bahan & Mineral";
        sprite_index = sNPC_Alden;
        image_speed = 0.06;
        image_xscale = 1.25;
        image_yscale = 1.25;
        interact_action = function() {
            global.shop_menu_open = "material_trader";
        };
        break;

    case "guard_north":
        npc_name = "Pengawal Roland";
        prompt_text = "[Z] Bicara dgn Pengawal";
        sprite_index = sNPC_Alden;
        image_speed = 0.05;
        image_xscale = 1.3;
        image_yscale = 1.3;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Pengawal Roland", "Salam, petualang! Jalan setapak utara ini menghubungkan kota dengan pondok terpencil di tepi hutan.", "alden", "protagonist", "left");
            _d.add("Pengawal Roland", "Kami rutin menyisir perbatasan. Jika malam tiba, waspadalah... Angin pegunungan membawa hawa dingin yang menusuk tulang!", "alden", "protagonist", "left", "dots");
            _d.start();
        };
        break;

    case "guard_south":
        npc_name = "Pengawal Thorne";
        prompt_text = "[Z] Bicara dgn Penjaga Benteng";
        sprite_index = sNPC_Alden;
        image_speed = 0.05;
        image_xscale = 1.3;
        image_yscale = 1.3;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Pengawal Thorne", "Waspada, petualang. Di balik gerbang selatan ini terbentang Hutan Reruntuhan dan Katakombe Purba.", "alden", "protagonist", "left", "exclamation");
            _d.add("Pengawal Thorne", "Aura sihir terdistorsi bangkit dari reruntuhan bawah tanah. Pastikan pedangmu tajam dan bekal ramuanmu penuh sebelum melangkah keluar!", "alden", "protagonist", "left");
            _d.start();
        };
        break;

    case "elder":
        npc_name = "Nenek Martha";
        prompt_text = "[Z] Bicara dgn Nenek Martha";
        sprite_index = sNPC_Elysia;
        image_speed = 0.05;
        image_xscale = 1.25;
        image_yscale = 1.25;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Nenek Martha", "Oh, petualang muda... Tatapan matamu begitu teguh dan penuh kasih sayang.", "elysia", "protagonist", "left", "dots");
            _d.add("Nenek Martha", "Kudengar adikmu Sestrina sedang terbaring melawan kutukan mana. Jangan putus asa, nak... Doa seluruh warga Altdorf menyertaimu!", "elysia", "protagonist", "left", "happy");
            _d.start();
        };
        break;

    case "flower_girl":
        npc_name = "Lily si Pemelihara Bunga";
        prompt_text = "[Z] Bicara dgn Lily";
        sprite_index = sNPC_Elysia;
        image_speed = 0.06;
        image_xscale = 1.25;
        image_yscale = 1.25;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Lily", "Selamat datang di Kebun Botani Altdorf! Harum sekali bukan? Bunga lavender ini sedang mekar sempurna.", "elysia", "protagonist", "left", "happy");
            _d.add("Lily", "Nona Elysia rutin mengambil kelopak bungaku untuk ramuan penenang rasa sakit. Semoga ekstrak bunga ini bisa meringankan demam adikmu!", "elysia", "protagonist", "left", "heart");
            _d.start();
        };
        break;

    case "cafe_patron":
        npc_name = "Finn si Petualang";
        prompt_text = "[Z] Bicara dgn Finn";
        sprite_index = sNPC_Goran;
        image_speed = 0.05;
        image_xscale = 1.25;
        image_yscale = 1.25;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Finn", "Ahh... Secangkir kopi hangat di teras Altdorf adalah hadiah terbaik setelah seharian bertarung!", "goran", "protagonist", "left", "happy");
            _d.add("Finn", "Tips petualang dariku: jika musuh bersiap mengayunkan serangan kuat, gunakan tombol [Shift] untuk Roll Menghindar di saat yang tepat!", "goran", "protagonist", "left", "exclamation");
            _d.start();
        };
        break;

    case "fisherman":
        npc_name = "Kakek Tobias si Nelayan";
        prompt_text = "[Z] Bicara dgn Kakek Tobias";
        sprite_index = sNPC_Goran;
        image_speed = 0.05;
        image_xscale = 1.25;
        image_yscale = 1.25;
        interact_action = function() {
            var _d = dialogue_create();
            _d.add("Kakek Tobias", "Kecipak air sungai Altdorf selalu menyejukkan hati... Ikan-ikan perak berenang riang di bawah sinar mentari.", "goran", "protagonist", "left");
            _d.add("Kakek Tobias", "Air ini konon bersumber dari telaga suci di puncak reruntuhan purba. Semoga aliran berkah menyertai usahamu menyelamatkan Sestrina, nak.", "goran", "protagonist", "left", "happy");
            _d.start();
        };
        break;
}
