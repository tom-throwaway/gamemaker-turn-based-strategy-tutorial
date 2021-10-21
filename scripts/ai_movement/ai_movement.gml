function ai_movement(argument0, argument1) {
	//argument0 - start node
	//argument1 - goal node

	start = argument0;
	goal = argument1;

	with(oNode) {
		parent = noone;
		G = 0;
	}

	open = ds_priority_create();
	closed = ds_list_create();

	ds_priority_add(open, start, 0);
	ds_list_add(closed, start);

	while(ds_priority_size(open) > 0) {
		current = ds_priority_delete_min(open);
	
		if(current == goal) {
			break;	
		}
	
		for(ii = 0; ii < ds_list_size(current.neighbours); ii++) {
			neighbour = ds_list_find_value(current.neighbours, ii);
			if(neighbour.occupant == noone && neighbour.passable) {
				costMod = 1;
			
				// Diagonals cost 1.5
				if(neighbour.x != current.x && neighbour.y != current.y) {
					costMod = 1.5;	
				}
			
				tempCost = neighbour.cost * costMod;
				tempCost += current.G;
			
				// If the neighbour is not closed or the new path is more efficient
				if(ds_list_find_index(closed, neighbour) < 0 || tempCost < neighbour.G) {
					neighbour.G = tempCost;
					priority = tempCost + heuristic(goal, neighbour);
					ds_priority_add(open, neighbour, priority);
					neighbour.parent = current;
					ds_list_add(closed, neighbour);
				}
			}
		}
	}

	while(ds_priority_size(open) > 0) {
		current = ds_priority_delete_min(open);
	
		for(ii = 0; ii < ds_list_size(current.neighbours); ii++) {
			neighbour = ds_list_find_value(current.neighbours, ii);
			if(neighbour.occupant == noone && neighbour.passable) {
				costMod = 1.5;	// Why?
			}
		
			tempCost = neighbour.cost * costMod;
			tempCost += current.G;
			if(ds_list_find_index(closed, neighbour) < 0 || tempCost < neighbour.G) {
				neighbour.G = tempCost;
				neighbour.parent = current;
				ds_list_add(closed, neighbour);
			}
		}
	}

	ds_priority_destroy(open);
	ds_list_destroy(closed);


}
