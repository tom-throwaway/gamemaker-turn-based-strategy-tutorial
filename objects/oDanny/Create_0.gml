/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Danny";
class = "Fighter";
race = "Dwarf";

level = 1;

// Character statistics //////////////////////////////////////

// Base stats
profMod = 2 + floor(level / 5);
strMod = 3;
dexMod = 0;
conMod = 2;
intMod = 0;
wisMod = 1;

// Health variables
maxHitPoints = 10 + conMod + ((level - 1) * (6 + conMod));
hitPoints = maxHitPoints;

// Attack variables
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;
attackTimer = 0;

// Damage variables
damageDice = 8;
damageBonus = strMod;
damageType = "slashing";

// Defence variables
armourClass = 18;

// Move and action vars
move = 5;
actions = 2;
canAct = false;

// Initiative variables
initiative = dexMod;
initRoll = 0;