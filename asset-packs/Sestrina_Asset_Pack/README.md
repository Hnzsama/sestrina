# 🛡️ Sestrina Asset Pack (Dedicated Custom Pack)

Koleksi aset custom khusus proyek game **Sestrina**, terpisah rapi dari asset pack eksternal pihak ketiga:

```
asset-packs/
├── Free - Raven Fantasy Icons/     (Aset luar)
├── Modern_Interiors_Free_v2.2/     (Aset luar)
├── Pixel Crawler - Free Pack/      (Aset luar)
└── Sestrina_Asset_Pack/            (Aset Custom Sestrina)
    ├── Enemies_Pack/
    ├── Pixel_UI_Stat_Pack/
    ├── Player_Character_Pack/
    ├── Sestrina_Character_Pack/
    ├── Sestrina_Bedroom_Decor_Pack/
    ├── Medieval_Town_Pack/
    │   ├── 01_buildings_pixel_art/
    │   ├── 02_terrain_ground_pixel_art/
    │   ├── 03_props_decor_pixel_art/
    │   └── 04_master_sheet/
    ├── JRPG_Town_Pack/
    │   ├── 01_roads_and_pavement/
    │   ├── 02_grass_and_nature/
    │   ├── 03_buildings_and_shops/
    │   ├── 04_street_props_and_lamps/
    │   └── 05_master_tileset_sheets/
    └── Goran_Blacksmith_Pack/
        ├── 01_character_goran/
        │   ├── 01_workshop_mode/
        │   │   ├── frames/
        │   │   ├── strips/
        │   │   └── previews_gif/
        │   ├── 02_combat_mode/
        │   │   ├── frames/
        │   │   ├── strips/
        │   │   └── previews_gif/
        │   └── portraits/
        ├── 02_blacksmith_workshop_decor/
        └── 03_sheets/
```

---

## 📦 Isi Folder

### 1. `Player_Character_Pack/`
Aset ksatria bertudung ungu dengan mata merah menyala (berbasis sprite ksatria kustom 64x64):
- **01_movement_idle**: Idle (rich breathing, gaze, cloak flutter) & Walk 4-arah (ayunan kedua tangan bergantian).
- **02_dodge_roll**: Dodge roll salto murni vertikal (Down & Up) dan salto samping (Side) tanpa terpotong.
- **03_attack_combo**: Kombo tebasan pedang 3-hit (Quick Slash $\rightarrow$ Amber Cleave $\rightarrow$ 360° Spin Finisher).
- **04_magic_cast**: Letupan sihir Fireball & Frost Nova 4-arah lengkap (Down, Side/Kanan-Kiri, Up).
- **05_potion_drink**: Minum ramuan darah 4-arah lengkap (Down, Side/Kanan-Kiri, Up) dengan efek chug, aura pemulihan holy green & gold, serta seka mulut.

### 2. `Enemies_Pack/`
Musuh 16-bit Top-Down 3/4 dengan animasi Idle, Walk, dan Attack:
- **Slime** (Bounce & Jiggle, Slash Attack)
- **Goblin** (Dagger Stabs, Shifty Eyes)
- **Orc** (Brutal Axe Swing, Heavy Stomp)
- **Kobold** (Quick Spear Thrust, Reptilian Tail Wag)
- **Troll** (Massive Club Slam, Roar & Ground Shake)

### 3. `Pixel_UI_Stat_Pack/`
Antarmuka status screen 16-bit RPG:
- Health, Mana, Stamina, XP bars
- Level & Class Badges
- 8 Equipment Slots (Helmet, Armor, Weapon, Shield, Ring, Amulet, Boots, Relic)
- Category Navigation Tabs & Item Icons
- Full Screen Mockup dengan portrait karakter tersinkronisasi

### 4. `Sestrina_Character_Pack/`
Aset karakter adik protagonis (Sestrina) - gadis elf bertelinga lancip bergaun biru lavender:
- Animasi 4-arah: Idle & Walk (Down, Side, Up).
- Animasi Sakit di Ranjang (*Sickbed breathing loop*).
- Pixel Art Portraits (Normal, Sick, Recovered) ukuran 64x64 & 128x128.

