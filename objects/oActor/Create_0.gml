/// @description Insert description here
// You can write your code in this editor
state = "idle";

gridX = 0;
gridY = 0;

name = "Default";

// Character statistics
move = 5;
actions = 2;

// Pathfinding variables
movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

moveSpeed = 8; 