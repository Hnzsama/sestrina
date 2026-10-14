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
        lock_prompt_timer = 30;
        // Blokir dan dorong mundur pemain agar tidak melewati pintu terkunci
        if (instance_exists(oPlayer)) {
            if (y > 500) {
                oPlayer.y = min(oPlayer.y, y - door_h / 2 - 8);
            } else if (y < 200) {
                oPlayer.y = max(oPlayer.y, y + door_h / 2 + 8);
            }
        }
    } else {
        // Trigger transisi
        var _trans = noone;
        if (instance_exists(oRoomTransition)) {
            _trans = instance_find(oRoomTransition, 0);
        } else {
            _trans = instance_create_depth(0, 0, -10000, oRoomTransition);
        }
        _trans.start_transition(target_room, target_x, target_y, door_title, door_subtitle);
    }
}
