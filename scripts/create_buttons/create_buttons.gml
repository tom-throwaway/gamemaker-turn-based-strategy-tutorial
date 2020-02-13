//argument0 - actor whose buttons to create

actor = argument0;

buttonList = ds_list_create();

for(ii = 0; ii < ds_list_size(actor.defaultActions); ii++) {
	ds_list_add(buttonList, ds_list_find_value(actor.defaultActions, ii));
}

buttonY = room_height - 48;
buttonX = room_width / 2 - ((ds_list_size(buttonList) - 1) * 48);

for(ii = 0; ii < ds_list_size(buttonList); ii++) {
	button = ds_list_find_value(buttonList, ii);
	
	switch(button) {
		case "endTurn":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				sprite_index = sButtonEndTurn;
				title = "END TURN";
				text = "Finish turn of current character";
				hotKey = "X";
			}
			break;
	}
}

ds_list_destroy(buttonList);