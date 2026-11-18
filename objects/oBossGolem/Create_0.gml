/// @description Inisialisasi Boss Pertarungan Golem & Plot Twist True Guardian

event_inherited();
sprite_index = sBossGolem;
image_speed = 0.08;

// =========================================================================
// 1. TAHAPAN BOS & STATUS (Stage 1: Stone Golem, Stage 2: True Guardian Spirit)
// =========================================================================
boss_stage = 1; // 1: Stone Golem, 2: The True Guardian (Roh Penjaga Purba)
max_hp = 350;
hp = 350;
is_boss = true;
enemy_name = "Ancient Stone Golem";
move_speed = 0.65;
attack_power = 20;
exp_reward = 500;
anim_timer = 0;

// =========================================================================
// 2. SISTEM RUNIC ANTI-MAGIC BARRIER (Anti-Spam Bola Api / Fireball)
// =========================================================================
runic_barrier = true;         // Aktif secara default di Stage 1
barrier_max_hp = 3;           // Butuh 3 tebasan pedang melee untuk memecahkan perisai
barrier_hp = 3;
barrier_break_timer = 0;      // Durasi perisai pecah sebelum regenerasi
barrier_reflect_flash = 0;
barrier_pulse = 0;

// =========================================================================
// 3. MEKANIK SERANGAN TAHAP 1 (Batu Raksasa & Hentakan Gempa)
// =========================================================================
stomp_timer = 120;
stomp_shockwave_r = 0;
is_stomping = false;
is_staggered = false;
stagger_timer = 0;

boulder_timer = 85;           // Serangan lemparan batu balasan jarak jauh
boulders = [];                // Array objek batu terbang { xx, yy, vx, vy, radius, life, rot }
falling_rocks = [];           // Runtuhan batu langit-langit kuil

// =========================================================================
// 4. MEKANIK TAHAP 2 (PLOT TWIST: THE TRUE GUARDIAN SPIRIT)
// =========================================================================
is_plot_twisting = false;
twist_dialogue_done = false;

phantom_swords = [];          // Pedang roh meluncur { xx, yy, vx, vy, ang, life }
sword_barrage_timer = 90;
teleport_timer = 140;
spirit_pulse_timer = 160;
spirit_pulse_r = 0;
spirit_aura_anim = 0;
shadow_trail = [];

depth = -150;

/// @function take_damage(dmg, dir, [is_melee])
take_damage = function(_dmg, _dir, _is_melee = false) {
    if (is_plot_twisting) exit; // Kebal saat adegan transisi plot twist
    
    // ---------------------------------------------------------------------
    // LOGIKA DAMAGE TAHAP 1: ANCIENT STONE GOLEM
    // ---------------------------------------------------------------------
    if (boss_stage == 1) {
        if (runic_barrier) {
            if (!_is_melee) {
                // SERANGAN SIHIR (FIREBALL / FROST) DITANGKIS SEUTUHNYA!
                barrier_reflect_flash = 14;
                if (instance_exists(oRoomTransition)) {
                    oRoomTransition.banner_title = "SIHIR DITEPAK! (BARRIER AKTIF)";
                    oRoomTransition.banner_subtitle = "Golem kebal sihir jarak jauh! Maju dan tebas dengan PEDANG MELEE!";
                    oRoomTransition.banner_timer = 80;
                    oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 3);
                }
                // Balas lempar batu seketika jika pemain mencoba camping jarak jauh
                boulder_timer = min(boulder_timer, 15);
                exit;
            } else {
                // SERANGAN PEDANG MELEE MERETAKKAN BARRIER!
                barrier_hp--;
                flash_timer = 8;
                hp -= round(_dmg * 0.7); // Armor batu meredam sebagian damage melee
                
                if (barrier_hp <= 0) {
                    runic_barrier = false;
                    barrier_break_timer = 240; // Terbuka selama 4 detik!
                    is_staggered = true;
                    stagger_timer = 120;       // 2 detik stun window
                    if (instance_exists(oRoomTransition)) {
                        oRoomTransition.banner_title = "BARRIER RUNIC PECAH!";
                        oRoomTransition.banner_subtitle = "Golem Terhuyung! Sekarang saatnya gunakan kombo pedang & sihir!";
                        oRoomTransition.banner_timer = 150;
                        oRoomTransition.screen_shake = 12;
                    }
                }
            }
        } else {
            // SAAT BARRIER PECAH: DAMAGE GANDA!
            var _final_dmg = round(_dmg * 1.5);
            hp -= _final_dmg;
            flash_timer = 8;
        }
        
        // Pemicu Plot Twist saat HP Golem Habis
        if (hp <= 0) {
            trigger_plot_twist();
            exit;
        }
    }
    // ---------------------------------------------------------------------
    // LOGIKA DAMAGE TAHAP 2: THE TRUE GUARDIAN SPIRIT
    // ---------------------------------------------------------------------
    else if (boss_stage == 2) {
        if (!_is_melee) {
            // Kena sihir di Tahap 2: Roh berkedip dan sesekali teleport ke belakang pemain
            hp -= _dmg;
            flash_timer = 8;
            if (instance_exists(oPlayer) && irandom(100) < 60) {
                var _p_dir = variable_instance_exists(oPlayer, "inputDirection") ? oPlayer.inputDirection : 270;
                var _tx = oPlayer.x - lengthdir_x(52, _p_dir);
                var _ty = oPlayer.y - lengthdir_y(52, _p_dir);
                if (!scr_check_collision(_tx, _ty)) {
                    x = _tx;
                    y = _ty;
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 4;
                }
            }
        } else {
            // Tebasan pedang memberikan damage stabil
            hp -= round(_dmg * 1.2);
            flash_timer = 8;
        }
        
        if (hp <= 0) {
            on_true_death();
        }
    }
};

