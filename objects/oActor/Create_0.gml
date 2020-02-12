/// @description Insert description here
// You can write your code in this editor
state = "idle";

army = global.BLUE_ARMY;

gridX = 0;
gridY = 0;

name = "Default";
class = "Peasant";
race = "Human";

level = 1;

// Character statistics //////////////////////////////////////

// Base stats
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 0;
conMod = 0;
intMod = 0;
wisMod = 0;

// Health variables
maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

// Attack variables
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;
attackTimer = 0;

// Damage variables
damageDice = 4;
damageBonus = strMod;
damageType = "piercing";

// Defence variables
armourClass = 10 + dexMod;

// Move and action vars
move = 6;
actions = 2;
canAct = false;

// Special action variables
charge = false;
sneakAttack = false;

// Initiative variables
initiative = dexMod;
initRoll = 0;


// Pathfinding variables //////////////////////////////////////
movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

endPath = "idle";

moveSpeed = 8;

// Variables related to effects
shake = 0;
shakeMag = 0;