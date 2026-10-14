/// @description Inisialisasi Room Transition & Global HUD Manager

transition_state = "idle"; // "idle", "fade_out", "fade_in"
fade_alpha = 0.0;
target_room = noone;
target_x = 0;
target_y = 0;
banner_title = "Kamar Tidur Kastil";
banner_subtitle = "Tempat peristirahatan Sestrina";
banner_timer = 140;

depth = -10000;

/// @function start_transition(room, x, y, title, subtitle)
start_transition = function(_room, _x, _y, _title, _subtitle = "") {
    if (transition_state != "idle") return;
    target_room = _room;
    target_x = _x;
    target_y = _y;
    banner_title = _title;
    banner_subtitle = _subtitle;
    transition_state = "fade_out";
};
