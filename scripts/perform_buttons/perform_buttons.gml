//argument0 - actor performing action
//argument1 - button pressed

actor = argument0;
button = argument1;

switch(button.title) {
	case "END TURN":
		actor.state = "beginAction";
		actor.readiedAction = "END TURN";
		actor.targetingType = "none";
		
		with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmButton)) {
			title = other.button.title;
			text = other.button.text;
			hotKey = other.button.hotKey;
		}
		
		wipe_nodes();
		wipe_buttons();
		break;
}