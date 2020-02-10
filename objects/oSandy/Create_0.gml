/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Sandy";

// Character statistics
move = 7;
actions = 2;
initRoll = 0;

// Game specific - D&D
class = "Rogue";
race = "Elf";
level = 1;
profMod = 2 + floor(level / 5);
strMod = 0;
dexMod = 3;
conMod = 2;
intMod = 1;
wisMod = 0;
maxHitPoints = 6 + conMod + ((level - 1) * (4 + conMod));
hitPoints = maxHitPoints;
hitBonus = profMod + dexMod;
initiative = dexMod;