/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Sonny";
class = "Wizard";
race = "Gnome";

level = 1;

// Character statistics //////////////////////////////////////

// Base stats
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 1;
conMod = 2;
intMod = 3;
wisMod = 0;

// Health variables
maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

// Attack variables
hitBonus = profMod + intMod;
attackType = "ranged";
attackRange = 15 * global.GRID_SIZE;
attackTarget = noone;
actionTimer = 0;

// Damage variables
damageDice = 4;
damageBonus = strMod;
damageType = "piercing";

// Defence variables
armourClass = 10 + dexMod;

// Move and action vars
move = 5;
actions = 2;
canAct = false;

// Initiative variables
initiative = dexMod;
initRoll = 0;