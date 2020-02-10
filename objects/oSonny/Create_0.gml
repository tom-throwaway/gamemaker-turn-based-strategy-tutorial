/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Sonny";

// Character statistics
move = 5;
actions = 2;
initRoll = 0;

// Game specific - D&D
class = "Wizard";
race = "Gnome";
level = 1;
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 1;
conMod = 2;
intMod = 3;
wisMod = 0;
maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;
hitBonus = profMod + strMod;
initiative = dexMod;