/// @description Room Start Event oPlayer - Instant Snap Camera to Player

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

// Snap instan posisi kamera ke pemain saat masuk ruangan baru (mencegah black screen atau lag lerp dari (0,0))
var _snap_x = clamp(x - _cam_vw / 2, 0, max(0, room_width - _cam_vw));
var _snap_y = clamp(y - _cam_vh / 2, 0, max(0, room_height - _cam_vh));
camera_set_view_pos(_cam, _snap_x, _snap_y);
