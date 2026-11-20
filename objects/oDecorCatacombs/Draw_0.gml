/// @description Draw Event oDecorCatacombs (Forbidden Crypt - V5 Perfect Refined)

var _cx = 640;
var _cy = 360;

// 1. Latar Belakang Luar Katakombe Gelap (Outer Dungeon Frame)
draw_set_color(make_color_rgb(10, 11, 16));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Flagstone Seamless (Paving 64x64 Rapat Tanpa Celah)
for (var _fy = 64; _fy <= 660; _fy += 64) {
    for (var _fx = 64; _fx <= 1216; _fx += 64) {
        var _h = ((_fx * 17) + (_fy * 31)) mod 10;
        if (_h < 8) {
            draw_sprite(sDungeon_TileFloor_Large, 0, _fx, _fy);
        } else {
            draw_sprite(sDungeon_TileFloor_Strip, 0, _fx, _fy);
        }
    }
}

// 3. Dinding Batu Purba Utara (North Wall)
for (var _wx = 64; _wx <= 1216; _wx += 230) {
    draw_sprite(sDungeon_Wall_Brick, 0, _wx, 18);
}

// Gerbang Masuk Kubah Batu Utara (Pintu Masuk dari Kota)
draw_sprite(sDungeon_Wall_Arch, 0, 640 - 55, 3);

// Bendera Tengkorak Ungu Kembar Identik (Symmetrical Banners)
draw_sprite(sDungeon_Decor_WallTorch, 0, 530, 38);
draw_sprite(sDungeon_Decor_WallTorch, 0, 709, 38);

// Rantai Dinding Besi
draw_sprite(sDungeon_Decor_WallChain, 0, 320, 46);
draw_sprite(sDungeon_Decor_WallChain, 0, 920, 46);

// 4. Dinding Batu Purba Selatan (South Wall)
for (var _wx = 64; _wx <= 1216; _wx += 230) {
    draw_sprite(sDungeon_Wall_Brick, 0, _wx, 636);
}

// Gerbang Jeruji Besi Bos (Portcullis Gate South)
draw_sprite(sDungeon_Gate_Portcullis, 0, 640 - 73, 544);

// 5. Dinding Samping Lurus Rapi (Straight West & East Walls)
for (var _wy = 80; _wy <= 640; _wy += 126) {
    draw_sprite(sDungeon_Pillar_Corner, 0, 64, _wy);
    draw_sprite(sDungeon_Pillar_Corner, 0, room_width - 64 - 46, _wy);
}

// 6. Pilar-Pilar Batu Lorong Utama (Colonnade Architecture)
var _draw_pillar = function(_px, _py) {
    // Bayangan pilar
    draw_set_alpha(0.35);
    draw_set_color(c_black);
    draw_ellipse(_px - 22, _py - 3, _px + 22, _py + 8, false);
    draw_set_alpha(1.0);
    // Pilar batu
    draw_sprite(sDungeon_Pillar_Stone, 0, _px - 26, _py - 158);
};

_draw_pillar(380, 260);
_draw_pillar(900, 260);
_draw_pillar(380, 450);
_draw_pillar(900, 450);

// Tungku Api Jiwa Hijau di Dasar Pilar
var _draw_green_brazier = function(_bx, _by) {
    // Bayangan tungku
    draw_set_alpha(0.32);
    draw_set_color(c_black);
    draw_ellipse(_bx - 14, _by - 3, _bx + 14, _by + 5, false);
    draw_set_alpha(1.0);
    
    draw_sprite(sDungeon_Prop_BrazierIron, 0, _bx - 28, _by - 167);
    
    // Pendaran Cahaya Hijau Mistis
    var _glow = 0.8 + sin(torch_blue_flame + _bx) * 0.2;
    draw_set_alpha(0.20 * _glow);
    draw_set_color(make_color_rgb(80, 255, 120));
    draw_circle(_bx, _by - 120, 55, false);
    draw_set_alpha(0.08 * _glow);
    draw_circle(_bx, _by - 120, 85, false);
    draw_set_alpha(1.0);
};

