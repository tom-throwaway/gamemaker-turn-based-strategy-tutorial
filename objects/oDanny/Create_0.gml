/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Danny";

// Character statistics
move = 5;
actions = 2;
initRoll = 0;

// Game specific - D&D
class = "Fighter";
race = "Dwarf";
level = 1;
profMod = 2 + floor(level / 5);
strMod = 3;
dexMod = 0;
conMod = 2;
intMod = 0;
wisMod = 1;
maxHitPoints = 10 + conMod + ((level - 1) * (6 + conMod));
hitPoints = maxHitPoints;
hitBonus = profMod + strMod;
initiative = dexMod;