//argument0 - origin node
//argument1 - unit movement
//argument2 - unit actions

// Reset all node data
wipe_nodes();

var open, closed;
var start, current, neighbour;
var tempG, range, costMod;

// Declare variables from arguments
start = argument0;
range = argument1 * argument2;

// Create data structures
open = ds_priority_create();
closed = ds_list_create();

// Add starting node to open list
ds_priority_add(open, start, start.G);

// While open queue not empty
while(ds_priority_size(open) > 0) {
	// Remove node with lowest G score from open and add to closed
	current = ds_priority_delete_min(open);
	ds_list_add(closed, current);
	
	// Step through currents neighbours
	for(ii = 0; ii < ds_list_size(current.neighbours); ii++) {
		// Store current neighbour
		neighbour = ds_list_find_value(current.neighbours, ii);
		
		// Add neighbour to open list if it qualifies
		// TODO - Check if already on open list?
		if(
			ds_list_find_index(closed, neighbour) < 0 &&
			neighbour.passable &&
			neighbour.occupant == noone &&
			neighbour.cost + current.G <= range
		) {
			// Calculate G if it has not already been calculated
			if(
				ds_priority_find_priority(open, neighbour) == 0 ||
				ds_priority_find_priority(open, neighbour) == undefined
			) {
				costMod = 1;
				neighbour.parent = current;
				
				// If neighbour is diagonal adjust costMod
				if(neighbour.gridX != current.gridX && neighbour.gridY != current.gridY) {
					costMod = 1.5;	
				}
				
				// Calculate G score
				neighbour.G = current.G + (neighbour.cost * costMod);
				
				// Add neighbour to open list
				ds_priority_add(open, neighbour, neighbour.G);
			}
			// If neighbours score has already been calculated figure out if it's G score from current node would be lower
			else {
				costMod = 1;
				
				// If neighbour is diagonal adjust costMod
				if(neighbour.gridX != current.gridX && neighbour.gridY != current.gridY) {
					costMod = 1.5;	
				}
				
				tempG = current.G + (neighbour.cost * costMod);
				
				if(tempG < neighbour.G) {
					neighbour.parent = current;
					neighbour.G = tempG;
					ds_priority_change_priority(open, neighbour, neighbour.G);
				}
			}
		}
	}
}

// Round down all G scores
with(oNode) {
	G = floor(G);	
}

// Destroy open
ds_priority_destroy(open);

// Color move nodes
for(ii = 0; ii < ds_list_size(closed); ii++) {
	current = ds_list_find_value(closed, ii);
	current.moveNode = true;
	color_move_node(current, argument1, argument2);
}

// Destory closed
ds_list_destroy(closed);




















