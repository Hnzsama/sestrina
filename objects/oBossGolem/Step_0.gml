/// @description Step Event - Boss Golem AI & Serangan Gempa

event_inherited();

if (global.dialogue_active || !instance_exists(oPlayer)) exit;

stomp_timer--;
if (stomp_timer <= 0) {
    stomp_timer = 150;
    is_stomping = true;
    stomp_shockwave_r = 10;
}

if (is_stomping) {
    stomp_shockwave_r += 4;
    
    // Cek terkena pemain
    if (instance_exists(oPlayer)) {
        var _pdist = point_distance(x, y, oPlayer.x, oPlayer.y);
        if (abs(_pdist - stomp_shockwave_r) < 14 && oPlayer.invincible_timer <= 0) {
            global.player_hp = max(0, global.player_hp - 18);
        }
    }
    
    if (stomp_shockwave_r > 120) {
        is_stomping = false;
    }
}
