/// @description Inisialisasi Dark Crystal Overlord & True Corrupted Guardian

event_inherited();
sprite_index = sBoss_Overlord_Idle;
image_speed = 0.12;

// =========================================================================
// 1. STATUS & TAHAPAN BOS (Phase 1: Dark Crystal Overlord, Phase 2: True Corrupted Form)
// =========================================================================
boss_stage = 1;
max_hp = 380;
hp = 380;
is_boss = true;
enemy_name = "Dark Crystal Overlord";
move_speed = 0.85;
attack_power = 22;
exp_reward = 800;
anim_timer = 0;
depth = -150;

// State Machine
STATE_IDLE = 0;
STATE_CHASE = 1;
STATE_MAGIC = 2;
STATE_MELEE = 3;
STATE_METEOR = 4;
STATE_SUMMON = 5;
STATE_HURT = 6;
STATE_DEATH = 7;

state = STATE_IDLE;
state_timer = 60;
facing = 1;

// =========================================================================
// 2. SISTEM RUNIC ANTI-MAGIC BARRIER (Anti-Spam Sihir Jarak Jauh)
// =========================================================================
runic_barrier = true;         // Aktif secara default di Tahap 1
barrier_max_hp = 3;           // Butuh 3 tebasan pedang melee untuk memecahkan perisai
barrier_hp = 3;
barrier_break_timer = 0;      // Durasi perisai pecah sebelum regenerasi
barrier_reflect_flash = 0;
barrier_pulse = 0;
is_staggered = false;
stagger_timer = 0;

// =========================================================================
// 3. MEKANIK SERANGAN TAHAP 1 (Dark Magic Blast, Scythe Slash, Meteor Strike)
// =========================================================================
magic_timer = 90;
melee_cooldown = 0;
meteor_timer = 160;

magic_orbs = [];              // Peluru sihir gelap { xx, yy, vx, vy, radius, life }
meteors = [];                 // Panggilan meteor langit { xx, yy, target_y, radius, timer, impact }
scythe_active = false;

// =========================================================================
// 4. MEKANIK TAHAP 2 (PLOT TWIST: THE TRUE CORRUPTED GUARDIAN)
// =========================================================================
is_plot_twisting = false;
twist_dialogue_done = false;
twist_timer = 0;

phantom_swords = [];          // Pedang roh meluncur { xx, yy, vx, vy, ang, life }
sword_barrage_timer = 80;
teleport_timer = 130;
spirit_pulse_timer = 150;
spirit_pulse_r = 0;
spirit_aura_anim = 0;
shadow_trail = [];

