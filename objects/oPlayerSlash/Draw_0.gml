/// @description Draw Event - Efek Percikan Kilau Tebasan Pedang (Hit Sparks Only)

// Animasi pedang sudah digambar secara utuh & detail oleh karakter baru (spr_player_combo*)
// Di sini hanya merender percikan api/kilau benturan tebasan saat mengenai musuh/objek

for (var _s = 0; _s < array_length(sparks); _s++) {
    var _sp = sparks[_s];
    draw_set_alpha(_sp.alpha);
    draw_set_color(_sp.col);
    draw_circle(_sp.xx, _sp.yy, _sp.size, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
