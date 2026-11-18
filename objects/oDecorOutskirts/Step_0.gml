/// @description Step Event - Animasi Kabut & Partikel Hutan Kuno

mist_anim += 0.04;
tree_sway += 0.03;

for (var _i = 0; _i < array_length(wisps); _i++) {
    wisps[_i].xx += wisps[_i].spd;
    wisps[_i].yy += sin(tree_sway + wisps[_i].phase) * 0.45;
    if (wisps[_i].xx > 1300) {
        wisps[_i].xx = -30;
        wisps[_i].yy = irandom(720);
    }
}
