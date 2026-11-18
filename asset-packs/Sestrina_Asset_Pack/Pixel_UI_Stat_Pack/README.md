# 🎨 Pixel Art RPG Stat & Status UI Asset Pack

Asset UI Pixel Art 16-bit untuk layar **Status & Kelengkapan Ksatria** serta **HUD** game *Sestrina*. Didesain dengan palet warna biru indigo, emas kuno, dan elemen fantasi retro yang serasi dengan karakter ksatria berambut biru.

---

## 📁 Struktur Folder

```
Pixel_UI_Stat_Pack/
├── status_screen_pixel_mockup.png       # Pratinjau susunan tata letak UI baru
├── sheets/
│   ├── pixel_stat_ui_sheet_transparent.png      # Master Sheet 1 (Portrait, Badge, Bar, Slot, Button)
│   └── pixel_window_icons_sheet_transparent.png # Master Sheet 2 (Window Frame, Banner, Material, Combat)
├── portrait/
│   ├── hero_portrait_framed.png                 # Foto profil ksatria berambut biru (Bingkai emas-kayu)
│   └── hero_portrait_64x64.png                  # Skala native 64x64 pixel
├── badges_attributes/
│   ├── badge_vit.png / badge_vit_32x32.png      # Badge bulat merah (Vitalitas)
│   ├── badge_str.png / badge_str_32x32.png      # Badge pedang silang (Kekuatan)
│   ├── badge_int.png / badge_int_32x32.png      # Badge orb biru (Kecerdasan)
│   ├── badge_agi.png / badge_agi_32x32.png      # Badge sepatu sayap (Kelincahan)
│   ├── badge_def.png / badge_def_32x32.png      # Badge perisai besi (Pertahanan)
│   ├── badge_luk.png / badge_luk_32x32.png      # Badge semanggi ungu (Keberuntungan)
│   └── btn_stat_plus.png                        # Tombol [+] alokasi poin
├── equipment_slots/
│   ├── slot_weapon.png / _40x40.png             # Kotak slot senjata (siluet pedang)
│   ├── slot_armor.png / _40x40.png              # Kotak slot baju zirah (siluet armor)
│   ├── slot_accessory.png / _40x40.png          # Kotak slot aksesoris (siluet cincin)
│   └── slot_spellbook.png / _40x40.png          # Kotak slot sihir (siluet buku)
├── status_bars/
│   ├── bar_hp.png                               # Bar HP merah pixel bergradasi
│   ├── bar_mp.png                               # Bar MP biru sian
│   ├── bar_stamina.png                          # Bar Stamina hijau zamrud
│   └── bar_exp.png                              # Bar EXP ungu kerajaan
├── materials_items/
│   ├── item_slime_jelly.png / _24x24.png        # Slime Jelly (tetesan hijau)
│   ├── item_bone_shard.png / _24x24.png         # Bone Shard (tulang)
│   ├── item_scrap_iron.png / _24x24.png         # Scrap Iron (batangan logam tempa)
│   ├── item_iron_ore.png / _24x24.png           # Iron Ore (bongkahan bijih besi)
│   ├── item_magic_crystal.png / _24x24.png      # Magic Crystal (kristal sian)
│   ├── item_gold_coin.png / _24x24.png          # Koin Emas
│   ├── item_potion_hp.png / _24x24.png          # Botol Ramuan Merah
│   └── item_potion_mp.png / _24x24.png          # Botol Ramuan Biru
├── combat_icons/
│   ├── icon_phys_atk.png / _24x24.png           # ATK Fisik (Pedang baja)
│   ├── icon_magic_atk.png / _24x24.png          # Magic ATK (Tongkat sihir)
│   ├── icon_armor.png / _24x24.png              # Armor Pertahanan (Baju zirah)
│   ├── icon_crit.png / _24x24.png               # Critical Rate (Bintang emas)
│   ├── icon_speed.png / _24x24.png              # Kecepatan (Sepatu sayap)
│   └── icon_evasion.png / _24x24.png            # Evasion (Efek hantu melompat)
├── buttons_tabs/
│   ├── tab_atribut.png                          # Tab tombol [Atribut]
│   ├── tab_equip.png                            # Tab tombol [Equip]
│   ├── tab_quest.png                            # Tab tombol [Quest]
│   └── btn_close_x.png                          # Tombol tutup [X] merah
└── window_frames/
    ├── window_status_full.png                   # Bingkai jendela modal 16-bit lengkap
    └── window_header_banner.png                 # Pita banner judul "STATUS & KELENGKAPAN KSATRIA"
```

---

## 🛠️ Rekomendasi Implementasi di GameMaker (Draw_64.gml)

Untuk mengintegrasikan asset ini ke `objects/oRoomTransition/Draw_64.gml`:
1. Buat sprite di GameMaker untuk portrait (`sHeroPortrait`), badge atribut (`sStatBadges`), kotak slot (`sEquipmentSlots`), bar status (`sStatusBars`), dan ikon material (`sItemIcons`).
2. Tampilkan `sHeroPortrait` pada koordinat kiri modal (menggantikan ruang kosong).
3. Ganti ikon teks / sprite kecil lama pada baris VIT, STR, INT, AGI dengan `badge_vit`, `badge_str`, `badge_int`, `badge_agi`.
4. Ganti teks Senjata & Sihir dengan kotak slot peralatan `slot_weapon`, `slot_armor`, `slot_accessory`, `slot_spellbook`.
