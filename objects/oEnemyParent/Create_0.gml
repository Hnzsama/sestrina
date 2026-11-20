/// @description Inisialisasi Enemy Parent (Dungeon Floor 1 Animation & Combat)

hp = 25;
max_hp = 25;
enemy_name = "Monster";
move_speed = 1.0;
attack_power = 8;
attack_cooldown = 0;
flash_timer = 0;
anim_timer = 0;
is_boss = false;

// Sistem Animasi Sprite Multi-Frame
state = "idle"; // "idle", "walk", "attack", "hurt", "die"
base_xscale = 1.0;
base_yscale = 1.0;
spr_idle = noone;
spr_walk = noone;
spr_attack = noone;
spr_hurt = noone;
spr_die = noone;

state_timer = 0;
attack_timer = 0;
hurt_timer = 0;
die_timer = 0;
is_dead = false;

depth = -100;

exp_reward = 15;
gold_reward = 8;

/// @function take_damage(dmg, dir, [is_melee])
take_damage = function(_dmg, _dir, _is_melee = false) {
    if (is_dead) exit;
    
    hp -= _dmg;
    flash_timer = 8;
    
    // Knockback
    x += lengthdir_x(10, _dir);
    y += lengthdir_y(10, _dir);
    
    if (hp <= 0) {
        is_dead = true;
        state = "die";
        die_timer = 32;
        if (spr_die != noone) {
            sprite_index = spr_die;
            image_index = 0;
            image_speed = 0.22;
        }
    } else {
        state = "hurt";
        hurt_timer = 14;
        if (spr_hurt != noone) {
            sprite_index = spr_hurt;
            image_index = 0;
            image_speed = 0.25;
        }
    }
};

/// @function on_death()
on_death = function() {
    // Berikan EXP ke pemain
    scr_add_exp(exp_reward);
    
    // Drop Gold
    var _gdrop = instance_create_depth(x + irandom_range(-6, 6), y + irandom_range(-6, 6), depth - 10, oItemDrop);
    _gdrop.item_type = "gold";
    _gdrop.item_amount = max(1, irandom_range(gold_reward - 3, gold_reward + 4));
    
    // Potion drop chance (20%)
    if (irandom(100) < 20) {
        var _pdrop = instance_create_depth(x + irandom_range(-8, 8), y + irandom_range(-8, 8), depth - 10, oItemDrop);
        _pdrop.item_type = "potion";
        _pdrop.item_amount = 1;
    }
    
    // Drop material spesifik musuh
    drop_custom_loot();
    
    instance_destroy();
};

drop_custom_loot = function() {
    // Override oleh musuh turunan
};
