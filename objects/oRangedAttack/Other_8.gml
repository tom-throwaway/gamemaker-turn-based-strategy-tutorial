/// @description Insert description here
// You can write your code in this editor

if(status != "miss") {
	target.hitPoints -= damage;	
	
	for(ii = 0; ii < 6; ii++) {
		with(instance_create_layer(target.x + 16, target.y + 16, "BiffLayer", oBiff)) {
			direction = irandom(360);
			speed = irandom_range(2, 4);
			scale = choose(2, 3);
			image_speed = 0.5;
			
			if(other.status == "crit") {
				color = c_yellow;
			}
		}
	}
	
	with(instance_create_layer(target.x + 28, target.y + 2, "TextLayer", oDamageText)) {
		text = "-" + string(other.damage);
		ground = y;
		
		if(other.status == "crit") {
			font = fCrit;	
		}
	}
	
	if(status == "crit") {
		target.shake = 8;
		target.shakeMag = 8;
	}
	else {
		target.shake = 4;
		target.shakeMag = 4;
	}
}
else {
	// Miss
	with(instance_create_layer(target.x + 28, target.y + 2, "TextLayer", oDamageText)) {
		text = "Miss";
		ground = y;
	}
}

instance_destroy();