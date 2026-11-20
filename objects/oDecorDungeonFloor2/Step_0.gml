/// @description Step Event Animasi & Bahaya Floor 2
flame_anim += 0.05;
spike_cycle = (spike_cycle + 1) mod 180;

// Bahaya Jebakan Duri di Koordinat (640, 360)
var _spikes_active = (spike_cycle >= 70 && spike_cycle <= 125);
if (_spikes_active && instance_exists(oPlayer)) {
    var _dist = point_distance(oPlayer.x, oPlayer.y, 640, 360);
    if (_dist < 42) {
        with (oPlayer) {
            if (variable_instance_exists(id, "perfect_dodge_cooldown") && perfect_dodge_cooldown <= 0) {
                if (variable_instance_exists(id, "is_rolling") && is_rolling) {
                    scr_player_trigger_perfect_dodge(640, 360);
                } else {
                    scr_player_take_damage(12, point_direction(640, 360, x, y));
                }
            }
        }
    }
}
