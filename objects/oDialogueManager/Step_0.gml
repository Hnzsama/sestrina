/// @description Step Event Dialogue Manager

// Hitung mundur cooldown
if (variable_global_exists("dialogue_cooldown") && global.dialogue_cooldown > 0) {
    global.dialogue_cooldown--;
}

if (current_dialogue == noone || !global.dialogue_active) exit;

blink_timer += 0.05;

var _lines = current_dialogue.lines;
if (current_line_index >= array_length(_lines)) {
    next_line();
    exit;
}

var _line = _lines[current_line_index];
var _full_text = _line.text;
var _text_len = string_length(_full_text);

// Typewriter effect
if (char_index < _text_len) {
    char_index += char_speed;
    if (char_index >= _text_len) {
        char_index = _text_len;
        is_finished_typing = true;
    }
} else {
    is_finished_typing = true;
}

// Visual portrait transition smoothly
var _target_left_alpha = (_line.side_active == "left") ? 1.0 : 0.45;
var _target_right_alpha = (_line.side_active == "right") ? 1.0 : 0.45;
var _target_left_scale = (_line.side_active == "left") ? 1.05 : 0.95;
var _target_right_scale = (_line.side_active == "right") ? 1.05 : 0.95;

portrait_left_alpha = lerp(portrait_left_alpha, _target_left_alpha, 0.15);
portrait_right_alpha = lerp(portrait_right_alpha, _target_right_alpha, 0.15);
portrait_left_scale = lerp(portrait_left_scale, _target_left_scale, 0.15);
portrait_right_scale = lerp(portrait_right_scale, _target_right_scale, 0.15);

// Input handling (Space, E, Enter, Z)
var _key_advance = keyboard_check_pressed(vk_space) || 
                   keyboard_check_pressed(ord("E")) || 
                   keyboard_check_pressed(vk_enter) || 
                   keyboard_check_pressed(ord("Z"));

if (_key_advance) {
    if (!is_finished_typing) {
        // Langsung tampilkan teks penuh
        char_index = _text_len;
        is_finished_typing = true;
    } else {
        // Lanjut ke baris dialog berikutnya
        next_line();
    }
}
