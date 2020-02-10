/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Rizzo";

// Character statistics
move = 6;
actions = 2;
initRoll = 0;

// Game specific - D&D
class = "Cleric";
race = "Human";
level = 1;
profMod = 2 + floor(level / 5);
strMod = 2;
dexMod = 0;
conMod = 1;
intMod = 0;
wisMod = 3;
maxHitPoints = 8 + conMod + ((level - 1) * (5 + conMod));
hitPoints = maxHitPoints;
hitBonus = profMod + strMod;
initiative = dexMod;