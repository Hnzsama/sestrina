function scr_movement_apply() {
    hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
    vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

    x += hSpeed;
    y += vSpeed;
}