   /// @description Insert description here
// You can write your code in this editor

x = mouse_x;
y = mouse_y;

gridX = floor(x / global.GRID_SIZE);
gridY = floor(y / global.GRID_SIZE);

if(gridX < 0 || gridY < 0 || gridX >= room_width/global.GRID_SIZE || gridY >= room_height/global.GRID_SIZE) {
	hoverNode = noone;
}
else {
	hoverNode = map[gridX, gridY];
}

//if(mouse_check_button_pressed(mb_left)) {
//	if(hoverNode.occupant != noone) {
//		if(hoverNode.occupant != selectedActor) {
//			selectedActor = hoverNode.occupant;
//			selectedActor.actions = 2;
//			movement_range(hoverNode, selectedActor.move, selectedActor.actions);
//		}
//	}
//	else {
//		selectedActor = noone;
//		wipe_nodes();
//	}
//}

if(mouse_check_button_pressed(mb_right)) {
	if(selectedActor != noone && hoverNode.moveNode) {
		current = hoverNode;
		
		create_path(selectedActor, current);
		
		// Clear the node of selected actor
		map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
		// Update actors grid coords
		selectedActor.gridX = gridX;
		selectedActor.gridY = gridY;
		
		// Update actors future node
		hoverNode.occupant = selectedActor;
		
		// Send actor on path
		selectedActor.state = "beginPath";
		selectedActor.endPath = "ready";
		
		// Reduce selected actors actions and wipe nodes
		if(hoverNode.G > selectedActor.move) {
			selectedActor.actions -= 2;
			wipe_nodes();
		}
		else {
			selectedActor.actions -= 1;
			wipe_nodes();
		}
		
		selectedActor = noone;
	}
	
	if(selectedActor != noone && hoverNode.attackNode) {
		switch(selectedActor.attackType) {
			case "ranged":
				selectedActor.canAct = false;
				selectedActor.actions -= 1;
				selectedActor.attackTarget = hoverNode.occupant;
				selectedActor.state = "beginAttack";
				selectedActor.attackTimer = 10;
				selectedActor = noone;
				wipe_nodes();
				break;
			case "melee":
				selectedActor.canAct = false;
				selectedActor.attackTarget = hoverNode.occupant;
				
				tempX = abs(hoverNode.gridX - selectedActor.gridX);
				tempY = abs(hoverNode.gridX - selectedActor.gridY);
				if(tempX <= 1 && tempY <= 1) {
					// Adjacent to target
					selectedActor.actions -= 1;
					selectedActor.state = "beginAttack";
					selectedActor.attackTimer = 10;
					selectedActor = noone;
					wipe_nodes();
				}
				else {
					// Not adjacent to target
					tempG = 100;
					current = noone;
					
					for(ii = 0; ii < ds_list_size(hoverNode.neighbours); ii++) {
						tempNode = ds_list_find_value(hoverNode.neighbours, ii);
						
						if(tempNode.occupant == noone && tempNode.G > 0 && tempNode.G < tempG) {
							tempG = tempNode.G;
							current = tempNode;
						}
					}
					
					targetNode = current;
					
					create_path(selectedActor, targetNode);
					
					// Clear the node of selected actor
					map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
					// Update actors grid coords
					selectedActor.gridX = targetNode.gridX;
					selectedActor.gridY = targetNode.gridY;
		
					// Update actors future node
					targetNode.occupant = selectedActor;
		
					// Send actor on path
					selectedActor.state = "beginPath";
					selectedActor.endPath = "beginAttack";
					selectedActor.attackTarget = hoverNode.occupant;
					selectedActor.actions -= 2;
					selectedActor.canAct = false;
					selectedActor = noone;
					wipe_nodes();
				}
				
				break;
		}
		
	}
}