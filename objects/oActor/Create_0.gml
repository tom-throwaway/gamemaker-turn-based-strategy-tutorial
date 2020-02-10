/// @description Insert description here
// You can write your code in this editor
state = "idle";

army = global.BLUE_ARMY;

gridX = 0;
gridY = 0;

name = "Default";

// Character statistics
move = 6;
actions = 2;
initRoll = 0;

// Game specific - D&D
class = "Peasant";
race = "Human";
level = 1;
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 0;
conMod = 0;
intMod = 0;
wisMod = 0;
maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;
hitBonus = profMod + strMod;
initiative = dexMod;


// Pathfinding variables
movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

moveSpeed = 8; 