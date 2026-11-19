/// @description End Step Event oPlayer - Smooth Dynamic Camera Tracking

if (!view_enabled) {
    view_enabled = true;
    view_visible[0] = true;
}

var _cam = view_camera[0];
if (_cam == -1) {
    _cam = camera_create_view(0, 0, 1280, 720, 0, noone, -1, -1, -1, -1);
    view_camera[0] = _cam;
}

var _cam_vw = 1280;
var _cam_vh = 720;
camera_set_view_size(_cam, _cam_vw, _cam_vh);

// Target posisi kamera terpusat pada pemain, terkunci dalam batas ukuran ruangan
var _target_cam_x = clamp(x - _cam_vw / 2, 0, max(0, room_width - _cam_vw));
var _target_cam_y = clamp(y - _cam_vh / 2, 0, max(0, room_height - _cam_vh));

var _cur_cam_x = camera_get_view_x(_cam);
var _cur_cam_y = camera_get_view_y(_cam);

// Smooth gliding follow (responsif 0.18 lerp)
var _new_cam_x = lerp(_cur_cam_x, _target_cam_x, 0.18);
var _new_cam_y = lerp(_cur_cam_y, _target_cam_y, 0.18);

// Dukungan Screen Shake (jika oRoomTransition memicu getaran layar)
if (instance_exists(oRoomTransition)) {
    if (variable_instance_exists(oRoomTransition, "screen_shake") && oRoomTransition.screen_shake > 0) {
        _new_cam_x += random_range(-oRoomTransition.screen_shake, oRoomTransition.screen_shake);
        _new_cam_y += random_range(-oRoomTransition.screen_shake, oRoomTransition.screen_shake);
        oRoomTransition.screen_shake = max(0, oRoomTransition.screen_shake - 0.4);
    }
}

camera_set_view_pos(_cam, _new_cam_x, _new_cam_y);
