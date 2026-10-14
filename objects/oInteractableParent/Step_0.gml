/// @description Step event oInteractableParent

prompt_anim += 0.08;

if (!instance_exists(oPlayer)) {
    is_player_near = false;
    exit;
}

var _dist = distance_to_object(oPlayer);
is_player_near = (_dist <= interact_range);

// Jangan trigger jika dialog aktif atau masih dalam cooldown selesai dialog
if (global.dialogue_active) exit;
if (variable_global_exists("dialogue_cooldown") && global.dialogue_cooldown > 0) exit;

// Auto-trigger jika player mendekat ke area sensitif
if (auto_trigger_range > 0 && !has_auto_triggered && _dist <= auto_trigger_range) {
    has_auto_triggered = true;
    interact_action();
    exit;
}

// Manual trigger dengan tombol E atau Space
if (is_player_near) {
    if (keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space)) {
        interact_action();
    }
}
