function scr_animation_update() {
    if (!variable_instance_exists(id, "inputMagnitude")) exit;

    var _sc = variable_instance_exists(id, "char_scale") ? char_scale : 1.35;
    image_yscale = _sc;

    // A. Penanganan Khusus Karakter Utama (oPlayer)
    if (object_index == oPlayer) {
        // Jangan timpa sprite jika sedang melakukan aksi tempur/keahlian khusus
        if (is_rolling || is_attacking > 0 || is_casting > 0 || is_drinking > 0) {
            exit;
        }

        if (inputMagnitude) {
            if (keyRight && !keyLeft) facingDir = "right";
            else if (keyLeft && !keyRight) facingDir = "left";
            else if (keyDown && !keyUp) facingDir = "down";
            else if (keyUp && !keyDown) facingDir = "up";

            switch (facingDir) {
                case "down":  sprite_index = spr_walk.down; image_xscale = _sc;  break;
                case "up":    sprite_index = spr_walk.up;   image_xscale = _sc;  break;
                case "left":  sprite_index = spr_walk.side; image_xscale = _sc;  break; // Asli sprite menghadap kiri
                case "right": sprite_index = spr_walk.side; image_xscale = -_sc; break; // Mirror horizontal agar menghadap kanan
            }
            image_speed = 1.0;
        } else {
            // Animasi Bernapas / Idle Bergerak Halus (5 FPS)
            switch (facingDir) {
                case "down":  sprite_index = spr_idle.down; image_xscale = _sc;  break;
                case "up":    sprite_index = spr_idle.up;   image_xscale = _sc;  break;
                case "left":  sprite_index = spr_idle.side; image_xscale = _sc;  break; // Asli sprite menghadap kiri
                case "right": sprite_index = spr_idle.side; image_xscale = -_sc; break; // Mirror horizontal agar menghadap kanan
            }
            image_speed = 0.8;
        }
        exit;
    }

    // B. Penanganan Standar untuk NPC Lainnya
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