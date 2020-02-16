/// @description Insert description here
// You can write your code in this editor

path_clear_points(movementPath);

if(actions > 0) {
	state = "findTarget";	
}
else {
	state = "idle";
	oGame.currentActor = noone;
}