/// @function trigger_plot_twist()
/// @description Memicu cutscene plot twist saat golem batu hancur
trigger_plot_twist = function() {
    is_plot_twisting = true;
    hp = 0;
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.screen_shake = 20;
    }
    
    // Dialog Plot Twist Spektakuler
    var _d = dialogue_create();
    _d.add("Protagonis", "Hancur sudah cangkang batunya...! Tapi... di mana The Lost Remedy?! Altar kuil ini kosong?!", "protagonist", "sestrina", "left", "exclamation")
      .add("Suara Misterius", "Hahaha... Manusia malang. Kau tertipu oleh dongeng palsu para tetua Altdorf...", "guardian", "protagonist", "right", "dots")
      .add("Protagonis", "Suara itu... Dari balik kepulan debu kuil... Siapa kau?!", "protagonist", "sestrina", "left", "question")
      .add("Roh Penjaga Kuil", "Penyakit kebocoran mana adikmu, Sestrina... BUKAN kutukan acak! Sestrina adalah wadah reinkarnasi dari Segel Jiwa Kuil Purba ini!", "guardian", "protagonist", "right", "exclamation")
      .add("Roh Penjaga Kuil", "Golem batu tadi bukanlah musuhmu... melainkan PENAHAN (SEAL CONTAINER) agar roh kutukan ini tidak melahap jiwa adikmu!", "guardian", "protagonist", "right", "dots")
      .add("Roh Penjaga Kuil", "Dengan menghancurkan golem tadi demi egomu, kau justru MEMBEBASKAN rohku! Sekarang, jiwa adikmu akan kutarik untuk membangkitkan tubuh abadiku!", "guardian", "protagonist", "right", "exclamation")
      .add("Protagonis", "TIDAK AKAN KUBIARKAN KAU MENYENTUH SESTRINA!! AKU AKAN MEMURNIKAN ROH BUSUKMU SEKALIPUN HARUS MEMBAKAR JIWAKU SENDIRI!!", "protagonist", "sestrina", "left", "exclamation");
      
    _d.start(function() {
        with (oBossGolem) {
            boss_stage = 2;
            max_hp = 320;
            hp = 320;
            enemy_name = "The Corrupted Guardian Spirit";
            move_speed = 1.65;
            is_plot_twisting = false;
            runic_barrier = false;
            
            if (instance_exists(oRoomTransition)) {
                oRoomTransition.banner_title = "PLOT TWIST: ROH TERKUTUK BANGKIT!";
                oRoomTransition.banner_subtitle = "Kalahkan wujud sejati Guardian untuk memurnikan Inti Jiwa adikmu!";
                oRoomTransition.banner_timer = 240;
                oRoomTransition.screen_shake = 18;
            }
        }
    });
};

/// @function on_true_death()
/// @description Penyelesaian pertarungan sejati setelah Roh Penjaga dimurnikan
on_true_death = function() {
    scr_add_exp(exp_reward);
    global.quest_stage = 4;
    global.quest_title = "Bawa The Lost Remedy ke Sestrina";
    global.quest_desc = "Gunakan portal suci Forgotten Sanctum untuk kembali ke kamar Sestrina";
    global.player_has_remedy = true;
    
    // Buka Portal Suci Forgotten Sanctum
    if (instance_exists(oDoor)) {
        with (oDoor) {
            required_quest_stage = 0;
            door_title = "Portal Suci Forgotten Sanctum";
            door_subtitle = "Kembali ke Kamar Sestrina membawa The Lost Remedy";
        }
    }
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.banner_title = "THE LOST REMEDY BERHASIL DIMURNIKAN!";
        oRoomTransition.banner_subtitle = "Inti Jiwa Suci diperoleh! Segera kembali sebelum nafas adikmu habis!";
        oRoomTransition.banner_timer = 240;
        oRoomTransition.screen_shake = 12;
    }
    
    instance_destroy();
};
