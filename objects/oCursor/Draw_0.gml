/// @description Insert description here
// You can write your code in this editor

draw_self();

if(hoverButton != noone && buttonTimer > 15) {
	tempTitle = hoverButton.title;
	tempText = hoverButton.text;
	
	draw_set_font(fCrit);
	
	heightY = string_height(tempTitle) + string_height(tempText);
	draw_set_color(c_black);
	
	draw_rectangle(x + 20, y - heightY, x + 20 + string_width(tempTitle), y - heightY + string_height(tempTitle), false);
	
	draw_set_color(c_white);
	draw_text(x + 20, y - heightY, tempTitle);
	
	draw_set_font(fDefault);
	draw_set_color(c_black);
	
	draw_rectangle(x + 20, y - string_height(tempText), x + 20 + string_width(tempText), y, false);
	draw_set_color(c_white);
	
	draw_text(x + 20, y - string_height(tempText), tempText);
}

// Draw the character details
if(selectedActor != noone) {
	tempText = selectedActor.name + " the " + selectedActor.race + " " + selectedActor.class;
	tempHitPoints = "HP: " + string(selectedActor.hitPoints) + " / " + string(selectedActor.maxHitPoints);
	tempHitBonus = "Hit bonus: " + string(selectedActor.hitBonus);
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, string_width(tempText), string_height(tempText), false);
	draw_rectangle(0, 16, string_width(tempHitPoints), 16 + string_height(tempHitPoints), false);
	draw_rectangle(0, 32, string_width(tempHitBonus), 32 + string_height(tempHitBonus), false);
	
	draw_set_color(c_white);
	draw_text(0, 0, tempText);
	draw_text(0, 16, tempHitPoints);
	draw_text(0, 32, tempHitBonus);
}





