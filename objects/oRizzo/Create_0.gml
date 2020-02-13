/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Rizzo";
class = "Cleric";
race = "Human";

level = 1;


// Character statistics //////////////////////////////////////

// Base stats
profMod = 2 + floor(level / 5);
strMod = 2;
dexMod = 0;
conMod = 1;
intMod = 0;
wisMod = 3;

// Health variables
maxHitPoints = 8 + conMod + ((level - 1) * (5 + conMod));
hitPoints = maxHitPoints;

// Attack variables
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;
actionTimer = 0;

// Damage variables
damageDice = 8;
damageBonus = strMod;
damageType = "bludgeoning";

// Defence variables
armourClass = 16;

// Move and action vars
move = 6;
actions = 2;
canAct = false;

// Initiative variables
initiative = dexMod;
initRoll = 0;