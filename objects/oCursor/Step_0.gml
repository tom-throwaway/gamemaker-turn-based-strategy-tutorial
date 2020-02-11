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
		
		// Create priority queue to reverse node chain
		// TODO - A stack would be a better choice
		path = ds_priority_create();
		ds_priority_add(path, current, current.G);
		while(current.parent != noone) {
			ds_priority_add(path, current.parent, current.parent.G);
			current = current.parent;
		}
		
		do {
			current = ds_priority_delete_min(path);
			// Add point to actors path
			path_add_point(selectedActor.movementPath, current.x, current.y, 100);
		}
		until(ds_priority_empty(path));
		ds_priority_destroy(path);
		
		// Clear the node of selected actor
		map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
		// Update actors grid coords
		selectedActor.gridX = gridX;
		selectedActor.gridY = gridY;
		
		// Update actors future node
		hoverNode.occupant = selectedActor;
		
		// Send actor on path
		selectedActor.state = "beginpath";
		
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
		selectedActor.canAct = false;
		selectedActor.actions -= 1;
		selectedActor.attackTarget = hoverNode.occupant;
		selectedActor.state = "beginAttack";
		selectedActor.attackTimer = 10;
		
		selectedActor = noone;
		wipe_nodes();
	}
}