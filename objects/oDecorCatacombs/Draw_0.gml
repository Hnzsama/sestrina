/// @description Draw Event oDecorCatacombs (Forbidden Crypt - Authentic Floor 1 Assets)

var _x1 = 40;
var _y1 = 40;
var _x2 = 1240;
var _y2 = 680;
var _cx = 640;

// 1. Latar Belakang Luar Katakombe Gelap (Outer Dungeon Frame)
draw_set_color(make_color_rgb(8, 10, 14));
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Lantai Batu Flagstone Katakombe (Authentic Floor 1 Atlas Tiles)
for (var _fy = _y1 + 100; _fy <= _y2; _fy += 120) {
    for (var _fx = _x1 + 100; _fx <= _x2 + 50; _fx += 280) {
        draw_sprite(sDungeon_TileFloor_Large, 0, _fx, _fy);
    }
}

// Strip Pembatas Lantai Atas
for (var _sx = _x1 + 160; _sx <= _x2; _sx += 320) {
    draw_sprite(sDungeon_TileFloor_Strip, 0, _sx, _y1 + 88);
}

// 3. Dinding Batu Purba Utara (Floor 1 Brick & Arch Walls)
for (var _wx = _x1 + 110; _wx <= _x2; _wx += 238) {
    draw_sprite(sDungeon_Wall_Brick, 0, _wx, _y1 + 50);
}
// Lengkungan Kubah Kuno di Dinding Utara Tengah
draw_sprite(sDungeon_Wall_Arch, 0, _cx, _y1 + 52);

// Bayangan gelap di bawah dinding
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(_x1, _y1 + 90, _x2, _y1 + 105, false);
draw_set_alpha(1.0);

// 4. Pilar-Pillar Sudut & Pilar Batu Kuno (Stone Pillars)
draw_sprite(sDungeon_Pillar_Corner, 0, _x1 + 55, _y1 + 60);
draw_sprite(sDungeon_Pillar_Corner, 0, _x2 - 55, _y1 + 60);
draw_sprite(sDungeon_Pillar_Corner, 0, _x1 + 55, _y2 - 60);
draw_sprite(sDungeon_Pillar_Corner, 0, _x2 - 55, _y2 - 60);

// Pilar Lorong Tengah
draw_sprite(sDungeon_Pillar_Stone, 0, 340, 240);
draw_sprite(sDungeon_Pillar_Stone, 0, 940, 240);
draw_sprite(sDungeon_Pillar_Stone, 0, 340, 480);
draw_sprite(sDungeon_Pillar_Stone, 0, 940, 480);

// 5. Rantai Dinding Besi (Wall Chains)
draw_sprite(sDungeon_Decor_WallChain, 0, 280, _y1 + 75);
draw_sprite(sDungeon_Decor_WallChain, 0, 1000, _y1 + 75);

// 6. Obor Dinding & Kobaran Jiwa Api Biru Mistis (Wall Torches & Soul Flames)
var _draw_soul_torch = function(_tx, _ty) {
    // Obor Braket Besi
    draw_sprite(sDungeon_Decor_WallTorch, 0, _tx, _ty);
    
    // Pendaran Cahaya Biru Mistis
    var _glow = 0.75 + sin(torch_blue_flame + _tx) * 0.25;
    draw_set_alpha(0.22 * _glow);
    draw_set_color(make_color_rgb(70, 170, 255));
    draw_circle(_tx, _ty - 25, 48, false);
    draw_set_alpha(1.0);
    
    // Kobaran Jiwa Api Biru (Soul Flame)
    var _fscale = 0.65 + sin(torch_blue_flame * 1.5 + _tx) * 0.08;
    draw_sprite_ext(sDungeon_Magic_SoulFlame, 0, _tx, _ty - 26, _fscale, _fscale, 0, c_white, 0.95);
};

_draw_soul_torch(160, _y1 + 45);
_draw_soul_torch(440, _y1 + 45);
_draw_soul_torch(_cx, _y1 + 45);
_draw_soul_torch(840, _y1 + 45);
_draw_soul_torch(1120, _y1 + 45);

// 7. Sarkofagus Agung & Altar Ritual (Grand Sarcophagi & Ritual Altar)
draw_sprite(sDungeon_Prop_GrandSarcophagus, 0, 200, 195);
draw_sprite(sDungeon_Prop_GrandSarcophagus, 0, 1080, 195);
draw_sprite(sDungeon_Prop_Sarcophagus, 0, 200, 430);
draw_sprite(sDungeon_Prop_Sarcophagus, 0, 1080, 430);
draw_sprite(sDungeon_Prop_RitualAltar, 0, 240, 310);

// 8. Tungku Pembakaran Besi (Iron Braziers)
var _draw_brazier = function(_bx, _by) {
    draw_sprite(sDungeon_Prop_BrazierIron, 0, _bx, _by);
    var _glow = 0.8 + sin(torch_blue_flame * 2 + _bx) * 0.2;
    draw_set_alpha(0.25 * _glow);
    draw_set_color(make_color_rgb(255, 140, 50));
    draw_circle(_bx, _by - 25, 36, false);
    draw_set_alpha(1.0);
    draw_sprite_ext(sDungeon_Magic_SoulFlame, 0, _bx, _by - 28, 0.55, 0.55, 0, make_color_rgb(255, 180, 80), 0.9);
};

