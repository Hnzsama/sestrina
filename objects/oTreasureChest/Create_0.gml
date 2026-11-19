/// @description Inisialisasi Peti Harta Karun Mana Seed

event_inherited();
is_open = false;
image_speed = 0;
image_index = 0;
prompt_text = "[Z] Buka Peti";
interact_range = 36;
chest_reward = "potion";

// Identitas unik peti berdasarkan ruangan dan koordinat
chest_id = "chest_" + room_get_name(room) + "_" + string(round(x)) + "_" + string(round(y));

if (variable_global_exists("opened_chests") && is_array(global.opened_chests)) {
    for (var _i = 0; _i < array_length(global.opened_chests); _i++) {
        if (global.opened_chests[_i] == chest_id) {
            is_open = true;
            image_index = 1;
            prompt_text = "Peti Terbuka";
            break;
        }
    }
}

interact_action = function() {
    if (is_open) exit;
    is_open = true;
    image_index = 1; // Wood chest open
    
    // Catat ke daftar peti terbuka
    if (variable_global_exists("opened_chests") && is_array(global.opened_chests)) {
        array_push(global.opened_chests, chest_id);
    }
    
    // Berikan EXP pembukaan peti
    scr_add_exp(25);
    
    // Drop Gold & Hadiah Bahan Tempa
    var _g = instance_create_depth(x - 8, y + 8, depth - 10, oItemDrop);
    _g.item_type = "gold";
    _g.item_amount = 45;
    
    var _c = instance_create_depth(x + 8, y + 8, depth - 10, oItemDrop);
    _c.item_type = "magic_crystal";
    _c.item_amount = 1;

    // Drop Material Tempa Terjamin (Mempermudah Pacing Progresi UAS)
    var _m1 = instance_create_depth(x - 12, y + 14, depth - 10, oItemDrop);
    _m1.item_type = "iron_ore";
    _m1.item_amount = 2;

    var _m2 = instance_create_depth(x + 12, y + 14, depth - 10, oItemDrop);
    _m2.item_type = "scrap_iron";
    _m2.item_amount = 4;
    
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
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.banner_title = "PETI KUNO DIBUKA!";
        oRoomTransition.banner_subtitle = "Bahan Tempa Besi Diperoleh! Siap tempa pedang Tier 2 di Goran.";
        oRoomTransition.banner_timer = 180;
    }
};
