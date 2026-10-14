/// @description Pergerakan Karakter Pemain dengan Sistem Tabrakan Dinding Presisi Medieval RPG

function scr_check_collision(_x, _y) {
    var _gx1 = 440;
    var _gy1 = 40;
    var _gx2 = 840;
    var _gy2 = 680;
    
    var _rname = room_get_name(room);
    
    // 1. Cek Apakah Pemain Berada di Area Pintu Keluar
    var _is_door = false;
    if (_rname == "Room1" || _rname == "rm_weapon_shop" || _rname == "rm_potion_shop") {
        if (_x >= 610 && _x <= 670 && _y >= _gy2 - 25) _is_door = true;
    } else if (_rname == "rm_town_square") {
        if (_x >= 615 && _x <= 665 && _y <= 95) _is_door = true;        // Utara (Gerbang Kastil Manor)
        if (_x >= 490 && _x <= 530 && _y <= 170) _is_door = true;       // Pintu Depan Pandai Besi
        if (_x >= 750 && _x <= 790 && _y <= 170) _is_door = true;       // Pintu Depan Apotek
        if (_x >= 615 && _x <= 665 && _y >= _gy2 - 25) _is_door = true; // Selatan (Gerbang Hutan)
    } else if (_rname == "rm_outskirts" || _rname == "rm_catacombs") {
        if (_x >= 580 && _x <= 700 && _y <= _gy1 + 35) _is_door = true;
        if (_x >= 580 && _x <= 700 && _y >= _gy2 - 25) _is_door = true;
    } else if (_rname == "rm_boss_chamber") {
        if (_x >= 610 && _x <= 670 && _y >= _gy2 - 25) _is_door = true;
    }

    if (_is_door) return false;

    // Batas dinding luar 9:16
    if (_x < _gx1 + 16 || _x > _gx2 - 16 || _y < _gy1 + 45 || _y > _gy2 - 16) {
        return true;
    }

    
    // 2. Tabrakan Perabot Khusus Berdasarkan Ruangan
    if (_rname == "Room1") {
        if (_x >= _gx1 + 10 && _x <= _gx1 + 100 && _y >= _gy1 + 8 && _y <= _gy1 + 85) return true;
        if (_x >= _gx1 + 15 && _x <= _gx1 + 130 && _y >= 120 && _y <= 190) return true;
        if (_x >= _gx2 - 105 && _x <= _gx2 - 45 && _y >= 95 && _y <= 175) return true;
        if (_x >= _gx2 - 105 && _x <= _gx2 - 45 && _y >= 215 && _y <= 295) return true;
        if (_x >= _gx2 - 170 && _x <= _gx2 - 120 && _y >= 215 && _y <= 265) return true;
        if (_x >= _gx1 + 15 && _x <= _gx1 + 80 && _y >= 515 && _y <= 590) return true;
        if (_x >= _gx1 + 90 && _x <= _gx1 + 155 && _y >= 530 && _y <= 580) return true;
        if (_x >= _gx2 - 115 && _x <= _gx2 - 15 && _y >= 510 && _y <= 590) return true;
    } else if (_rname == "rm_town_square") {
        if (point_distance(_x, _y, 640, 360) < 46) return true; // Air Mancur Pusat
        if (_x < _gx1 + 130 && _y < 160) return true;            // Gedung Pandai Besi
        if (_x > _gx2 - 130 && _y < 160) return true;            // Gedung Apotek
        if (_x >= _gx1 + 130 && _x <= _gx2 - 130 && _y < 85) return true; // Dinding Kastil Utara
        if (point_distance(_x, _y, 485, 345) < 22) return true; // Pohon Oak Barat
        if (_x >= 488 && _x <= 538 && _y >= 422 && _y <= 468) return true; // Kios Pasar Tradisional
    } else if (_rname == "rm_weapon_shop") {
        if (_y < _gy1 + 75) return true; // Dinding Utara & Tungku Api
        if (_y < 288 && _x >= 515 && _x <= 765) return true; // Meja Kasir Konter Goran
        if (_x < _gx1 + 65 && _y > 330 && _y < 500) return true; // Lemari Senjata Barat
        if (_x > _gx2 - 65 && _y > 330 && _y < 500) return true; // Meja Display Timur
    } else if (_rname == "rm_potion_shop") {
        if (_y < _gy1 + 75) return true; // Dinding Utara
        if (_y < 288 && _x >= 515 && _x <= 765) return true; // Meja Kasir Konter Elysia
        if (_x < _gx1 + 65 && _y > 340 && _y < 460) return true; // Meja Riset Grimoire Barat
        if (_x > _gx2 - 65 && _y > 340 && _y < 460) return true; // Lemari Terrarium Timur
    } else if (_rname == "rm_outskirts") {

        if (_x < _gx1 + 45 || _x > _gx2 - 45) return true; // Pohon Samping
    } else if (_rname == "rm_catacombs") {
        if (_x < _gx1 + 85 && _y > 135 && _y < 265) return true; // Sarkofagus
    } else if (_rname == "rm_boss_chamber") {
        if (point_distance(_x, _y, 640, 360) < 28) return true; // Pedestal Altar
    }

    if (instance_exists(oSolidParent) && place_meeting(_x, _y, oSolidParent)) return true;

    return false;
}

function scr_movement_apply() {
    hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
    vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

    // Cek tabrakan horizontal
    if (scr_check_collision(x + hSpeed, y)) {
        while (!scr_check_collision(x + sign(hSpeed), y)) {
            x += sign(hSpeed);
        }
        hSpeed = 0;
    }
    x += hSpeed;

    // Cek tabrakan vertikal
    if (scr_check_collision(x, y + vSpeed)) {
        while (!scr_check_collision(x, y + sign(vSpeed))) {
            y += sign(vSpeed);
        }
        vSpeed = 0;
    }
    y += vSpeed;
}