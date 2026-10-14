/// @description Inisialisasi Peti Harta Karun Mana Seed

event_inherited();
is_open = false;
image_speed = 0;
image_index = 0;
prompt_text = "[E] Buka Peti";
interact_range = 36;
chest_reward = "potion";

interact_action = function() {
    if (is_open) exit;
    is_open = true;
    image_index = 1; // Wood chest open
    
    // Berikan EXP pembukaan peti
    scr_add_exp(15);
    
    // Drop beberapa item dari peti
    var _g = instance_create_depth(x - 8, y + 8, depth - 10, oItemDrop);
    _g.item_type = "gold";
    _g.item_amount = 35;
    
    var _c = instance_create_depth(x + 8, y + 8, depth - 10, oItemDrop);
    _c.item_type = "magic_crystal";
    _c.item_amount = 1;
    
    if (chest_reward == "potion") {
        var _p = instance_create_depth(x, y + 12, depth - 10, oItemDrop);
        _p.item_type = "potion";
        _p.item_amount = 1;
        prompt_text = "Peti Terbuka (+Hadiah)";
    } else {
        var _i = instance_create_depth(x, y + 12, depth - 10, oItemDrop);
        _i.item_type = "iron_ore";
        _i.item_amount = 2;
        prompt_text = "Peti Terbuka (+Material)";
    }
};