### 5. `Sestrina_Bedroom_Decor_Pack/`
Paket dekorasi kamar tidur bergaya Victorian Royal Fantasy:
- Perapian batu bara menyala (*hearth*), rak buku perpustakaan bertingkat, meja belajar alkimia, meja rias cermin antik (*vanity dresser*), karpet beludru merah berornamen emas, jendela lengkung bermandikan berkas sinar matahari (*sunbeams*).

### 6. `Medieval_Town_Pack/` (100% True Pixel Art)
Paket tata kota abad pertengahan Altdorf berbasis grid pixel murni 16x16:
- **01_buildings_pixel_art**: Gereja Gothic (*Cathedral with Belfry & Stained Glass*), Tudor Tavern & Inn 2 lantai, Adventurers Guild Hall berpilar, Windmill kincir gandum, Watchtower benteng, Toko Saudagar berkanopi kain, Bakery pondok pembuat roti beroven batu, dan Rumah Deret Variasi.
- **02_terrain_ground_pixel_art**: Tekstur rumput asli `sTile_Summer` (pure, daisies, clover, pebbles), jalan cobblestone/tanah liat, autotile tepi jalan, dan lahan bajak kebun (*furrowed tilled soil with seedlings*).
- **03_props_decor_pixel_art**: Sumur batu desa, gerobak jerami pedagang, meja piknik bir kedai, peti & tong anggur, tiang lentera besi tempa, papan nama toko, dan kios pasar berkanopi.
- **04_master_sheet**: `medieval_town_master_pixel_art_sheet.png` (512x512).

### 7. `JRPG_Town_Pack/` (JRPG / RPG Maker Reference Style)
Paket tata kota modern JRPG berbasis referensi screenshot:
- **01_roads_and_pavement**: Paving herringbone diagonal (`road_herringbone_cobblestone_seamless.png`), pembatas trotoar batu putih (*curbs autotile*), tangga batu berundak lebar, jalan setapak batu kali bulat.
- **02_grass_and_nature**: Rumput hijau limau cerah (*vibrant lime lawn*), taman bunga kuning marigold, bunga aster putih, semak mawar merah muda, kolam air teratai bergelagah, jembatan titian kayu, pohon oak peneduh berakar gurat kayu, pohon cemara pinus piramidal, pohon taman berbuah jeruk.
- **03_buildings_and_shops**: Toko Roti (*Bakery*) berkanopi putih & etalase roti emas, Rumah Atap Sisik Teal dengan cerobong berasap, Mansion Nightingale 2 lantai (versi siang & malam bercahaya).
- **04_street_props_and_lamps**: Lampu jalan Victorian bertiang batu (siang & malam menyala), tiang lampu ganda, bangku taman bilah oak panjang, peti kayu ekspedisi & tong anggur, pagar kayu teras tebing.
- **05_master_tileset_sheets**: `jrpg_town_master_tileset_sheet.png` (512x512).

### 8. `Goran_Blacksmith_Pack/` (Barbarian War Veteran & Blacksmith Companion)
Aset karakter Goran berbasis referensi ksatria barbarian kekar berotot (He-Man archetype) dengan rambut pirang emas, mata biru tajam, zirah harness bermedali salib Malta, celana bulu serigala, gelang besi emas, serta persenjataan kapak tempur ganda (*double-bladed battleaxe*):

- **`01_character_goran/01_workshop_mode/` (Mode Bengkel - Tanpa Kapak)**:
  - `frames/` & `strips/`:
    - `idle_down`, `idle_side`, `idle_up` (4 frames): Berdiri gagah dengan celemek kulit pandai besi bertali tembaga dan kantong pahat, bernapas tegap dada bidang tanpa membawa senjata.
    - `walk_down`, `walk_side`, `walk_up` (4 frames): Langkah kaki mantap berkeliling bengkel tanpa senjata.
    - `forge_hammering` (6 frames): Berdiri di depan paron, tangan kiri menjepit baja merah membara dengan tang (*smithing tongs*), tangan kanan mengayunkan palu tempa menghantam baja hingga memercikkan bunga api!
    - `inspect_wipe` (4 frames): Mengusap keringat dahi dengan lengan bawah dan memeriksa hasil tempaan bilah pedang.
  - `previews_gif/`: Preview animasi GIF beresolusi tajam (*crisp nearest-neighbor* 3x).

