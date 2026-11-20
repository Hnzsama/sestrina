/// @description Inisialisasi Dialogue Manager & Screen Config (VN Hybrid Engine)

current_dialogue = noone;
current_line_index = 0;
char_index = 0;
char_speed = 0.8; // Kecepatan ketik per frame
is_finished_typing = false;
blink_timer = 0;

// Fitur Visual Novel (Reference: importantNPCdialog.png VN controls)
auto_mode = false;
auto_timer = 0;
ui_hidden = false;

global.dialogue_active = false;
global.dialogue_cooldown = 0;

// Set Resolusi GUI ke HD 1280x720 agar luas dan proporsional
display_set_gui_size(1280, 720);

// Animasi & Visual VN
portrait_left_scale = 1.0;
portrait_right_scale = 1.0;
portrait_left_alpha = 0.5;
portrait_right_alpha = 0.5;

// Emotion Bubble Animasi (Reference: reactionbubble.png)
emote_scale = 0.0;
emote_timer = 0;

/// @function start_dialogue(dialogue_struct)
start_dialogue = function(_dialogue) {
    current_dialogue = _dialogue;
    current_line_index = 0;
    char_index = 0;
    is_finished_typing = false;
    auto_mode = false;
    auto_timer = 0;
    ui_hidden = false;
    emote_scale = 0.0;
    emote_timer = 0;
    global.dialogue_active = true;
    global.dialogue_cooldown = 0;
    scr_play_ui("confirm");
};

/// @function next_line()
next_line = function() {
    if (current_dialogue == noone) return;
    
    current_line_index++;
    if (current_line_index >= array_length(current_dialogue.lines)) {
        // Selesai seluruh baris dialog
        scr_play_ui("cancel");
        var _callback = current_dialogue.on_finish;
        current_dialogue = noone;
        current_line_index = 0;
        char_index = 0;
        auto_mode = false;
        ui_hidden = false;
        emote_scale = 0.0;
        emote_timer = 0;
        global.dialogue_active = false;
        global.dialogue_cooldown = 20; // Cooldown 20 frame
        
        if (_callback != noone) {
            _callback();
        }
    } else {
        char_index = 0;
        is_finished_typing = false;
        auto_timer = 0;
        emote_scale = 0.0;
        emote_timer = 0;
        scr_play_ui("move");
    }
};
