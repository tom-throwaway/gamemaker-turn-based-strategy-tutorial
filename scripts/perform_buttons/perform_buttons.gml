function perform_buttons(argument0, argument1) {
	//argument0 - actor performing action
	//argument1 - button pressed

	actor = argument0;
	button = argument1;

	switch(button.title) {
		// Default actions
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
		
		// Cleric spells
		case "BLESS":
			actor.state = "beginAction";
			actor.readiedAction = "Bless";
			actor.targetingType = "visibleAllies";
			actor.actionRange = 640;
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmButton)) {
				title = other.button.title;
				text = other.button.text;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
		
		case "HEALING WORD":
			actor.state = "beginAction";
			actor.readiedAction = "Healing Word";
			actor.targetingType = "visibleAllies";
			actor.actionRange = 640;
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmBox)) {
				title = other.button.title;
				text = other.button.text;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
	
		case "GUIDING BOLT":
			actor.state = "beginAction";
			actor.readiedAction = "Guiding Bolt";
			actor.targetingType = "visibleEnemies";
			actor.actionRange = 640;
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmBox)) {
				title = other.button.title;
				text = other.button.text;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
	
		// Wizard spells
		case "ACID ORB":
			actor.state = "beginAction";
			actor.readiedAction = "Acid Orb";
			actor.targetingType = "visibleEnemies";
			actor.actionRange = 640;
		
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmBox)) {
				title = other.button.title;
				text = other.button.text;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
		
		case "BURNING HANDS":
			actor.state = "beginAction";
			actor.readiedAction = "Burning Hands";
			actor.targetingType = "cone";
			actor.actionRange = 96;
		
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmBox)) {
				title = other.button.title;
				text = other.button.text;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
	
		case "MAGIC MISSILES":
			actor.state = "beginAction";
			actor.readiedAction = "Magic Missiles";
			actor.targetingType = "visibleEnemies";
			actor.actionRange = 640;
		
			with(instance_create_layer(room_width / 2, room_height, "ButtonLayer", oConfirmButton)) {
				title = other.button.title;
				text = other.button.text;
				hotKey = other.button.hotKey;
			}
		
			wipe_nodes();
			wipe_buttons();
			break;
	}


}
