function color_move_node(argument0, argument1, argument2) {
	//argument0 - node ID to color
	//argument1 - selected actors move
	//argument2 - selected actors actions

	var node, move, actions;

	node = argument0;
	move = argument1;
	actions = argument2;

	if(actions > 1) {
		if(node.G > move) {
			node.color = c_yellow;
		}
		else {
			node.color = c_aqua;	
		}
	}
	else {
		node.color = c_yellow;
	}




}
