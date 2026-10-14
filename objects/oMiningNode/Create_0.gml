/// @description Inisialisasi Nodus Tambang Bijih
event_inherited();

interact_range = 42;
prompt_text = "[E] Tambang Bijih (3x)";
prompt_y_offset = -32;

ore_type = "iron_ore"; // "iron_ore" atau "magic_crystal"
if (room == rm_catacombs && x < 600) {
    ore_type = "magic_crystal";
    prompt_text = "[E] Tambang Kristal (3x)";
}

hits_left = 3;
is_depleted = false;
shake_timer = 0;

interact_action = function() {
    if (is_depleted) return;
    
    hits_left--;
    shake_timer = 8;
    
    // Drop item sesuai jenis nodus
    var _drop = instance_create_depth(x + irandom_range(-12, 12), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _drop.item_type = ore_type;
    _drop.item_amount = 1;
    
    // Bonus EXP eksplorasi
    scr_add_exp(5);
    
    if (hits_left <= 0) {
        is_depleted = true;
        prompt_text = "Habis Ditambang";
    } else {
        prompt_text = "[E] Tambang (" + string(hits_left) + "x)";
    }
};