_draw_green_brazier(380, 280);
_draw_green_brazier(900, 280);
_draw_green_brazier(380, 470);
_draw_green_brazier(900, 470);

// 7. Sayap Barat: Makam Sarkofagus & Peti Suplai Kayu
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(200 - 22, 250 - 3, 200 + 22, 250 + 6, false);
draw_ellipse(275 - 16, 250 - 3, 275 + 16, 250 + 5, false);
draw_set_alpha(1.0);

draw_sprite(sDungeon_Prop_Sarcophagus, 0, 200 - 28, 250 - 115);
draw_sprite(sDungeon_Prop_GrandSarcophagus, 0, 275 - 21, 250 - 82);

// 8. Sayap Timur: Batu Runic Monolit & Peti Harta Karun
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(1080 - 28, 250 - 3, 1080 + 28, 250 + 7, false);
draw_ellipse(1000 - 18, 250 - 3, 1000 + 18, 250 + 5, false);
draw_set_alpha(1.0);

draw_sprite(sDungeon_Prop_RitualAltar, 0, 1080 - 59, 250 - 127);
draw_sprite(sDungeon_Chest_Gold, 0, 1000 - 52, 250 - 76);

// Pendaran Cyan Batu Runic
var _rglow = 0.8 + sin(torch_blue_flame * 1.2) * 0.2;
draw_set_alpha(0.18 * _rglow);
draw_set_color(make_color_rgb(70, 220, 255));
draw_circle(1080, 210, 60, false);
draw_set_alpha(1.0);

// 9. Jebakan Duri Lantai di Lorong Tengah (Spike Traps)
var _spikes_active = (spike_cycle >= 70 && spike_cycle <= 125);
var _spikes_warning = (spike_cycle >= 50 && spike_cycle < 70);
var _spike_mid_x = 640;
var _spike_mid_y = 360;

if (_spikes_active) {
    draw_sprite(sDungeon_Trap_SpikesUp, 0, _spike_mid_x, _spike_mid_y);
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(255, 60, 60));
    draw_circle(_spike_mid_x, _spike_mid_y, 45, false);
    draw_set_alpha(1.0);
} else {
    draw_sprite(sDungeon_Trap_SpikesDown, 0, _spike_mid_x, _spike_mid_y);
    if (_spikes_warning) {
        var _shake_x = irandom_range(-2, 2);
        draw_set_alpha(0.4);
        draw_set_color(make_color_rgb(255, 200, 60));
        draw_circle(_spike_mid_x + _shake_x, _spike_mid_y, 30, false);
        draw_set_alpha(1.0);
    }
}

// 10. Lingkaran Segel Sihir Pemanggilan Ungu di Lantai
var _rune_alpha = 0.65 + sin(torch_blue_flame * 1.5) * 0.25;
draw_sprite_ext(sDungeon_Magic_RunePurple, 0, 640, 510, 0.85, 0.85, 0, c_white, _rune_alpha);

// Pendaran Ungu Halus
draw_set_alpha(0.16 * _rune_alpha);
draw_set_color(make_color_rgb(160, 90, 255));
draw_circle(640, 510, 75, false);
draw_set_alpha(1.0);

// 11. Patung Penjaga Gerbang Bos (Grim Reaper Statues)
var _draw_statue = function(_sx, _sy) {
    draw_set_alpha(0.35);
    draw_set_color(c_black);
    draw_ellipse(_sx - 18, _sy - 2, _sx + 18, _sy + 5, false);
    draw_set_alpha(1.0);
    draw_sprite(sDungeon_Prop_Tomb, 0, _sx - 23, _sy - 110);
};

_draw_statue(500, 630);
_draw_statue(780, 630);

// 12. Label Pintu Keluar Utara & Selatan
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(255, 230, 140));
draw_text(640, 32, "▲ KOTA ALTDORF");

draw_set_color(make_color_rgb(255, 120, 120));
draw_text(640, 672, "☠ GERBANG FORGOTTEN SANCTUM");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
