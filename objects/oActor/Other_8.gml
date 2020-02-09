/// @description Insert description here
// You can write your code in this editor

path_clear_points(movementPath);
state = "idle";

if(actions > 0) {
	oCursor.selectedActor = id;
	movement_range(map[gridX, gridY], move, actions);
}