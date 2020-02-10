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

// Draw the character details
if(selectedActor != noone) {
	tempText = selectedActor.name + " the " + selectedActor.race + " " + selectedActor.class;
	tempHitPoints = "HP: " + string(selectedActor.hitPoints) + " / " + string(selectedActor.maxHitPoints);
	tempHitBonus = "Hit bonus: " + string(selectedActor.hitBonus);
	
	draw_set_color(c_black);
	draw_rectangle(0, room_height, string_width(tempHitBonus), room_height - string_height(tempHitBonus), false);
	draw_rectangle(0, room_height - 16, string_width(tempHitPoints), room_height - 16 - string_height(tempHitPoints), false);
	draw_rectangle(0, room_height - 32, string_width(tempText), room_height - 32 - string_height(tempText), false);
	
	draw_set_color(c_white);
	draw_text(0, room_height - string_height(tempHitBonus), tempHitBonus);
	draw_text(0, room_height - 16 - string_height(tempHitPoints), tempHitPoints);
	draw_text(0, room_height - 32 - string_height(tempText), tempText);
}





