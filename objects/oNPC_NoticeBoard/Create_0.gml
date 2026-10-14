/// @description Inisialisasi Papan Pengumuman Altdorf

event_inherited();
interact_range = 35;
prompt_text = "[E] Baca Pengumuman";
prompt_y_offset = -32;

interact_action = function() {
    var _d = dialogue_create();
    _d.add("Papan Pengumuman", "MAKLUMAT KERAJAAN ALTDORF:\n1. Toko Senjata Goran (Kiri): Buka setiap hari untuk perlengkapan prajurit.\n2. Apotek Alkemis Elysia (Kanan): Sedia penawar racun & eliksir kehidupan.\n3. PERINGATAN: Gerbang Katakombe Selatan sangat berbahaya! Penjaga batu purba telah bangkit.", "", "", "left");
    _d.start();
};
