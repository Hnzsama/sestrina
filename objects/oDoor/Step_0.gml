/// @description Step Event - Cek Trigger Pintu

glow_anim += 0.06;

if (lock_prompt_timer > 0) lock_prompt_timer--;

if (!instance_exists(oPlayer) || global.dialogue_active) exit;

if (instance_exists(oRoomTransition)) {
    var _tr = instance_find(oRoomTransition, 0);
    if (_tr.transition_state != "idle") exit;
}

var _px = oPlayer.x;
var _py = oPlayer.y;

var _is_locked = false;
if (required_quest_stage > 0 && global.quest_stage < required_quest_stage) {
    _is_locked = true;
}
if (variable_instance_exists(id, "required_weapon_tier") && global.weapon_tier < required_weapon_tier) {
    _is_locked = true;
}
if (variable_instance_exists(id, "required_boss_key") && required_boss_key && !global.has_boss_key) {
    _is_locked = true;
}

var _touching = point_in_rectangle(_px, _py, x - door_w / 2, y - door_h / 2, x + door_w / 2, y + door_h / 2);

if (_touching) {
    if (_is_locked) {
        if (lock_prompt_timer <= 0 && instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "PINTU TERKUNCI";
            oRoomTransition.banner_subtitle = locked_message;
            oRoomTransition.banner_timer = 100;
            scr_play_ui("cancel");
        }
        lock_prompt_timer = 40;
        // Blokir dan dorong mundur pemain agar tidak melewati pintu terkunci
        if (instance_exists(oPlayer)) {
            if (y > 500) {
                oPlayer.y = min(oPlayer.y, y - door_h / 2 - 8);
            } else if (y < 200) {
                oPlayer.y = max(oPlayer.y, y + door_h / 2 + 8);
            }
        }
    } else {
        // Trigger Konfirmasi Batas Area (Reference: leaving area option.png)
        if (variable_global_exists("leave_confirm_active")) {
            if (!global.leave_confirm_active) {
                global.leave_confirm_active = true;
                global.leave_confirm_target_room = target_room;
                global.leave_confirm_target_x = target_x;
                global.leave_confirm_target_y = target_y;
                global.leave_confirm_area_name = door_title;
                global.leave_confirm_subtitle = door_subtitle;
                global.leave_confirm_selection = 0;
                
                // Geser mundur posisi pemain sedikit agar tidak menempel trigger
                if (instance_exists(oPlayer)) {
                    if (y > 500) oPlayer.y -= 16;
                    else if (y < 200) oPlayer.y += 16;
                    else if (x > 640) oPlayer.x -= 16;
                    else oPlayer.x += 16;
                }
            }
        } else {
            var _trans = instance_exists(oRoomTransition) ? instance_find(oRoomTransition, 0) : instance_create_depth(0, 0, -10000, oRoomTransition);
            _trans.start_transition(target_room, target_x, target_y, door_title, door_subtitle);
        }
    }
}
