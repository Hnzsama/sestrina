# Production Roadmap & Realistic Milestones
**Project:** Sestrina: The Quest for the Lost Remedy  
**Engine:** GameMaker (GML)  
**Timeline Total:** 16 Minggu (1 Semester Akademik)  

---

## 🎯 Target Akhir Proyek (Semester Scope)
Prototipe 2D ARPG playable berkualitas tinggi (*Single-Boss Focus*) dengan animasi pixel art yang fluid, AI Boss berbasis FSM (multi-phase), sistem collision AABB, serta integrasi cerita naratif emosional yang kohesif.

---

## 📅 Timeline Milestone Mingguan

### 🔹 Fase 1: Core Systems & Graybox Prototype (Minggu 1 - 4)
*Fokus: Membangun mekanik pergerakan pemain, fondasi AI, dan sistem teknis dasar tanpa mengkhawatirkan visual.*

- **Minggu 1: Setup Proyek & Kontrol Pemain**
  - [ ] Setup repository Git/GitHub & proyek GameMaker.
  - [ ] Implementasi kontrol pergerakan 2D (Top-down / Side-scroll sesuai style) & Dodge/Roll mechanic.
  - [ ] Implementasi sistem State Pemain sederhana (Idle, Walk, Dodge, Attack).
- **Minggu 2: Bounding Box & Basic Combat Framework**
  - [ ] Implementasi algoritma **AABB Collision Detection** untuk Player, Terrain, dan Hurtbox/Hitbox.
  - [ ] Sistem HP & Damage dasar (Player HP & Boss HP Placeholder).
- **Minggu 3: Fondasi AI Boss (FSM) & Pathfinding**
  - [ ] Membangun struktur **Finite State Machine (FSM)** untuk AI Boss.
  - [ ] Implementasi **Pathfinding & Vector Steering** agar Boss bisa melakukan tracking mendekati Player tanpa tersangkut di tembok.
  - [ ] State awal Boss: `Idle`, `Tracking`, `Basic Attack`.
- **Minggu 4: Single-Boss Graybox Encounter (Playable Prototype)**
  - [ ] Membuat arena pertarungan sederhana (Graybox Map).
  - [ ] Pengujian awal loop pertarungan dasar (Player vs Boss Placeholder).
  - [ ] **Milestone 1 Deliverable:** Prototype Playable (Pemain bisa bergerak, dodge, menyerang, dan melawan Boss kotak/placeholder dengan FSM dasar).

---

## 🔹 Fase 2: Boss Phase 2, Mechanical Balancing & Visuals (Minggu 5 - 8)
*Fokus: Mengembangkan kompleksitas Boss (Multi-Phase), memasukkan aset visual Aseprite / Itch.io, dan telegraphed attack.*

- **Minggu 5: Multi-Phase Boss System & Dynamic Pattern Shifting**
  - [ ] Penambahan State Boss lanjutan: `Special Attack` (AOE / Projectiles) dan `Stun State`.
  - [ ] Mekanisme Transisi Fase Boss (Misal: Phase 1 -> Phase 2 ketika HP Boss di bawah 50%).
