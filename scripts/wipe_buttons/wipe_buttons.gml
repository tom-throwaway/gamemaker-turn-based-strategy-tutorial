function wipe_buttons() {

	with(oButton) {
		instance_destroy();	
	}

	oCursor.hoverButton = noone;


}
