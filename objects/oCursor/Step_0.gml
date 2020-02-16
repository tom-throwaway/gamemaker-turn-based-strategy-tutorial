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

with(oConfirmButton) {
	if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord(hotKey))) {
		other.selectedActor.state = "performAction";
		instance_destroy();
	}
}

if(instance_place(x, y, oButton)) {
	if(instance_place(x, y, oButton) == hoverButton) {
		buttonTimer += 1;	
	}
	else {
		buttonTimer = 0;	
	}
	hoverButton = instance_place(x, y, oButton);	
	//hoverNode = noone;
}
else {
	hoverButton = noone;	
	buttonTimer = 0;
}

with(oButton) {
	if(keyboard_check_pressed(ord(hotKey))) {
		perform_buttons(oCursor.selectedActor, id);	
	}
}

if(keyboard_check_pressed(vk_escape) && selectedActor != noone) {
	if(selectedActor.state == "beginAction") {
		selectedActor.state = "idle";
		with(oConfirmButton) {
			instance_destroy();	
		}
		with(oConfirmBox) {
			instance_destroy();	
		}
	}
	
	wipe_buttons();
	wipe_nodes();
	movement_range(map[selectedActor.gridX, selectedActor.gridY], selectedActor.move, selectedActor.actions);
	
	if(selectedActor.canAct) {
		switch(selectedActor.attackType) {
			case "ranged":
				ranged_attack_range(selectedActor);
				break;
			case "melee":
				melee_attack_range(selectedActor);
				break;
		}
	}
}

if(mouse_check_button_pressed(mb_left)) {
	if(selectedActor != noone && hoverButton != noone) {
		perform_buttons(selectedActor, hoverButton);	
	}
	
	if(instance_place(x, y, oConfirmButton)) {
		selectedActor.state = "performAction";
		with(oConfirmButton) {
			instance_destroy();	
		}
	}
	
	if(instance_place(x, y, oRetryBox)) {
		with(oFadeLose) {
			finalize = true;	
		}
		with(oRetryBox) {
			instance_destroy();	
		}
	}
}

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
			wipe_buttons();
			wipe_nodes();
		}
		else {
			selectedActor.actions -= 1;
			wipe_buttons();
			wipe_nodes();
		}
		
		selectedActor = noone;
	} // End moveNode block
	
	if(selectedActor != noone && hoverNode.attackNode) {
		switch(selectedActor.attackType) {
			case "ranged":
				selectedActor.canAct = false;
				selectedActor.actions -= 1;
				selectedActor.attackTarget = hoverNode.occupant;
				selectedActor.state = "beginAttack";
				selectedActor.actionTimer = 10;
				selectedActor = noone;
				wipe_buttons();
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
					selectedActor.actionTimer = 10;
					selectedActor = noone;
					wipe_buttons();
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
					wipe_buttons();
					wipe_nodes();
				}
				
				break;
		}
	} // End attack node block
	
	if(hoverNode.actionNode) {
		selectedActor.state = "performAction";
		with(oConfirmBox) {
			instance_destroy();
		}
		with(oConfirmButton) {
			instance_destroy();	
		}
	}
}