_draw_brazier(520, 240);
_draw_brazier(760, 240);

// 9. Runic Circle di Lantai (Magic Rune Blue)
var _rune_alpha = 0.5 + sin(torch_blue_flame * 0.8) * 0.25;
draw_sprite_ext(sDungeon_Magic_RuneBlue, 0, _cx, 580, 0.9, 0.9, 0, c_white, _rune_alpha);

// =========================================================================
// 10. RENDER JEBAKAN DURI LANTAI (FLOOR SPIKE TRAPS)
// =========================================================================
var _spikes_active = (spike_cycle >= 70 && spike_cycle <= 125);
var _spikes_warning = (spike_cycle >= 50 && spike_cycle < 70);

var _spike_mid_x = (spike_x1 + spike_x2) / 2;
var _spike_mid_y = (spike_y1 + spike_y2) / 2;

if (_spikes_active) {
    draw_sprite_ext(sDungeon_Trap_SpikesUp, 0, _spike_mid_x, _spike_mid_y, 1.25, 0.9, 0, c_white, 1.0);
    // Kilau Merah Bahaya Duri Terhunus
    draw_set_alpha(0.35);
    draw_set_color(make_color_rgb(255, 60, 60));
    draw_circle(_spike_mid_x, _spike_mid_y, 50, false);
    draw_set_alpha(1.0);
} else {
    draw_sprite_ext(sDungeon_Trap_SpikesDown, 0, _spike_mid_x, _spike_mid_y, 1.35, 0.9, 0, c_white, 1.0);
    if (_spikes_warning) {
        var _shake_x = irandom_range(-2, 2);
        draw_set_alpha(0.4);
        draw_set_color(make_color_rgb(255, 200, 60));
        draw_circle(_spike_mid_x + _shake_x, _spike_mid_y, 35, false);
        draw_set_alpha(1.0);
    }
}

// =========================================================================
// 11. RENDER TUAS SAKLAR DINDING BARAT (SWITCH)
// =========================================================================
draw_set_color(make_color_rgb(38, 42, 55));
draw_roundrect_ext(switch_x - 14, switch_y - 20, switch_x + 14, switch_y + 20, 6, 6, false);
draw_set_color(make_color_rgb(90, 110, 150));
draw_roundrect_ext(switch_x - 14, switch_y - 20, switch_x + 14, switch_y + 20, 6, 6, true);

// Permata Runic Indikator
draw_set_color(gate_opened ? make_color_rgb(80, 255, 130) : make_color_rgb(255, 60, 60));
draw_circle(switch_x, switch_y - 10, 4, false);

if (gate_opened) {
    draw_set_color(make_color_rgb(180, 190, 210));
    draw_line_width(switch_x, switch_y, switch_x + 8, switch_y + 12, 4);
    draw_circle(switch_x + 8, switch_y + 12, 5, false);
} else {
    draw_set_color(make_color_rgb(210, 215, 230));
    draw_line_width(switch_x, switch_y, switch_x - 8, switch_y - 12, 4);
    draw_circle(switch_x - 8, switch_y - 12, 5, false);
    
    if (instance_exists(oPlayer) && point_distance(oPlayer.x, oPlayer.y, switch_x, switch_y) < 42) {
        draw_set_color(make_color_rgb(255, 230, 120));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(switch_x, switch_y - 26, "[Z] Tarik Tuas Gerbang");
    }
}

// =========================================================================
// 12. RENDER GERBANG JERUJI BESI (PORTCULLIS GATE)
// =========================================================================
if (!gate_opened) {
    draw_sprite_ext(sDungeon_Gate_Portcullis, 0, _cx, gate_y, 0.95, 0.9, 0, c_white, 1.0);
    
    if (instance_exists(oPlayer) && point_distance(oPlayer.x, oPlayer.y, _cx, gate_y) < 55) {
        draw_set_color(make_color_rgb(255, 130, 130));
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(_cx, gate_y - 45, "⚠ Jeruji Terkunci (Cari Tuas di Lorong Barat)");
    }
} else {
    // Alur Bekas Jeruji Turun ke Lantai
    draw_set_color(make_color_rgb(25, 28, 38));
    draw_rectangle(gate_x1 - 4, gate_y - 2, gate_x2 + 4, gate_y + 4, false);
    draw_set_color(make_color_rgb(70, 80, 100));
    draw_rectangle(gate_x1 - 4, gate_y - 2, gate_x2 + 4, gate_y + 4, true);
}

// =========================================================================
// 13. GERBANG GOTIK FORGOTTEN SANCTUM (SOUTH GOTHIC GATE)
// =========================================================================
var _gtx = _cx;
var _gty = _y2 - 35;
draw_sprite_ext(sDungeon_Gate_Gothic, 0, _gtx, _gty, 0.95, 0.85, 0, c_white, 1.0);

draw_set_color(make_color_rgb(255, 120, 120));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_gtx, _gty - 80, "☠ GERBANG FORGOTTEN SANCTUM");

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
