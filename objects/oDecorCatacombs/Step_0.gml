/// @description Step Event - Animasi Api, Siklus Duri Lantai, dan Logika Tuas Gerbang

torch_blue_flame += 0.08;
drip_timer += 0.05;

// =========================================================================
// 1. LOGIKA JEBAKAN DURI LANTAI (FLOOR SPIKES)
// =========================================================================
spike_cycle = (spike_cycle + 1) mod spike_max_cycle;
var _spikes_active = (spike_cycle >= 70 && spike_cycle <= 125);

if (_spikes_active && instance_exists(oPlayer)) {
    var _px = oPlayer.x;
    var _py = oPlayer.y;
    
    // Cek apakah pemain menginjak area jebakan duri
    if (_px >= spike_x1 && _px <= spike_x2 && _py >= spike_y1 && _py <= spike_y2) {
        // JIKA PEMAIN MELAKUKAN DODGE ROLL -> KEBAL (i-frames traversal & Perfect Dodge!)
        if (variable_instance_exists(oPlayer, "is_rolling") && oPlayer.is_rolling) {
            with (oPlayer) {
                scr_player_trigger_perfect_dodge(x, y);
            }
        } else if (oPlayer.invincible_timer <= 0) {
            // Terkena tusukan duri lantai
            global.player_hp = max(0, global.player_hp - 14);
            oPlayer.invincible_timer = 32;
            
            // Dorong pemain mundur sedikit dari duri
            if (_py > (spike_y1 + spike_y2) / 2) {
                oPlayer.y += 10;
            } else {
                oPlayer.y -= 10;
            }
            
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 6);
            }
        }
    }
}

// =========================================================================
// 2. LOGIKA TUAS SAKLAR & JERUJI BESI (GATE & LEVER PUZZLE)
// =========================================================================
if (instance_exists(oPlayer)) {
    var _px = oPlayer.x;
    var _py = oPlayer.y;
    
    // Interaksi dengan Tuas di Dinding Barat
    if (!gate_opened) {
        var _dist_switch = point_distance(_px, _py, switch_x, switch_y);
        if (_dist_switch < 42 && (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) && !global.dialogue_active) {
            gate_opened = true;
            global.catacombs_gate_opened = true;
            scr_play_sfx(snd_lever_switch, 0.04, 1.0, 13);
            scr_play_sfx(snd_gate_open, 0.06, 0.95, 12);
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "GERBANG JERUJI TERBUKA!";
                oRoomTransition.banner_subtitle = "Tuas kuno berderit... Jeruji besi menuju sarang Panglima turun!";
                oRoomTransition.banner_timer = 180;
                oRoomTransition.screen_shake = 8;
            }
        }
        
        // Blokir pemain agar tidak menembus Jeruji Besi saat gerbang tertutup
        if (_px >= gate_x1 - 10 && _px <= gate_x2 + 10 && _py >= gate_y - 12 && _py <= gate_y + 18) {
            oPlayer.y = min(oPlayer.y, gate_y - 14);
            if (instance_exists(oRoomTransition) && oRoomTransition.banner_timer <= 0) {
                oRoomTransition.banner_title = "JERUJI BESI TERKUNCI";
                oRoomTransition.banner_subtitle = "Tarik tuas saklar di ceruk dinding barat untuk membuka jalan!";
                oRoomTransition.banner_timer = 80;
            }
        }
    }
}
