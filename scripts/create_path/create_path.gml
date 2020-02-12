//argument0 - actor to create path for
//argument1 - destination node

current = argument1;
selectedActor = argument0;


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

// Destroy the path
ds_priority_destroy(path);