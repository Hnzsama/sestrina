function scr_player_input() {
    keyLeft   = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    keyRight  = keyboard_check(vk_right) || keyboard_check(ord("D"));
    keyDown   = keyboard_check(vk_down)  || keyboard_check(ord("S"));
    keyUp     = keyboard_check(vk_up)    || keyboard_check(ord("W"));
    keyActive = keyboard_check_pressed(vk_space);
    keyAttack = keyboard_check_pressed(ord("Z"));
    keyItem   = keyboard_check_pressed(ord("C"));
    keyCancel = keyboard_check_pressed(ord("X"));
	keySkip   = keyboard_check_pressed(vk_alt);

    inputDirection = point_direction(0, 0, keyRight - keyLeft, keyDown - keyUp);
    inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);
}