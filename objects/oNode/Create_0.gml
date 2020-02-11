/// @description Insert description here
// You can write your code in this editor

neighbours = ds_list_create();

color = c_white;

occupant = noone;
passable = true;

gridX = 0;
gridY = 0;

type = "node";

// Pathfinding variables
G = 0;
moveNode = false;

attackNode =false;
parent = noone;

// Cost to move through
cost = 1;