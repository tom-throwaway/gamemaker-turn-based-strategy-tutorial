/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Sandy";
class = "Rogue";
race = "Elf";

level = 1;

// Character statistics //////////////////////////////////////

// Base stats
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 3;
conMod = 2;
intMod = 1;
wisMod = 0;

// Health variables
maxHitPoints = 6 + conMod + ((level - 1) * (4 + conMod));
hitPoints = maxHitPoints;

// Attack variables
hitBonus = profMod + dexMod;
attackType = "ranged";
attackRange = 15 * global.GRID_SIZE;
attackTarget = noone;
attackTimer = 0;

// Damage variables
damageDice = 6;
damageBonus = dexMod;
damageType = "piercing";

// Defence variables
armourClass = 10 + dexMod;

// Move and action vars
move = 7;
actions = 2;
canAct = false;

// Special action variables
sneakAttack = true;
sneakAttackDamage = 6;

// Initiative variables
initiative = dexMod;
initRoll = 0;