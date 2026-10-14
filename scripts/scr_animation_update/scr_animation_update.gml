function scr_animation_update() {
    if (!variable_instance_exists(id, "inputMagnitude")) exit;

    var _sc = variable_instance_exists(id, "char_scale") ? char_scale : 1.35;
    image_yscale = _sc;

    if (inputMagnitude) {
        if (keyRight && !keyLeft) facingDir = "right";
        else if (keyLeft && !keyRight) facingDir = "left";
        else if (keyDown && !keyUp) facingDir = "down";
        else if (keyUp && !keyDown) facingDir = "up";

        switch (facingDir) {
            case "down":  sprite_index = sprites.down; image_xscale = _sc;  break;
            case "up":    sprite_index = sprites.up;   image_xscale = _sc;  break;
            case "left":  sprite_index = sprites.side; image_xscale = -_sc; break;
            case "right": sprite_index = sprites.side; image_xscale = _sc;  break;
        }
        image_speed = 1;
    } else {
        image_speed = 0;
        image_index = 0;
        switch (facingDir) {
            case "left":  image_xscale = -_sc; break;
            default:      image_xscale = _sc;  break;
        }
    }
}