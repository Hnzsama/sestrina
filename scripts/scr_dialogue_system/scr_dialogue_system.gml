/// @description Sistem Manajemen Dialog & Story untuk Sestrina
/// Menyediakan API pembentukan struktur dialog, potret 2D VN, dan callback event

global.dialogue_active = false;
global.current_dialogue = noone;

/// @function dialogue_create()
/// @description Membuat instance struct dialog baru
function dialogue_create() {
    var _dialogue = {
        lines: [],
        on_finish: noone,
        
        /// @function add(speaker, text, [left_portrait], [right_portrait], [side_active])
        add: function(_speaker, _text, _left_portrait = noone, _right_portrait = noone, _side_active = "left") {
            array_push(lines, {
                speaker: _speaker,
                text: _text,
                left_portrait: _left_portrait,
                right_portrait: _right_portrait,
                side_active: _side_active
            });
            return self;
        },
        
        /// @function start([on_finish_callback])
        start: function(_callback = noone) {
            on_finish = _callback;
            global.current_dialogue = self;
            global.dialogue_active = true;
            
            var _mgr = noone;
            if (instance_exists(oDialogueManager)) {
                _mgr = instance_find(oDialogueManager, 0);
            } else {
                _mgr = instance_create_depth(0, 0, -9999, oDialogueManager);
            }
            _mgr.start_dialogue(self);
        }
    };
    
    return _dialogue;
}
