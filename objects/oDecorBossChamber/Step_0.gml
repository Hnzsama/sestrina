/// @description Step Event Animasi Boss Chamber & Trigger Portal Suci Altar
rune_glow += 0.05;
flame_anim += 0.08;
portal_anim += 0.04;

// Trigger Portal Suci ke Kamar Sestrina (Altar Singgasana x: 640, y: 215)
var _boss_defeated = (variable_global_exists("player_has_remedy") && global.player_has_remedy) || !instance_exists(oBossGolem);
if (_boss_defeated && instance_exists(oPlayer)) {
    var _dist_portal = point_distance(oPlayer.x, oPlayer.y, 640, 215);
    if (_dist_portal < 80) {
        var _key_enter = keyboard_check_pressed(ord("E")) || 
                         keyboard_check_pressed(ord("Z")) || 
                         keyboard_check_pressed(vk_space) || 
                         keyboard_check_pressed(vk_enter);
        if (_key_enter) {
            if (instance_exists(oRoomTransition)) {
                var _tr = instance_find(oRoomTransition, 0);
                if (_tr.transition_state == "idle") {
                    _tr.start_transition(Room1, 345, 225, "Kamar Tidur Sestrina", "Kembali Membawa The Lost Remedy");
                }
            } else {
                room_goto(Room1);
            }
        }
    }
}
