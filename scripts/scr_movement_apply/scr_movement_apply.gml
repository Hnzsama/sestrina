/// @description Pergerakan Karakter Pemain dengan Sistem Tabrakan Dinding Presisi 1280x720 Widescreen

function scr_check_collision(_x, _y) {
    var _rname = room_get_name(room);
    
    // =========================================================================
    // 1. CEK COLLISION RUANGAN: ROOM1 (KAMAR SESTRINA - WORKSHOP ASSETS 1280x720)
    // =========================================================================
    if (_rname == "Room1") {
        // Pintu Keluar ke Altdorf (Selatan di x: 580..700)
        if (_x >= 580 && _x <= 700 && _y >= 620) {
            return false;
        }

        // Batas Dinding Luar
        if (_y < 165) return true;
        if (_x < 200) return true;
        if (_x > 1080) return true;
        if (_y > 645 && (_x < 580 || _x > 700)) return true;

        // Perabotan Sesuai Tata Letak Kamar
        // 1. Ranjang Sestrina & Nakas Lilin (Sayap Barat)
        if (_x >= 210 && _x <= 320 && _y >= 165 && _y <= 275) return true;
        // 2. Peti & Pot Ujung Ranjang (Barat Daya)
        if (_x >= 210 && _x <= 315 && _y >= 285 && _y <= 340) return true;
        // 3. Meja Belajar Besar, Kursi & Globe (Tengah)
        if (_x >= 575 && _x <= 705 && _y >= 195 && _y <= 315) return true;
        // 4. Lemari Alat & Ramuan (Apothecary Cabinet)
        if (_x >= 745 && _x <= 850 && _y >= 130 && _y <= 255) return true;
        // 5. Tong Kayu & Peti Gudang (Timur Laut)
        if (_x >= 855 && _x <= 1000 && _y >= 140 && _y <= 220) return true;
        // 6. Peti Harta & Tanaman Hias (Tenggara)
        if (_x >= 915 && _x <= 1070 && _y >= 490 && _y <= 560) return true;

        if (instance_exists(oSolidParent) && place_meeting(_x, _y, oSolidParent)) return true;
        return false;
    }

    // =========================================================================
    // 2. CEK COLLISION RUANGAN: RM_TOWN_SQUARE (KOTA ALTDORF 2560x1440)
    // =========================================================================
    if (_rname == "rm_town_square") {
        // Pintu & Jalur Transisi Bebas Tabrakan
        if (_x >= 1220 && _x <= 1340 && _y <= 130) return false;        // Utara (Ke Rumah Sestrina)
        if (_x >= 1220 && _x <= 1340 && _y >= 1350) return false;       // Selatan (Gerbang ke Kuil Purba)
        if (_x >= 490 && _x <= 550 && _y >= 350 && _y <= 410) return false; // Pintu Toko Goran
        if (_x >= 2010 && _x <= 2070 && _y >= 350 && _y <= 410) return false; // Pintu Apotek Elysia

        // Batas Luar Peta Kota
        if (_x < 80 || _x > 2480 || _y < 80 || _y > 1390) return true;

        // Tepi Sungai Timur (x >= 2340), kecuali jembatan/dermaga nelayan di y: 960..1060
        if (_x >= 2340) {
            if (!(_y >= 960 && _y <= 1060 && _x <= 2440)) {
                return true;
            }
        }

        // Air Mancur Pusat Kota (Plaza Center x: 1280, y: 720)
        if (point_distance(_x, _y, 1280, 720) < 64) return true;

        // Menara Gerbang Utara & Selatan (Menara kiri & kanan, jalan tengah bebas!)
        if ((_x >= 1170 && _x <= 1235 && _y <= 125) || (_x >= 1325 && _x <= 1390 && _y <= 125)) return true;
        if ((_x >= 1150 && _x <= 1235 && _y >= 1340) || (_x >= 1325 && _x <= 1410 && _y >= 1340)) return true;

        // Bangunan Distrik Pengrajin Barat Laut
        if (_x >= 450 && _x <= 585 && _y >= 220 && _y <= 375) return true; // Toko & Bengkel Goran
        if (_x >= 310 && _x <= 445 && _y >= 270 && _y <= 365) return true; // Tungku & Peralatan Tempa Goran
        if (_x >= 75 && _x <= 210 && _y >= 160 && _y <= 315) return true; // Rumah Tukang Kayu Atas
        if (_x >= 75 && _x <= 210 && _y >= 440 && _y <= 595) return true; // Rumah Tukang Kayu Bawah
        if (_x >= 690 && _x <= 835 && _y >= 140 && _y <= 295) return true; // Rumah Deret Utara 1
        if (_x >= 860 && _x <= 1005 && _y >= 140 && _y <= 295) return true; // Rumah Deret Utara 2
        if (_x >= 1030 && _x <= 1175 && _y >= 140 && _y <= 295) return true; // Rumah Deret Utara 3

        // Bangunan Distrik Alkemis & Cendekiawan Timur Laut
        if (_x >= 1450 && _x <= 1595 && _y >= 140 && _y <= 295) return true; // Rumah Deret Timur 1
        if (_x >= 1620 && _x <= 1765 && _y >= 140 && _y <= 295) return true; // Rumah Deret Timur 2
        if (_x >= 1790 && _x <= 1935 && _y >= 140 && _y <= 295) return true; // Rumah Deret Timur 3
        if (_x >= 1970 && _x <= 2110 && _y >= 220 && _y <= 375) return true; // Apotek Elysia
        if (_x >= 2110 && _x <= 2210 && _y >= 280 && _y <= 365) return true; // Meja Racik Alkimia Luar

        // Kebun Botani Kota (Jalan setapak tengah x: 1805..1875 bebas dilewati Lily & Pemain!)
        if (_x >= 1660 && _x <= 2020 && _y >= 460 && _y <= 600) {
            if (!(_x >= 1805 && _x <= 1875)) return true;
        }

        // Kios-Kios Bazaar Pasar Barat (Lorong tengah y: 560..630 & jalan barat x: 480..560 bebas!)
        if (_x >= 610 && _x <= 890 && _y >= 495 && _y <= 555) return true; // Kios Atas
        if (_x >= 610 && _x <= 890 && _y >= 635 && _y <= 695) return true; // Kios Bawah

        // Kedai Luar Ruangan & Bar Barat Daya
        if (_x >= 190 && _x <= 345 && _y >= 940 && _y <= 1260) return true;
        if (point_distance(_x, _y, 380, 1010) < 16) return true;
        if (point_distance(_x, _y, 440, 1010) < 16) return true;

        // Sumur Batu Desa Tenggara
        if (point_distance(_x, _y, 1500, 950) < 22) return true;

        // Kompleks Rumah Distrik Pemukiman Tenggara (Atas: y: 750..905, Bawah: y: 1010..1165, Jalan Tengah Bebas!)
        if (_x >= 1640 && _x <= 2260 && _y >= 750 && _y <= 905) return true;
        if (_x >= 1640 && _x <= 2260 && _y >= 1010 && _y <= 1165) return true;

        // Papan Pengumuman Guild
        if (_x >= 1130 && _x <= 1180 && _y >= 610 && _y <= 660) return true;

        // Kolam Taman Timur Laut (Jembatan kayu di x: 1450..1490 bebas diseberangi!)
        if (_x >= 1380 && _x <= 1560 && _y >= 490 && _y <= 630) {
            if (!(_x >= 1448 && _x <= 1492)) return true;
        }
        // Kolam Taman Barat Daya
        if (_x >= 1000 && _x <= 1180 && _y >= 800 && _y <= 930) return true;

        // Bangku Kayu Taman Seating Plaza
        if (_x >= 1406 && _x <= 1454 && _y >= 822 && _y <= 838) return true;
        if (_x >= 1486 && _x <= 1534 && _y >= 822 && _y <= 838) return true;
        if (_x >= 1406 && _x <= 1454 && _y >= 902 && _y <= 918) return true;
        if (_x >= 1486 && _x <= 1534 && _y >= 902 && _y <= 918) return true;

        if (instance_exists(oSolidParent) && place_meeting(_x, _y, oSolidParent)) return true;
        return false;
    }

    // =========================================================================
    // 3. CEK COLLISION RUANGAN TOKO & DUNGEON (1280x720 Widescreen Standard)
    // =========================================================================
    var _gx1 = 60;
    var _gy1 = 40;
    var _gx2 = 1220;
    var _gy2 = 680;

    // Cek Area Pintu Keluar
    var _is_door = false;
    if (_rname == "rm_weapon_shop" || _rname == "rm_potion_shop" || _rname == "rm_boss_chamber") {
        if (_x >= 600 && _x <= 680 && _y >= _gy2 - 25) _is_door = true;
    } else if (_rname == "rm_outskirts" || _rname == "rm_catacombs" || _rname == "rm_dungeon_floor2") {
        if (_x >= 570 && _x <= 710 && _y <= _gy1 + 55) _is_door = true;
        if (_x >= 570 && _x <= 710 && _y >= _gy2 - 40) _is_door = true;
    }

    if (_is_door) return false;

    // Batas Dinding Luar 1280x720
    if (_x < _gx1 + 16 || _x > _gx2 - 16 || _y < _gy1 + 45 || _y > _gy2 - 16) {
        return true;
    }

    // Halangan Khusus Toko & Dungeon
    if (_rname == "rm_weapon_shop") {
        if (_y < _gy1 + 75) return true; // Dinding Utara & Tungku Api
        if (_y < 288 && _y > 255 && _x >= 500 && _x <= 780) return true; // Meja Kasir Goran
        if (_x < _gx1 + 50 && _y > 320 && _y < 510) return true; // Lemari Senjata Barat
        if (_x > _gx2 - 50 && _y > 320 && _y < 510) return true; // Meja Display Timur
    } else if (_rname == "rm_potion_shop") {
        if (_y < _gy1 + 75) return true; // Dinding Utara
        if (_y < 288 && _y > 255 && _x >= 500 && _x <= 780) return true; // Meja Kasir Elysia
        if (_x < _gx1 + 50 && _y > 320 && _y < 480) return true; // Meja Riset Grimoire Barat
        if (_x > _gx2 - 50 && _y > 320 && _y < 480) return true; // Lemari Terrarium Timur
    } else if (_rname == "rm_outskirts") {
        if (_x < _gx1 + 35 || _x > _gx2 - 35) return true; // Pohon Tebing Tepi
    } else if (_rname == "rm_catacombs") {
        // Batas Dinding Samping Lurus & Dinding Batu Purba
        if (_x < 110 || _x > 1170) return true;
        if (_y < 125 && !(_x >= 580 && _x <= 700)) return true;
        if (_y > 635 && !(_x >= 580 && _x <= 700)) return true;
        
        // 4 Pilar Kolonade Utama (Colonnade Pillars)
        if (point_distance(_x, _y, 380, 260) < 24) return true;
        if (point_distance(_x, _y, 900, 260) < 24) return true;
        if (point_distance(_x, _y, 380, 450) < 24) return true;
        if (point_distance(_x, _y, 900, 450) < 24) return true;
        
        // Sayap Barat: Makam Sarkofagus & Peti Kayu
        if (_x >= 165 && _x <= 315 && _y >= 210 && _y <= 265) return true;
        
        // Sayap Timur: Batu Runic Monolit
        if (_x >= 1030 && _x <= 1135 && _y >= 205 && _y <= 265) return true;
        
        // Patung Penjaga Gerbang Selatan
        if (point_distance(_x, _y, 500, 630) < 20) return true;
        if (point_distance(_x, _y, 780, 630) < 20) return true;
    } else if (_rname == "rm_dungeon_floor2") {
        // Batas Dinding Samping Masif & Dinding Stalaktit
        if (_x < 110 || _x > 1170) return true;
        if (_y < 125 && !(_x >= 580 && _x <= 700)) return true;
        if (_y > 635 && !(_x >= 580 && _x <= 700)) return true;
        
        // 4 Pilar Kayu Tambang & Lentera (Mine Timber Hoists)
        if (point_distance(_x, _y, 380, 260) < 24) return true;
        if (point_distance(_x, _y, 900, 260) < 24) return true;
        if (point_distance(_x, _y, 380, 460) < 24) return true;
        if (point_distance(_x, _y, 900, 460) < 24) return true;
        
        // Sayap Barat: Gerobak Tambang Kristal & Rel
        if (_x >= 180 && _x <= 320 && _y >= 210 && _y <= 275) return true;
        
        // Sayap Timur: Batu Runic Monolit
        if (_x >= 1030 && _x <= 1135 && _y >= 205 && _y <= 265) return true;
        
        // Gargoyle Penjaga Gerbang Bos
        if (point_distance(_x, _y, 500, 630) < 20) return true;
        if (point_distance(_x, _y, 780, 630) < 20) return true;
    } else if (_rname == "rm_boss_chamber") {
        if (point_distance(_x, _y, 640, 360) < 36) return true; // Pedestal Altar
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

/// @description Trigger Mekanik Perfect Dodge Ksatria saat Berhasil Menghindar Serangan
function scr_player_trigger_perfect_dodge(_hazard_x, _hazard_y) {
    if (!instance_exists(oPlayer)) return;
    
    with (oPlayer) {
        // Mencegah trigger dobel jika baru saja memicu perfect dodge
        if (perfect_dodge_cooldown > 0) return;
        
        perfect_dodge_cooldown = 45;       // Jeda sebelum bisa perfect dodge lagi
        perfect_dodge_timer = 24;          // Durasi visual state perfect dodge
        perfect_dodge_flash = 12;          // Flash putih-emas karakter
        perfect_dodge_ring_rad = 10;       // Radius awal gelombang kejut
        perfect_dodge_ring_alpha = 1.0;    // Alpha lingkaran kejut
        perfect_dodge_text_alpha = 1.0;    // Teks mengambang "PERFECT DODGE!"
        perfect_dodge_text_y = y - 38;
        
        // 1. Invincibility diperpanjang agar terbebas dari combo serangan musuh
        invincible_timer = max(invincible_timer, 28);
        
        // 2. Gameplay Reward: Refund Stamina Roll + Bonus +10 Stamina!
        global.player_stamina = min(global.player_max_stamina, global.player_stamina + 35);
        
        // 3. Gameplay Reward: Counter-Attack Boost (+50% Damage & Bilah Emas)
        counter_boost_active = true;
        counter_boost_timer = 120; // 2 detik durasi buff serangan balasan
        
        // 4. Hitstop Effect: Freeze mikro 4 frame dramatis & Audio SFX
        hitstop_timer = 4;
        scr_play_sfx(snd_perfect_dodge, 0.04, 1.15, 15);
        scr_play_sfx(snd_sword_parry, 0.06, 0.9, 14);
        
        // 5. Screen Shake halus yang tegas
        if (instance_exists(oRoomTransition)) {
            oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 4);
        }
        
        // 6. Spawn burst partikel percikan bintang emas & cyan
        for (var _p = 0; _p < 14; _p++) {
            var _ang = random(360);
            var _spd = random_range(2.5, 6.5);
            array_push(perfect_sparks, {
                xx: x,
                yy: y - 16,
                vx: lengthdir_x(_spd, _ang),
                vy: lengthdir_y(_spd, _ang),
                alpha: 1.0,
                size: random_range(2.2, 4.2),
                col: choose(make_color_rgb(255, 230, 90), make_color_rgb(130, 240, 255), c_white)
            });
        }
        
        // 7. Ubah seluruh ghost trail aktif menjadi emas berkilau
        for (var _g = 0; _g < array_length(ghost_trail); _g++) {
            ghost_trail[_g].col = make_color_rgb(255, 225, 90);
        }
    }
}

/// @function scr_check_collision_point(x, y)
/// @description Alias global ke scr_check_collision untuk objek NPC dan entitas dinamis
function scr_check_collision_point(_x, _y) {
    return scr_check_collision(_x, _y);
}
