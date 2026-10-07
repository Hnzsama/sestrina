function scr_animation_update() {
    if (!variable_instance_exists(id, "inputMagnitude")) exit;

    if (inputMagnitude) {
        if (keyRight && !keyLeft) facingDir = "right";
        else if (keyLeft && !keyRight) facingDir = "left";
        else if (keyDown && !keyUp) facingDir = "down";
        else if (keyUp && !keyDown) facingDir = "up";

        switch (facingDir) {
            case "down":  sprite_index = sprites.down; image_xscale = 1;  break;
            case "up":    sprite_index = sprites.up;   image_xscale = 1;  break;
            case "left":  sprite_index = sprites.side; image_xscale = -1; break;
            case "right": sprite_index = sprites.side; image_xscale = 1;  break;
        }
        image_speed = 1;
    } else {
        image_speed = 0;
        image_index = 0;
    }
}