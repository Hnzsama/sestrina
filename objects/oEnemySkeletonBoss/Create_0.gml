/// @description Inisialisasi Mini-Boss: Panglima Tengkorak (Skeleton Warlord)
event_inherited();

sprite_index = sEnemySkeleton;
image_speed = 0.14;
image_xscale = 2.0;
image_yscale = 2.0;

max_hp = 220;
hp = 220;
enemy_name = "Panglima Tengkorak";
move_speed = 1.35;
attack_power = 20;
is_boss = true;

exp_reward = 180;
gold_reward = 60;

slam_timer = 120;

drop_custom_loot = function() {
    // Menjatuhkan Kunci Ruang Boss
    global.has_boss_key = true;
    
    // Hadiah material langka
    var _c1 = instance_create_depth(x - 12, y, depth - 10, oItemDrop);
    _c1.item_type = "magic_crystal";
    _c1.item_amount = 2;
    
    var _c2 = instance_create_depth(x + 12, y, depth - 10, oItemDrop);
    _c2.item_type = "iron_ore";
    _c2.item_amount = 4;
    
    var _c3 = instance_create_depth(x, y + 10, depth - 10, oItemDrop);
    _c3.item_type = "bone_shard";
    _c3.item_amount = 5;
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.banner_title = "KUNCI RUANG BOSS DIDAPATKAN!";
        oRoomTransition.banner_subtitle = "Panglima Tengkorak Terkalahkan! Pintu Boss Terbuka.";
        oRoomTransition.banner_timer = 180;
    }
    scr_set_quest(4, "Kalahkan Boss Golem Purba", "Gunakan Kunci Boss untuk masuk ke Boss Chamber");
};
