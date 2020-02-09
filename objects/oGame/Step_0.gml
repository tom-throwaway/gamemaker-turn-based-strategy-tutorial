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
						type = "wall";
						passable = false;
						sprite_index = sWall;
						break;
					case "rubble":
						type = "rubble";
						sprite_index = sRubble;
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
		
		state = "ready";
		break;
}


