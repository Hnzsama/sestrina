/// @description Room Start Event - Posisikan Goran dekat Pemain di Ruangan Baru

if (!variable_global_exists("party_goran") || !global.party_goran) {
    instance_destroy();
    exit;
}

if (instance_exists(oPlayer)) {
    x = oPlayer.x - 36;
    y = oPlayer.y;
}

