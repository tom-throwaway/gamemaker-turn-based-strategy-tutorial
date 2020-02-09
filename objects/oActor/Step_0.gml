/// @description Insert description here
// You can write your code in this editor

switch(state) {
	case "beginpath":
		path_start(movementPath, moveSpeed, 0, true);
		state = "moving";
		break;
}