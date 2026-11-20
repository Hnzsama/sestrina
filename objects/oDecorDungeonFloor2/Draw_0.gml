/// @description Draw Event oDecorDungeonFloor2 (Opsi A - Dinding Batu Masif)

// 1. Frame Luar Gelap
draw_set_color(make_color_rgb(8, 9, 14));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Ubin Batu & Kristal Seamless (Cobblestone & Mana Crystal Paving)
for (var _fy = 64; _fy <= 660; _fy += 64) {
    for (var _fx = 64; _fx <= 1216; _fx += 64) {
        var _h = ((_fx * 19) + (_fy * 29)) mod 10;
        if (_h < 7) {
            draw_sprite(sDungeon2_TileFloor, 0, _fx, _fy);
        } else {
            draw_sprite(sDungeon2_TileFloor_Mana, 0, _fx, _fy);
        }
    }
}

// 3. Dinding Batu Utara (North Stalactite Wall)
for (var _wx = 64; _wx <= 1216; _wx += 236) {
    draw_sprite(sDungeon2_Wall_Stalactite, 0, _wx, 16);
}

// Gerbang Masuk Utara (Pintu Lengkung Kayu dari Floor 1)
draw_sprite(sDungeon2_Door_ArchWood, 0, 640 - 41, 128 - 119);

// Bendera Ungu Kembar Simetris
draw_sprite(sDungeon2_Banner_Purple, 0, 525, 34);
draw_sprite(sDungeon2_Banner_Purple, 0, 755 - 72, 34);

// 4. Dinding Batu Selatan (South Stalactite Wall)
for (var _wx = 64; _wx <= 1216; _wx += 236) {
    draw_sprite(sDungeon2_Wall_Stalactite, 0, _wx, 636);
}

// Gerbang Bos Selatan (Pintu Baja Berantai Gembok Segel - Syarat Pedang Lv 4)
draw_sprite(sDungeon2_Gate_ChainedBoss, 0, 640 - 40, 672 - 120);

// Gargoyle Pedestal Penjaga Gerbang Bos
draw_sprite(sDungeon2_Prop_Gargoyle, 0, 500 - 21, 630 - 106);
draw_sprite(sDungeon2_Prop_Gargoyle, 0, 780 - 21, 630 - 106);

// 5. Dinding Samping Barat & Timur (Opsi A: Dinding Batu Bata Masif Kokoh!)
for (var _wy = 80; _wy <= 640; _wy += 126) {
    draw_sprite(sDungeon_Pillar_Corner, 0, 64, _wy);
    draw_sprite(sDungeon_Pillar_Corner, 0, room_width - 64 - 46, _wy);
}

// 6. Arsitektur Tambang: 4 Pilar Kayu Penyangga & Lentera Api
var _draw_mine_pillar = function(_px, _py) {
    // Bayangan pilar
    draw_set_alpha(0.35);
    draw_set_color(c_black);
    draw_ellipse(_px - 26, _py - 4, _px + 26, _py + 8, false);
    draw_set_alpha(1.0);
    
    draw_sprite(sDungeon2_Pillar_Timber, 0, _px - 54, _py - 145);
    draw_sprite(sDungeon2_Brazier_Flame, 0, _px - 37, _py + 18 - 98);
    
    // Pendaran Cahaya Lentera Api Hangat
    var _flame_pulse = 0.85 + sin(flame_anim + _px) * 0.15;
    draw_set_alpha(0.18 * _flame_pulse);
    draw_set_color(make_color_rgb(255, 180, 70));
    draw_circle(_px, _py - 40, 65, false);
    draw_set_alpha(0.08 * _flame_pulse);
    draw_circle(_px, _py - 40, 95, false);
    draw_set_alpha(1.0);
};

_draw_mine_pillar(380, 260);
_draw_mine_pillar(900, 260);
_draw_mine_pillar(380, 460);
_draw_mine_pillar(900, 460);

// 7. Sayap Barat: Rel & Kereta Tambang Kristal
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(230 - 20, 275 - 2, 230 + 20, 275 + 6, false);
draw_ellipse(290 - 24, 240 - 2, 290 + 24, 240 + 6, false);
draw_set_alpha(1.0);

draw_sprite(sDungeon2_Prop_MineRails, 0, 230 - 65, 290 - 113);
draw_sprite(sDungeon2_Prop_MineCart, 0, 230 - 41, 275 - 101);
draw_sprite(sDungeon2_Prop_Flatcar, 0, 290 - 75, 240 - 75);

// Pendaran Biru Kristal Gerobak Tambang
draw_set_alpha(0.2);
draw_set_color(make_color_rgb(80, 220, 255));
draw_circle(230, 240, 45, false);
draw_set_alpha(1.0);

// 8. Sayap Timur: Batu Runic Monolit, Jamur Cahaya, & Peti Kristal Ungu
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_ellipse(1080 - 30, 250 - 3, 1080 + 30, 250 + 8, false);
draw_ellipse(1000 - 20, 250 - 2, 1000 + 20, 250 + 6, false);
draw_set_alpha(1.0);

draw_sprite(sDungeon2_Prop_RunicStones, 0, 1080 - 50, 250 - 141);
draw_sprite(sDungeon2_Prop_ChestPurple, 0, 1000 - 41, 250 - 63);
draw_sprite(sDungeon2_Prop_MushroomsBlue, 0, 1140 - 38, 280 - 96);
draw_sprite(sDungeon2_Prop_MushroomsPurple, 0, 1020 - 31, 280 - 76);

// Pendaran Cyan Suaka Runic
var _rglow = 0.85 + sin(flame_anim * 1.2) * 0.15;
draw_set_alpha(0.18 * _rglow);
draw_set_color(make_color_rgb(70, 220, 255));
draw_circle(1080, 220, 65, false);
draw_set_alpha(1.0);

// 9. Jebakan Duri Tengah & Segel Sihir Ungu di Depan Pintu Bos
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
    draw_sprite(sDungeon2_Trap_Spikes, 0, _spike_mid_x, _spike_mid_y);
    if (_spikes_warning) {
        var _shake = irandom_range(-2, 2);
        draw_set_alpha(0.4);
        draw_set_color(make_color_rgb(255, 200, 60));
        draw_circle(_spike_mid_x + _shake, _spike_mid_y, 30, false);
        draw_set_alpha(1.0);
    }
}

// Segel Sihir Ungu Pemanggilan (Purple Glyph)
var _glyph_alpha = 0.7 + sin(flame_anim * 1.5) * 0.25;
draw_sprite_ext(sDungeon2_Rune_PurpleGlyph, 0, 640, 510, 0.8, 0.8, 0, c_white, _glyph_alpha);
draw_set_alpha(0.16 * _glyph_alpha);
draw_set_color(make_color_rgb(180, 70, 255));
draw_circle(640, 510, 80, false);
draw_set_alpha(1.0);

// 10. Label Navigasi Pintu
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(make_color_rgb(255, 230, 140));
draw_text(640, 32, "▲ KEMBALI KE LANTAI 1 (KATAKOMBE)");

draw_set_color(make_color_rgb(255, 120, 120));
draw_text(640, 672, "☠ GERBANG FORGOTTEN SANCTUM [PEDANG LV 4]");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
