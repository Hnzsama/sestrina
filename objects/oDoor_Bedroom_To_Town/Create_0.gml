/// @description Door Kamar Sestrina ke Altdorf Town Square

event_inherited();
target_room = rm_town_square;
target_x = 1280;
target_y = 190;
door_title = "Altdorf Town Square";
door_subtitle = "Pusat Kota Altdorf";
door_w = 96;
door_h = 32;

// Terkunci sebelum bicara dengan Sestrina (stage 0 -> stage 1)
required_quest_stage = 1;
locked_message = "Bicaralah dengan Sestrina terlebih dahulu sebelum pergi!";
