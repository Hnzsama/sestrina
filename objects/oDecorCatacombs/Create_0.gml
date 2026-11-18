/// @description Inisialisasi Ancient Catacombs Decor & Dungeon Traversal (UAS Features)

depth = 10;
torch_blue_flame = 0;
drip_timer = 0;

// 1. Sistem Jebakan Duri Lantai (Floor Spike Trap) - Traversal & Dodge Roll Testing
spike_cycle = 0;
spike_max_cycle = 160;
spike_x1 = 570;
spike_x2 = 710;
spike_y1 = 360;
spike_y2 = 400;

// 2. Sistem Gerbang Jeruji & Tuas Saklar (Gate & Lever Puzzle)
gate_opened = (variable_global_exists("catacombs_gate_opened") && global.catacombs_gate_opened);
switch_x = 220;
switch_y = 240;
gate_x1 = 580;
gate_x2 = 700;
gate_y = 480;