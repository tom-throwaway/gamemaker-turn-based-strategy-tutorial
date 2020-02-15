/// @description Insert description here
// You can write your code in this editor

if(finalize) {
	if(alpha <= 1) {
		alpha += 0.05;
	}
	else {
		room_restart();	
	}
}
else {
	if(alpha < 0.8) {
		alpha += 0.05;	
	}
	else {
		if(!instance_exists(oRetryBox)) {
			instance_create_layer(room_width / 2, room_height / 2, "ButtonLayer", oRetryBox);	
		}
	}
}

