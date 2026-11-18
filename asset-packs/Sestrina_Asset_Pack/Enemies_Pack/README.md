# 📦 Top-Down 2D RPG Enemy Asset Pack (Sestrina Edition)

Asset pack musuh 2D Top-Down RPG dengan perspektif kamera **Top-Down 3/4** (menghadap ke arah pemain/bawah) yang disesuaikan presisi dengan skala visual, sudut pandang kamera, dan palet warna game *Sestrina*.

---

## 👾 Daftar Monster

| Monster | Karakteristik Visual | Skala Pixel Game | Animasi Termasuk |
| :--- | :--- | :---: | :--- |
| **Slime** | Gelatin hijau transparan, mata inti oranye menyala | 36x36 px | Idle (4F), Move/Jump (6F), Attack Spike (6F) |
| **Goblin** | Kulit zaitun, mohawk gelap, armor pundak berduri, tombak trisula | 48x48 px | Idle (4F), Walk (6F), Spear Thrust Attack (8F) |
| **Orc** | Postur berotot kekar, taring bawah, pauldron besi, kapak tempur raksasa | 52x52 px | Idle (4F), Heavy Stomp Walk (6F), Brutal Axe Slam (7F) |
| **Kobold** | Reptil naga kecil bersisik merah bata, tanduk mini, ekor cambuk, tombak | 44x44 px | Idle (4F), Scurry Walk (6F), Lunging Thrust & Bite (8F) |
| **Troll** | Raksasa batu/rawa kelabu berlumut, kulit berbonggol, pentungan kayu besar | 64x64 px | Idle (4F), Earthshaker Walk (6F), Overhead Club Slam (8F) |

---

## 📁 Struktur Folder Per Monster

Setiap folder monster memiliki struktur yang rapi dan seragam:

```
Enemies_Pack/
├── Goblin/
│   ├── goblin_master_source.jpg             # Source original HD spritesheet
│   ├── spritesheets/
│   │   ├── goblin_full_sheet_transparent.png # Master sheet transparan (Full Res)
│   │   ├── spr_goblin_idle_strip4.png        # Horizontal strip 4 frame (Full Res)
│   │   ├── spr_goblin_walk_strip6.png        # Horizontal strip 6 frame (Full Res)
│   │   └── spr_goblin_attack_strip8.png      # Horizontal strip 8 frame (Full Res)
│   ├── game_ready_48x48/                     # Versi resolusi native pixel game (48x48)
│   │   ├── spr_goblin_idle_strip4.png        # Siap drag-and-drop GameMaker
│   │   ├── spr_goblin_walk_strip6.png
│   │   ├── spr_goblin_attack_strip8.png
│   │   ├── idle/ (frame individu idle_00..03.png)
│   │   ├── walk/ (frame individu walk_00..05.png)
│   │   └── attack/ (frame individu attack_00..07.png)
│   ├── frames/                               # Frame individu resolusi tinggi
│   │   ├── idle/
│   │   ├── walk/
│   │   └── attack/
│   └── previews_gif/                         # Animasi preview format GIF loop
│       ├── goblin_idle.gif
│       ├── goblin_walk.gif
│       └── goblin_attack.gif
├── Slime/
├── Orc/
├── Kobold/
└── Troll/
```

---

## 🎮 Cara Import ke GameMaker Studio 2

1. **Import Cepat via Strip (Sangat Direkomendasikan):**
   - Buka project di **GameMaker Studio**.
   - Tarik file strip dari folder `game_ready_XXxXX` (contoh: `spr_goblin_walk_strip6.png`) langsung ke panel **Asset Browser** di bawah grup `sprites`.
   - GameMaker akan otomatis mengenali sufiks `_strip6` dan memecahnya menjadi **6 sub-image frame** secara instan!

2. **Atur Origin Sprite:**
   - Rekomendasi origin untuk game top-down RPG ini adalah **Bottom Center** (tengah bawah kaki) agar kalkulasi `depth = -bbox_bottom` dan sorting kedalaman berjalan sempurna.
