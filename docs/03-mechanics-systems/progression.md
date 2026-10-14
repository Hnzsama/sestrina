# ⚔️ Sistem Progresi & Leveling - Sestrina ARPG

## 1. Leveling Pemain & Formula EXP
- **Formula EXP Level Up:** `XP_Needed = round(Previous_XP * 1.35 + 25)`
- **Reward Level Up:**
  - Pemulihan penuh HP, MP, dan Stamina.
  - Memperoleh **+3 Stat Points** untuk dialokasikan bebas.
  - Banner selebrasi Level Up di layar.

## 2. Sistem 4 Atribut Karakter (Core Stats)
Pemain dapat membuka Menu Status dengan menekan tombol `[P]` atau `[TAB]` dan mengalokasikan poin dengan tombol `[1] s/d [4]`:
1. **VIT (Vitalitas) - [1]:** Menambah Max HP (+8 HP per poin) dan daya tahan.
2. **STR (Kekuatan) - [2]:** Menambah Base Attack pedang dan kalkulasi kombo 3-hit.
3. **INT (Kecerdasan) - [3]:** Menambah Max Mana (+8 MP per poin), regenerasi pasif Mana, dan daya hancur sihir (Magic Power).
4. **AGI (Kelincahan) - [4]:** Menambah Max Stamina (+4 SP per poin), regenerasi stamina, dan kelincahan menghindar (*Dodge Roll*).

## 3. Tingkatan Senjata (Weapon Tiers di Pandai Besi Goran)
| Tingkat Senjata | Nama Senjata | Base ATK | Persyaratan Bahan Tempa |
| :--- | :--- | :---: | :--- |
| **Tier 1** | *Pedang Karat* | 14 + STR scaling | Diberikan oleh Goran di awal petualangan |
| **Tier 2** | *Pedang Besi Tempa* | 24 + STR scaling | 4x Besi Bekas, 2x Bijih Besi, 40 Gold *(Membuka Segel Katakombe)* |
| **Tier 3** | *Pedang Baja Damaskus* | 38 + STR scaling | 6x Bijih Besi, 4x Tulang Monster, 120 Gold |
| **Tier 4** | *Pedang Perak Runic* | 58 + STR & INT scaling | 2x Kristal Sihir, 6x Tulang Monster, 250 Gold |

## 4. Sistem Sihir (Magic Spells di Alkemis Elysia)
- **Tombol Sihir:** `[X]` untuk melempar sihir aktif, `[Q]` untuk berganti mantra.
- **Mantra 1 - Fireball:** Proyektil bola api jarak jauh yang meledak saat menabrak musuh/tembok (Biaya: 20 MP).
- **Mantra 2 - Frost Nova:** Ledakan kristal es radial di sekitar pemain yang memperlambat musuh di area 65px (Biaya: 28 MP). Dipelajari dari Elysia dengan 5x Slime Jelly, 1x Magic Crystal, 80 Gold.
