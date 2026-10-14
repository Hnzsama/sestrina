/// @description Inisialisasi Dialogue Manager & Screen Config

current_dialogue = noone;
current_line_index = 0;
char_index = 0;
char_speed = 0.8; // Kecepatan ketik per frame
is_finished_typing = false;
blink_timer = 0;

global.dialogue_active = false;
global.dialogue_cooldown = 0;

// Set Resolusi GUI ke HD 1280x720 agar luas dan tidak sesak
display_set_gui_size(1280, 720);

// Animasi & Visual VN
portrait_left_scale = 1.0;
portrait_right_scale = 1.0;
portrait_left_alpha = 0.5;
portrait_right_alpha = 0.5;

/// @function start_dialogue(dialogue_struct)
start_dialogue = function(_dialogue) {
    current_dialogue = _dialogue;
    current_line_index = 0;
    char_index = 0;
    is_finished_typing = false;
    global.dialogue_active = true;
    global.dialogue_cooldown = 0;
};

/// @function next_line()
next_line = function() {
    if (current_dialogue == noone) return;
    
    current_line_index++;
    if (current_line_index >= array_length(current_dialogue.lines)) {
        // Selesai seluruh baris dialog
        var _callback = current_dialogue.on_finish;
        current_dialogue = noone;
        current_line_index = 0;
        char_index = 0;
        global.dialogue_active = false;
        global.dialogue_cooldown = 20; // Cooldown 20 frame agar tombol Space/E tidak memicu dialog ulang instan
        
        if (is_callable(_callback)) {
            _callback();
        } else if (is_method(_callback)) {
            _callback();
        }
    } else {
        char_index = 0;
        is_finished_typing = false;
    }
};
