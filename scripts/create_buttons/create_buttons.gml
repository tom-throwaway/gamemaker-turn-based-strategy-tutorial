//argument0 - actor whose buttons to create

actor = argument0;

buttonList = ds_list_create();

// Add spell buttons
if(actor.canAct) {
	if(actor.firstLevelSlot > 0) {
		for(ii = 0; ii < ds_list_size(actor.firstLevelSpellList); ii++) {
			ds_list_add(buttonList, ds_list_find_value(actor.firstLevelSpellList, ii));
		}
	}
}

// Add default buttons
for(ii = 0; ii < ds_list_size(actor.defaultActions); ii++) {
	ds_list_add(buttonList, ds_list_find_value(actor.defaultActions, ii));
}

buttonY = room_height - 48;
buttonX = room_width / 2 - ((ds_list_size(buttonList) - 1) * 48);

for(ii = 0; ii < ds_list_size(buttonList); ii++) {
	button = ds_list_find_value(buttonList, ii);
	
	switch(button) {
		// Default actions
		case "endTurn":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				sprite_index = sButtonEndTurn;
				title = "END TURN";
				text = "Finish turn of current character";
				hotKey = "X";
			}
			break;
		// Cleric spells
		case "Bless":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "BLESS";
				text = "Give all party members a small bonus to attack and save rolls (5 rounds)";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
			
		case "Healing Word":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "HEALING WORD";
				text = "Right click an ally in range to heal them #1D8" + string(other.actor.wisMod) + " HEALING";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
		
		case "Guiding Bolt":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "GUIDING BOLT";
				text = "Right click an emeny to fire an illuminating bolt #4D6 RADIANT DAMAGE #ADVANTAGE ON NEXT ATTACK";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
		
		// Wizard spells
		case "Acid Orb":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "ACID ORB";
				text = "Right click an enemy to fire an orb of deadly acid! #3D10 ACID DAMAGE #ONGOING BURN";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
			
		case "Burning Hands":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "BURNING HANDS";
				text = "Right click a square in range to create a cone of flame! #3D6 fire damage (AOE)";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
		
		case "Magic Missiles":
			with(instance_create_layer(buttonX + (ii * 96), buttonY, "ButtonLayer", oButton)) {
				//sprite_index = sButtonEndTurn;
				title = "MAGIC MISSILES";
				text = "Fire a magic missile at each visible enemy #1D4+1 FORCE DAMAGE";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
	}
}

ds_list_destroy(buttonList);