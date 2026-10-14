/// @description Step Event - AI Mini-Boss Serangan Hantaman
event_inherited();

if (global.dialogue_active || !instance_exists(oPlayer)) exit;

slam_timer--;
if (slam_timer <= 0) {
    slam_timer = 150;
    // Hantaman gempa area saat pemain dekat
    var _dist = point_distance(x, y, oPlayer.x, oPlayer.y);
    if (_dist < 80 && oPlayer.invincible_timer <= 0) {
        global.player_hp = max(0, global.player_hp - 16);
        with (oPlayer) {
            var _kdir = point_direction(other.x, other.y, x, y);
            x += lengthdir_x(14, _kdir);
            y += lengthdir_y(14, _kdir);
        }
    }
}
