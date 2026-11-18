/// @description Step Event Dialogue Manager (VN Controls & Text Engine)

// Hitung mundur cooldown
if (variable_global_exists("dialogue_cooldown") && global.dialogue_cooldown > 0) {
    global.dialogue_cooldown--;
}

if (current_dialogue == noone || !global.dialogue_active) exit;

blink_timer += 0.05;

// Animate Emotion Bubble Pop (Reference: reactionbubble.png)
emote_timer += 0.08;
if (emote_scale < 1.0) {
    emote_scale = min(1.0, emote_scale + 0.12);
}

// Toggle Hide UI [H]
if (keyboard_check_pressed(ord("H"))) {
    ui_hidden = !ui_hidden;
}

// Toggle Auto Advance [A]
if (keyboard_check_pressed(ord("A"))) {
    auto_mode = !auto_mode;
    auto_timer = 0;
}

var _lines = current_dialogue.lines;
if (current_line_index >= array_length(_lines)) {
    next_line();
    exit;
}

var _line = _lines[current_line_index];
var _full_text = _line.text;
var _text_len = string_length(_full_text);

// Fast Forward / Skip [Ctrl / Tab] (Reference: fast forward icon)
var _is_skipping = keyboard_check(vk_control) || keyboard_check(vk_tab);
var _current_speed = _is_skipping ? 4.0 : char_speed;

// Typewriter effect
if (char_index < _text_len) {
    char_index += _current_speed;
    if (char_index >= _text_len) {
        char_index = _text_len;
        is_finished_typing = true;
    }
} else {
    is_finished_typing = true;
}

// Auto Advance Handler
if (auto_mode && is_finished_typing) {
    auto_timer++;
    if (auto_timer > 55) { // Tunggu ~0.9 detik sebelum lanjut otomatis
        auto_timer = 0;
        next_line();
        exit;
    }
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

// Input handling (Space, E, Enter, Z, Klik Kiri)
var _key_advance = keyboard_check_pressed(vk_space) || 
                   keyboard_check_pressed(ord("E")) || 
                   keyboard_check_pressed(vk_enter) || 
                   keyboard_check_pressed(ord("Z")) ||
                   mouse_check_button_pressed(mb_left);

if (_key_advance) {
    if (ui_hidden) {
        ui_hidden = false;
    } else if (!is_finished_typing) {
        char_index = _text_len;
        is_finished_typing = true;
    } else {
        next_line();
    }
}
