/// @description Insert description here

// Status of attack - miss / hit / crit
status = "miss";
damage = 0;
damageType = "piercing";

target = noone;
owner = noone;

// Path information
movementPath = path_add();
path_set_closed(movementPath, false);
path_set_kind(movementPath, 2);

