# ⚔️ Protagonist Character Animation Pack (Sestrina Edition)

Paket animasi lengkap ksatria berambut biru (protagonis utama) yang dirancang 100% kompatibel dengan sistem input, kontrol, dan mekanisme aksi pada `oPlayer` game *Sestrina*.

---

## 🎮 Pemetaan Kemampuan & Animasi

| Input / Tombol | Aksi & Kemampuan | Animasi Termasuk | Kecepatan (FPS) |
| :--- | :--- | :--- | :---: |
| **[W] [A] [S] [D] / Panah** | **Bergerak 4 Arah** | `walk_down` (6F), `walk_up` (6F), `walk_side` (6F) | 7 fps |
| **(Diam)** | **Bernapas / Idle 4 Arah** | `idle_down` (4F), `idle_up` (4F), `idle_side` (4F) | 5 fps |
| **[Space]** | **Dodge Roll (Kebal Serangan)** | `roll_down` (6F), `roll_side` (6F), `roll_up` (6F) | 12 fps |
| **[Z] - Hit 1** | **Quick Slash (Tebasan Cepat)** | `combo1_quick_slash_down/side/up` (4F) | 10 fps |
| **[Z] - Hit 2** | **Amber Cleave (Tebasan Berat)** | `combo2_amber_cleave_down/side/up` (4F) | 9 fps |
| **[Z] - Hit 3** | **Celestial 360° Spin Finisher** | `combo3_spin_finisher_360` (8F putaran 360°) | 12 fps |
| **[X] & [Q]** | **Lancarkan Sihir Api (Fireball)** | `cast_fireball_down/side/up` (6F dengan aura api & letupan) | 9 fps |
| **[X] & [Q]** | **Lancarkan Sihir Es (Frost Nova)** | `cast_frostnova_down/side/up` (6F dengan kristal es & cincin shockwave) | 9 fps |
| **[C]** | **Minum Ramuan Darah (Heal HP)** | `drink_potion_down/side/up` (6F angkat botol & kilau hijau/emas) | 7 fps |

---

## 📁 Struktur Folder Aset

```
Player_Character_Pack/
├── 01_movement_idle/
│   ├── strips/ (spr_player_walk_down/side/up_strip6.png, spr_player_idle_down/side/up_strip4.png)
│   ├── frames/ (file png per frame)
│   └── previews_gif/ (preview_walk_*.gif, preview_idle_*.gif)
├── 02_dodge_roll/
│   ├── strips/ (spr_player_roll_down/side/up_strip6.png)
│   ├── frames/
│   └── previews_gif/
├── 03_attack_combo/
│   ├── strips/
│   │   ├── spr_player_combo1_quick_slash_down/side/up_strip4.png
│   │   ├── spr_player_combo2_amber_cleave_down/side/up_strip4.png
│   │   └── spr_player_combo3_spin_finisher_360_strip8.png
│   ├── frames/
│   └── previews_gif/
├── 04_magic_cast/
│   ├── strips/
│   │   ├── spr_player_cast_fireball_down/side/up_strip6.png
│   │   └── spr_player_cast_frostnova_down/side/up_strip6.png
│   ├── frames/
│   └── previews_gif/
└── 05_potion_drink/
    ├── strips/
    │   └── spr_player_drink_potion_down/side/up_strip6.png
    ├── frames/
    └── previews_gif/
```

---

## 🛠️ Cara Integrasi ke GameMaker (`oPlayer`)

1. **Import Strip ke Asset Browser GameMaker**:
   * Tarik file-file dari folder `strips/` langsung ke folder `sprites` di Asset Browser GameMaker.
   * GameMaker akan otomatis memecah jumlah sub-image sesuai sufiks `_stripN`.
   * Atur Origin sprite ke **Bottom Center** (`x = 24, y = 48` pada kanvas 48x48) agar sorting kedalaman kaki sejajar sempurna dengan tile dan musuh.

2. **Gunakan di `oPlayer` State Machine**:
   * Saat `is_rolling == true`: Pasang `sprite_index = spr_player_roll_...`
   * Saat `is_attacking > 0`: Pasang sprite sesuai `combo_step` (`1`: Quick Slash, `2`: Cleave, `3`: Spin)
   * Saat meminum ramuan [C]: Pasang `sprite_index = spr_player_drink_potion`
   * Saat meluncurkan sihir [X]: Pasang `sprite_index = (global.spell_selected == 1) ? spr_player_cast_fireball : spr_player_cast_frostnova`
