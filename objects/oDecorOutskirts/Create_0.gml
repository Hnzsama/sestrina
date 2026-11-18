/// @description Inisialisasi Ancient Forest Outskirts Decor

depth = 10;
mist_anim = 0;
tree_sway = 0;

wisps = [];
for (var _w = 0; _w < 14; _w++) {
    array_push(wisps, {
        xx: irandom(1280),
        yy: irandom(720),
        spd: random_range(0.35, 0.8),
        rad: random_range(1.8, 3.2),
        phase: random(10)
    });
}
