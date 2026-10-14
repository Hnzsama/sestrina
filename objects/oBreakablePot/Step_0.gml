/// @description Deteksi Serangan Pedang Pemain

if (!is_broken && instance_exists(oPlayerSlash)) {
    var _slash = instance_nearest(x, y, oPlayerSlash);
    if (_slash != noone && point_distance(x, y, _slash.x, _slash.y) < 32) {
        is_broken = true;
        image_index = 3; // Pecahan guci di tanah
        solid = false;
        
        // Pulihkan stamina pemain sebagai reward eksplorasi
        global.player_stamina = min(global.player_max_stamina, global.player_stamina + 20);
        scr_add_exp(3);
        
        // Drop loot dari guci
        var _drop = instance_create_depth(x, y, depth - 10, oItemDrop);
        var _roll = irandom(100);
        if (_roll < 60) {
            _drop.item_type = "gold";
            _drop.item_amount = irandom_range(4, 10);
        } else if (_roll < 85) {
            _drop.item_type = "scrap_iron";
            _drop.item_amount = 1;
        } else {
            _drop.item_type = "potion";
            _drop.item_amount = 1;
        }
    }
}
