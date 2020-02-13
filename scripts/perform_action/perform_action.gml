//argument0 - actor performing the action
//argument1 - action to be performed

actor = argument0;
action = argument1;

switch(action) {
	case "END TURN":
		actor.state = "endTurn";
		actor.actionTimer = 20;
		break;
}