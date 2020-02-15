/// @description Insert description here
// You can write your code in this editor

if(emitting) {
	for(ii = 0; ii < 5; ii++) {
		instance_create_layer(x + irandom_range(-10, 10), y + irandom_range(-10, 10), "EffectsLayer", oFlame);	
	}
}