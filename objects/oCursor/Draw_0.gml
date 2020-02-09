/// @description Insert description here
// You can write your code in this editor

if(hoverNode != noone) {
	draw_sprite(sSelected, -1, gridX * global.GRID_SIZE, gridY * global.GRID_SIZE); 	
} 

draw_self();

// Draw the current cursor location in top left if within screen
if(hoverNode != noone) {
	tempText = string(gridX) + " / " + string(gridY) + " = ";
	if(hoverNode.occupant != noone) {
		tempText += hoverNode.occupant.name;	
	}
	else {
		tempText += "noone";	
	}
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, string_width(tempText), string_height(tempText), false);
	draw_set_color(c_white);
	draw_text(0, 0, tempText);
	
	// Draw node type
	tempText = hoverNode.type;
	if(hoverNode.passable) {
		tempText += " passable=true cost=" + string(hoverNode.cost);	
	}
	
	draw_set_color(c_black);
	draw_rectangle(0, 20, string_width(tempText), string_height(tempText) + 20, false);
	draw_set_color(c_white);
	draw_text(0, 20, tempText);
}

// Draw the name of the selected node in the top right
if(selectedActor != noone) {
	draw_set_color(c_black);
	draw_rectangle(0, room_height - string_height(selectedActor.name), string_width(tempText), room_height, false);
	draw_set_color(c_white);
	draw_text(0, room_height - string_height(selectedActor.name), selectedActor.name);
}





