/// @description Inisialisasi Papan Pengumuman Altdorf (Lore Forgotten Sanctum)

event_inherited();
interact_range = 35;
prompt_text = "[E] Baca Pengumuman";
prompt_y_offset = -32;

interact_action = function() {
    var _d = dialogue_create();
    _d.add("Papan Pengumuman", "MAKLUMAT KERAJAAN ALTDORF:\n1. Bengkel Goran (Kiri): Sedia tempa pedang penembus armor penjaga kuil purba.\n2. Apotek Elysia (Kanan): Ramuan pemulih & grimoire mantra es pembeku.\n3. PERINGATAN: Katakombe Selatan dan Forgotten Sanctum dijaga oleh Ancient Stone Golem. Membawa 'The Lost Remedy' keluar dari sana hampir mustahil!\n\n✦ [Membuka Peta Panduan Wilayah Altdorf...] ✦", "", "", "left", "exclamation");
    _d.start(function() {
        global.map_menu_open = true;
    });
};
