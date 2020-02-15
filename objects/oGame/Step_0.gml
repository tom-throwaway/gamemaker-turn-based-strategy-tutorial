 /// @description Insert description here
// You can write your code in this editor

switch(state) {
	case "initialising":
		// Loops over every oNode instance
		with(oNode) {
			if(instance_position(x + 16, y + 16, oTerrain)) {
				tempTerrain = instance_position(x + 16, y + 16, oTerrain);
				switch(tempTerrain.type) {
					case "wall":
						instance_change(oWall, true);
						type = "wall";
						passable = false;
						break;
					case "rubble":
						instance_change(oRubble, true); 
						type = "rubble";
						cost = 2;
						break;
				}
	
				with(tempTerrain) {
					instance_destroy();	
				}
			}
			
			if(instance_position(x + 16, y + 16, oActor)) {
				occupant = instance_position(x + 16, y + 16, oActor);
				occupant.gridX = gridX;
				occupant.gridY = gridY;
			}
		}
		
		state = "rollInit";
		break;
		
	case "rollInit":
		tempInit = ds_priority_create();
		with(oActor) {
			initRoll = 	irandom_range(1, 20) + initiative;
			ds_priority_add(other.tempInit, id, initRoll);
		}
		
		while(ds_priority_size(tempInit) > 0) {
			ds_list_add(turnOrder, ds_priority_delete_max(tempInit));
		}
		
		turnMax = ds_list_size(turnOrder);
		ds_priority_destroy(tempInit);
		
		state = "ready";
		break;
		
	case "ready":
		if(currentActor == noone) {
			turnCounter += 1;
			
			if(turnCounter >= turnMax) {
				turnCounter = 0;
				roundCounter += 1;
			}
			
			currentActor = ds_list_find_value(turnOrder, turnCounter);
			
			currentActor.actions = 2;
			currentActor.canAct = true;
			currentActor.state = "initializeTurn";
		}
	
		break;
}


