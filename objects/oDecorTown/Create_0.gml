/// @description Inisialisasi Altdorf Town Square Decor

depth = 10;
water_anim = 0;
lamp_flicker = 0;
banner_sway = 0;

// Aliases ke fungsi global di scr_town_decor (menjamin 100% aman tanpa runtime lookup failure)
draw_curb_line = scr_draw_curb_line;
draw_curb_box = scr_draw_curb_box;
draw_cobblestone_road = scr_draw_cobblestone_road;
draw_flowerbed = scr_draw_flowerbed;
draw_street_lamp = scr_draw_street_lamp;
draw_park_bench = scr_draw_park_bench;
draw_park_pond = scr_draw_park_pond;
draw_wooden_bridge = scr_draw_wooden_bridge;
draw_tree_with_shadow = scr_draw_tree_with_shadow;
draw_cafe_table = scr_draw_cafe_table;