- **`01_character_goran/02_combat_mode/` (Mode Tempur - Boss Fight Companion dengan Kapak Tempur Raksasa)**:
  - `frames/` & `strips/`:
    - `combat_idle` (4 frames): Goran memanggul Kapak Tempur Ganda (*Double-Bladed Greataxe*) berinti permata zamrud hijau di pundaknya, pedang tersampir di punggung, siap menerjang bos.
    - `combat_walk` (4 frames): Melangkah maju agresif dengan kapak siap tebas.
    - `attack_01_cleave_combo` (6 frames, 80x64): Kombo dua tebasan kapak ganda horizontal brutal dengan busur energi giok hijau & kilauan perak (*Armor Shred*).
    - `attack_02_earthshatter_slam` (6 frames, 80x64): Melompat tinggi, mengangkat kapak dengan kedua tangan kekarnya, lalu menghantam tanah hingga membelah lantai dan meledakkan gelombang kejut radial (*Stun & Knockup*).
    - `attack_03_whirlwind_cyclone` (6 frames, 80x64): Berputar penuh 360° secara terus menerus bagaikan badai puyuh berserker, menebas seluruh minion di sekelilingnya (*360° AOE Cleave*).
    - `attack_04_warcry_buff` (6 frames, 64x64): Mengacungkan kapak tempur ke langit dan mengaumkan raungan perang legendaris yang menyemburkan cincin aura emas pertempuran (*Party ATK/Crit Buff & Boss Stagger*).
  - `previews_gif/`: Preview animasi GIF berkecepatan tinggi untuk seluruh aksi tempur.

- **`01_character_goran/portraits/`**:
  - `portrait_goran_reference_128x128.png` & `64x64`: Potret wajah veteran berambut pirang, mata biru tajam, rahang maskulin, dan zirah salib perunggu.
  - `portrait_goran_warcry_128x128.png` & `64x64`: Potret mengaum garang saat pertempuran dengan pancaran aura emas.
  - `portrait_goran_confident_128x128.png` & `64x64`: Senyum percaya diri setelah menempa atau memenangkan pertarungan.

- **`02_blacksmith_workshop_decor/` (Deluxe 16-bit Pixel Art Workshop Decor)**:
  - `decor_grand_furnace_forge.png` (96x96): Tungku peleburan batu bata api masif dengan bara api membara, lidah api menjilat, jeruji besi tempa, dan cerobong tudung tembaga berrivet.
  - `decor_master_anvil_vat.png` (64x64): Paron baja kilap cermin di atas tunggul kayu oak kuno berklem besi ganda + bak pendingin (*quenching vat*) berair riak dan berasap uap air.
  - `decor_grand_weapon_racks.png` (96x64): Rak senjata kayu oak bertingkat memajang 2 kapak tempur ganda, pedang lebar, tombak halberd, dan perisai bundar berukir.
  - `decor_barbarian_armor_display.png` (48x64): Manekin kayu memajang baju zirah Warlord barbarian lengkap: helm bertanduk, pauldon bahu bulu berduri, dan zirah salib perak.
  - `decor_deluxe_workbench_grindstone.png` (64x48): Meja kerja tukang besi berpenjepit ragum, cetak biru gulungan perkamen, lentera kuningan, dan batu asah putar pedal air.
  - `decor_precious_ingots_coal_bunker.png` (64x32): Piramida balok besi baja, batangan mithril biru berpendar sihir, emas murni, dan kotak batu bara bersekop besi.
  - `decor_veteran_war_trophy_plaque.png` (64x48): Plakat kayu perisai perang dengan sepasang pedang bersilang dan tengkorak minotaur bertanduk raksasa.
  - `decor_merchant_service_counter.png` (128x48): Meja etalase kayu mahoni dengan kabinet kaca beludru merah memajang 3 belati pusaka bertatahkan permata, buku kas pedagang, bulu angsa, dan timbangan koin emas.

- **`03_sheets/`**:
  - `goran_character_master_sheet.png` (512x256)
  - `goran_blacksmith_workshop_tileset_sheet.png` (512x256)


