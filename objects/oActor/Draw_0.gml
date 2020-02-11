 /// @description Insert description here
// You can write your code in this editor

// If cursor is hovering over a different node to actors
if(oCursor.selectedActor == id) {
	if(oCursor.hoverNode != noone) {
		tempNode = oCursor.hoverNode;
		
		if(tempNode.moveNode) {
			current = oCursor.hoverNode;
	
			// Step through nodes in the chain until reaching the actor
			while(current.parent != noone) {
				draw_line_width_color(current.x + 16, current.y + 16, current.parent.x + 16, current.parent.y + 16, 4, c_lime, c_lime);	
				current = current.parent;
			}
		}


		if(tempNode.attackNode) {
			switch(attackType) {
				case "ranged":
					draw_line_width_color(x + 16, y + 16, tempNode.x + 16, tempNode.y + 16, 4, c_purple, c_purple);
					break;
			}
		}
	}
}

draw_self();