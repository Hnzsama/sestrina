/// @description Sistem Progresi Level, EXP, Atribut Stat, dan Kalkulasi Senjata Sestrina

/// @function scr_recalculate_stats()
function scr_recalculate_stats() {
    global.player_max_hp = 80 + (global.stat_vit * 8);
    global.player_max_mp = 40 + (global.stat_int * 8);
    global.player_max_stamina = 80 + (global.stat_agi * 4);
    
    global.player_hp = min(global.player_hp, global.player_max_hp);
    global.player_mp = min(global.player_mp, global.player_max_mp);
    global.player_stamina = min(global.player_stamina, global.player_max_stamina);
}

/// @function scr_add_exp(_amount)
function scr_add_exp(_amount) {
    global.player_exp += _amount;
    
    var _leveled_up = false;
    while (global.player_exp >= global.player_max_exp) {
        global.player_exp -= global.player_max_exp;
        global.player_level += 1;
        global.stat_points += 3;
        global.player_max_exp = round(global.player_max_exp * 1.35 + 25);
        _leveled_up = true;
    }
    
    if (_leveled_up) {
        scr_recalculate_stats();
        global.player_hp = global.player_max_hp;
        global.player_mp = global.player_max_mp;
        global.player_stamina = global.player_max_stamina;
        
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.banner_title = "LEVEL UP! (Lv " + string(global.player_level) + ")";
            oRoomTransition.banner_subtitle = "+3 Stat Points! Buka Menu Status [P]";
            oRoomTransition.banner_timer = 160;
        }
    }
}

/// @function scr_allocate_stat(_stat_name)
function scr_allocate_stat(_stat_name) {
    if (global.stat_points <= 0) return false;
    
    if (_stat_name == "vit") {
        global.stat_vit += 1;
    } else if (_stat_name == "str") {
        global.stat_str += 1;
    } else if (_stat_name == "int") {
        global.stat_int += 1;
    } else if (_stat_name == "agi") {
        global.stat_agi += 1;
    } else {
        return false;
    }
    
    global.stat_points -= 1;
    scr_recalculate_stats();
    return true;
}

/// @function scr_get_player_atk()
function scr_get_player_atk() {
    var _tier = variable_global_exists("weapon_tier") ? global.weapon_tier : 0;
    var _str = variable_global_exists("stat_str") ? global.stat_str : 5;
    var _int = variable_global_exists("stat_int") ? global.stat_int : 5;
    
    switch (_tier) {
        case 0:
            return 6 + round(_str * 0.8);
        case 1:
            return 14 + round(_str * 1.2);
        case 2:
            return 24 + round(_str * 1.5);
        case 3:
            return 38 + round(_str * 1.8);
        case 4:
            return 58 + round(_str * 2.2 + _int * 1.0);
        default:
            return 15;
    }
}

/// @function scr_get_magic_power()
function scr_get_magic_power() {
    var _int = variable_global_exists("stat_int") ? global.stat_int : 5;
    return 22 + round(_int * 2.6);
}
