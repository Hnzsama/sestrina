/// @description Inisialisasi Interactable Parent

interact_range = 36;
auto_trigger_range = 0; // Set > 0 untuk auto-trigger ketika player mendekat
has_auto_triggered = false;
is_player_near = false;
prompt_text = "[E] Bicara";
prompt_y_offset = -28;
prompt_anim = 0;

/// @function interact_action()
interact_action = function() {
    // Override oleh object turunan / event
};
