# 📖 Game Design Document (GDD) - Sestrina: The Quest for the Lost Remedy

---

## 1. Overview & High Concept
- **Judul Game:** Sestrina: The Quest for the Lost Remedy
- **Genre:** 2D Action Role-Playing Game (ARPG) / Dungeon Crawler
- **Target Audience:** Pemain yang menyukai game 2D ARPG dengan tantangan pertarungan bertempo cepat, progresi stage pertempuran musuh (kroco & mini-boss), serta didorong oleh cerita naratif emosional.
- **Target Platform:** PC (Windows Standalone / WebGL)
- **Core Gameplay Loop:** 
  ```mermaid
  graph LR
      A[Exploration & Story Context] --> B[Lvl 1: Courtyard Minion Wave]
      B --> C[Lvl 2: Catacomb Elite & Mini-Boss]
      C -->|Obtain Key| D[Lvl 3: Boss Arena Entrance]
      D --> E[Tactical Real-Time Boss Combat]
      E -->|Observe Telegraphs| F[Dodge & Position]
      F -->|Stun Window| G[Counter Attack & Damage]
      G -->|Boss HP Phase Shift| E
      G -->|Boss Defeated| H[Obtain Lost Remedy & Story Resolution]
  ```
- **Unique Selling Proposition (USP):**
  1. **Structured Stage Progression:** Pengalaman bertahap dari pemanasan kroco (*minion wave*), pertarungan mini-boss pengawal segel, hingga klimaks duel boss *multi-phase*.
  2. **Emotional Narrative Stakes:** Pertarungan didasari oleh urgensi ikatan persaudaraan (mencari penawar obat/remedy untuk saudari yang menderita sakit parah).
  3. **Technical Precision:** Menggabungkan Finite State Machine (FSM), deteksi tabrakan AABB, dan Vector Steering Pathfinding dalam mesin 2D GameMaker.

---

## 2. Executive Summary Proposal Alignment

| Aspek Proposal | Implementasi Game Design |
| :--- | :--- |
| **Masalah Penelitian 1** (High-Fidelity & Fair Challenge) | Progresi bertahap dari kroco dasar ke mini-boss sebelum Boss Utama dengan indikator visual 0.5-1s. |
| **Masalah Penelitian 2** (Integrasi Narasi & Progresi) | Taruhan emosional adik yang sakit menentukan tingkat urgensi combat dan reward akhir *Lost Remedy*. |
| **Masalah Penelitian 3** (Balancing Multi-Stage Encounter) | Pembagian level sekuensial (Level 1: Kroco Courtyard, Level 2: Mini-Boss Catacombs, Level 3: Final Boss Phase 1 & 2). |

---

## 3. Map Dokumentasi Lengkap
Seluruh rincian teknis, art, cerita, dan sistem telah dipisah ke dalam folder terstruktur:
- 📖 [02-story-lore/](file:///home/darbi/Projects/course/pg/uas/docs/02-story-lore/) - World building, bio karakter & kroco, dan skrip dialog quest.
- ⚔️ [03-mechanics-systems/](file:///home/darbi/Projects/course/pg/uas/docs/03-mechanics-systems/) - Skema kontrol, FSM combat, formula damage, dan ekonomi.
- 🎨 [04-art-assets/](file:///home/darbi/Projects/course/pg/uas/docs/04-art-assets/) - Style guide pixel art Aseprite & checklist aset visual.
- 🎵 [05-audio-sound/](file:///home/darbi/Projects/course/pg/uas/docs/05-audio-sound/) - Checklist BGM & SFX pertarungan.
- 🗺️ [06-level-design/](file:///home/darbi/Projects/course/pg/uas/docs/06-level-design/) - Layout level, progresi stage kroco, arena boss, dan penguncian barrier.
- 💻 [07-technical-architecture/](file:///home/darbi/Projects/course/pg/uas/docs/07-technical-architecture/) - Arsitektur GameMaker GML, class diagram, dan algoritma AABB/Pathfinding.
- 🖥️ [08-ui-ux/](file:///home/darbi/Projects/course/pg/uas/docs/08-ui-ux/) - Diagram UI Flow dan Wireframe HUD Layar.
- 📅 [09-production-milestones/](file:///home/darbi/Projects/course/pg/uas/docs/09-production-milestones/) - Roadmap 16 minggu (Semester akademik).