/// @function take_damage(dmg, dir, [is_melee])
take_damage = function(_dmg, _dir, _is_melee = false) {
    if (is_plot_twisting) exit; // Kebal saat adegan transisi plot twist
    if (state == STATE_DEATH) exit;
    
    // ---------------------------------------------------------------------
    // LOGIKA DAMAGE TAHAP 1: DARK CRYSTAL OVERLORD
    // ---------------------------------------------------------------------
    if (boss_stage == 1) {
        if (runic_barrier) {
            if (!_is_melee) {
                // SERANGAN SIHIR (FIREBALL / FROST) DITANGKIS SEUTUHNYA!
                barrier_reflect_flash = 14;
                if (instance_exists(oRoomTransition)) {
                    oRoomTransition.banner_title = "SIHIR DITEPAK! (BARRIER AKTIF)";
                    oRoomTransition.banner_subtitle = "Overlord kebal sihir jarak jauh! Maju dan tebas dengan PEDANG MELEE!";
                    oRoomTransition.banner_timer = 80;
                    oRoomTransition.screen_shake = max(oRoomTransition.screen_shake, 3);
                }
                // Balas serang cepat jika pemain mencoba camping jarak jauh
                magic_timer = min(magic_timer, 15);
                exit;
            } else {
                // SERANGAN PEDANG MELEE MERETAKKAN BARRIER!
                barrier_hp--;
                flash_timer = 8;
                hp -= round(_dmg * 0.75);
                
                if (barrier_hp <= 0) {
                    runic_barrier = false;
                    barrier_break_timer = 240; // Terbuka selama 4 detik!
                    is_staggered = true;
                    stagger_timer = 120;       // 2 detik stun window
                    state = STATE_HURT;
                    state_timer = 40;
                    sprite_index = sBoss_Overlord_Hurt;
                    if (instance_exists(oRoomTransition)) {
                        oRoomTransition.banner_title = "BARRIER OVERLORD PECAH!";
                        oRoomTransition.banner_subtitle = "Overlord Terhuyung! Sekarang saatnya kombo tebasan & sihir!";
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
        
        // Pemicu Plot Twist saat HP Bos Habis
        if (hp <= 0) {
            trigger_plot_twist();
            exit;
        }
    }
    // ---------------------------------------------------------------------
    // LOGIKA DAMAGE TAHAP 2: THE TRUE CORRUPTED GUARDIAN
    // ---------------------------------------------------------------------
    else if (boss_stage == 2) {
        if (!_is_melee) {
            hp -= _dmg;
            flash_timer = 8;
            if (instance_exists(oPlayer) && irandom(100) < 50) {
                // Teleportasi berkedip menjauh / mendekat
                var _p_dir = variable_instance_exists(oPlayer, "inputDirection") ? oPlayer.inputDirection : 270;
                var _tx = oPlayer.x - lengthdir_x(60, _p_dir);
                var _ty = oPlayer.y - lengthdir_y(60, _p_dir);
                if (!scr_check_collision(_tx, _ty)) {
                    x = _tx;
                    y = _ty;
                    if (instance_exists(oRoomTransition)) oRoomTransition.screen_shake = 4;
                }
            }
        } else {
            hp -= round(_dmg * 1.25);
            flash_timer = 8;
        }
        
        if (hp <= 0) {
            on_true_death();
        }
    }
};

/// @function start_phase_2()
/// @description Memulai Fase 2: Wujud Sejati True Corrupted Overlord
start_phase_2 = function() {
    if (boss_stage == 2) exit;
    boss_stage = 2;
    max_hp = 350;
    hp = 350;
    enemy_name = "True Corrupted Overlord";
    move_speed = 1.6;
    is_plot_twisting = false;
    runic_barrier = false;
    is_staggered = false;
    stagger_timer = 0;
    flash_timer = 0;
    image_blend = c_white;
    sprite_index = sBoss_Overlord_Walk;
    image_speed = 0.15;
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.banner_title = "PLOT TWIST: ROH TERKUTUK BANGKIT!";
        oRoomTransition.banner_subtitle = "Kalahkan wujud sejati Overlord untuk memurnikan The Lost Remedy!";
        oRoomTransition.banner_timer = 240;
        oRoomTransition.screen_shake = 20;
    }
};

/// @function trigger_plot_twist()
/// @description Memicu cutscene plot twist saat Dark Crystal Overlord hancur
trigger_plot_twist = function() {
    if (is_plot_twisting || boss_stage == 2) exit;
    is_plot_twisting = true;
    hp = 0;
    flash_timer = 0;
    is_staggered = false;
    stagger_timer = 0;
    twist_timer = 0;
    state = STATE_IDLE;
    sprite_index = sBoss_Overlord_Skill_Summon;
    image_speed = 0.12;
    image_blend = c_white;
    
    if (instance_exists(oRoomTransition)) {
        oRoomTransition.screen_shake = 22;
    }
    
    // Dialog Plot Twist Spektakuler (Pertarungan Bos - Tanpa Karakter Anime Sestrina/Protagonis)
    var _d = dialogue_create();
    _d.add("Protagonis", "Hancur sudah cangkang kegelapannya...! Tapi... di mana The Lost Remedy?! Altar singgasana ini kosong?!", "protagonist", "boss", "left", "exclamation")
      .add("Suara Misterius", "Hahaha... Manusia malang. Kau tertipu oleh dongeng palsu para tetua Altdorf...", "boss", "protagonist", "right", "dots")
      .add("Protagonis", "Suara itu... Dari balik kristal ungu yang retak... Siapa kau sebenarnya?!", "protagonist", "boss", "left", "question")
      .add("Dark Crystal Overlord", "Penyakit kebocoran mana adikmu, Sestrina... BUKAN kutukan biasa! Sestrina adalah wadah reinkarnasi dari Segel Jiwa Suaka ini!", "boss", "protagonist", "right", "exclamation")
      .add("Dark Crystal Overlord", "Tubuh zirah ini adalah penahan (SEAL CONTAINER) agar roh kutukan ini tidak melahap jiwa adikmu!", "boss", "protagonist", "right", "dots")
      .add("Dark Crystal Overlord", "Dengan menghancurkanku, kau justru MEMBEBASKAN roh kegelapan purba! Sekarang, jiwa adikmu akan kutarik untuk membangkitkan tubuh abadiku!", "boss", "protagonist", "right", "exclamation")
      .add("Protagonis", "TIDAK AKAN KUBIARKAN KAU MENYENTUH SESTRINA!! AKU AKAN MEMURNIKAN ROH BUSUKMU SEKALIPUN HARUS MEMBAKAR JIWAKU SENDIRI!!", "protagonist", "boss", "left", "exclamation");
      
    _d.start(function() {
        with (oBossGolem) {
            start_phase_2();
        }
    });
};

/// @function on_true_death()
/// @description Penyelesaian pertarungan sejati setelah Roh Penjaga dimurnikan
on_true_death = function() {
    state = STATE_DEATH;
    sprite_index = sBoss_Overlord_Death;
    image_index = 0;
    image_speed = 0.08;
    
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
        oRoomTransition.screen_shake = 15;
    }
};