- **Minggu 6: Animation Integration & Visual Feedback**
  - [ ] Impor & setup sprite sheet dari Aseprite / Itch.io (Player: Idle, Walk, Attack, Death).
  - [ ] Impor & setup sprite Boss (Legendary Guardian).
  - [ ] Implementasi *Telegraphed Attack Indicator* (Tanda visual sebelum Boss melancarkan jurus berat agar pertarungan terasa adil/*mechanically fair*).
- **Minggu 7: Projectile Systems & Environmental Hazards**
  - [ ] Integrasi AABB collision untuk proyektil Boss & serangan area (AOE).
  - [ ] Polish pergerakan Boss (Steering smoothing agar pergerakan tidak kaku).
- **Minggu 8: Vertical Slice Review (Mid-Semester Evaluation)**
  - [ ] Penyeimbangan awal damage, cooldown dodge, dan durasi jendela *Stun* Boss.
  - [ ] **Milestone 2 Deliverable (Vertical Slice):** 1 Arena dengan tampilan visual pixel art final, Boss 2-phase playable lengkap dengan animasi & audio placeholder.

---

## 🔹 Fase 3: Narrative Integration, Audio & UI/UX (Minggu 9 - 12)
*Fokus: Memasukkan elemen cerita "Lost Remedy", antarmuka pemain (UI), dan atmosfer audio.*

- **Minggu 9: Narrative & Cutscene / Dialogue System**
  - [ ] Membangun UI Dialogue System sederhana (Teks intro cerita adik yang sakit & motivasi mencari obat penawar).
  - [ ] Sequence sebelum dan sesudah pertarungan Boss (Intro Boss & Victory Screen memperoleh *Lost Remedy*).
- **Minggu 10: HUD & UI Polish**
  - [ ] Pembuatan UI Health Bar Pemain & Boss Health Bar yang dinamis.
  - [ ] Main Menu, Game Over Screen, Pause Menu, & Victory Screen.
- **Minggu 11: Audio & Sound Effects Integration**
  - [ ] Integrasi BGM (Main Menu Theme & Intense Boss Battle Theme).
  - [ ] Integrasi SFX (Sword swing, Boss attack, Player hurt, Dodge sound, UI click).
- **Minggu 12: Game State & Save System**
  - [ ] Implementasi penyimpan data sederhana (Save/Load status kemenangan / setting game via JSON/Local Storage).
  - [ ] **Milestone 3 Deliverable:** Game utuh dari intro cerita -> gameplay pertarungan -> pemenangan quest & diringi audio/UI lengkap.

---

## 🔹 Fase 4: Polishing, Bug Fixing & Final Testing (Minggu 13 - 16)
*Fokus: Pengujian kelayakan, perbaikan bug teknis, balancing akhir, dan penyusunan laporan UAS/Penelitian.*

- **Minggu 13: Playtesting & Mechanical Fairness Balancing**
  - [ ] Melakukan playtest internal/rakan sejawat untuk menguji *difficulty curve*.
  - [ ] Menyesuaikan hitboxes/hurtboxes, iframe (invincibility frame) saat dodge, dan hitstun.
- **Minggu 14: Bug Fixing & Technical Stability**
  - [ ] Memperbaiki edge case (misal: AI Boss terjebak sudut arena, collision glitch, memory leak).
  - [ ] Perbaikan stabilitas FPS & optimasi kode GML.
- **Minggu 15: Final Build Generation & Polish**
  - [ ] Export executable build akhir (PC Windows Standalone / WebGL).
  - [ ] Pembuatan trailer gameplay pendek / screenshot dokumentasi.
- **Minggu 16: Laporan Akhir & Presentasi Proyek**
  - [ ] Penyusunan hasil evaluasi masalah penelitian (Research Questions) berdasarkan prototipe final.
  - [ ] **Milestone 4 Deliverable Final:** Executable Game Build Final + Dokumen Laporan UAS / Penelitian.

---

## 📊 Matriks Ringkasan Risiko & Mitigasi
| Risiko Potential | Tingkat Dampak | Strategi Mitigasi |
| :--- | :--- | :--- |
| **Animasi Pixel Art Terlalu Lama** | Tinggi | Gunakan aset berkualitas dari Itch.io untuk karakter dasar, fokuskan custom Aseprite hanya untuk efek khusus/boss adjustment. |
| **AI Boss Terlalu Sulit / Unfair** | Sedang | Berikan indikator visual (*telegraphed animation*) 0.5 - 1 detik sebelum serangan besar & sediakan *Stun State* yang jelas. |
| **Scope Creep (Ingin tambah musuh/map)** | Tinggi | Disiplin menjaga skema **Single-Boss Structure** sesuai tujuan proposal semester. |
