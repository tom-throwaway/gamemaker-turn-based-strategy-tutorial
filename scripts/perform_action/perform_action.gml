//argument0 - actor performing the action
//argument1 - action to be performed

actor = argument0;
action = argument1;

switch(action) {
	// Default actions
	case "END TURN":
		actor.state = "endTurn";
		actor.actionTimer = 20;
		break;
		
	// Cleric spells
	case "Bless":
		targets = ds_list_create();
		with(oNode) {
			if(actionNode) {
				ds_list_add(other.targets, id);	
			}
		}
		
		for(ii = 0; ii < ds_list_size(targets); ii++) {
			target = ds_list_find_value(targets, ii).occupant;
			target.blessed = oGame.roundCounter + 5;
			with(instance_create_layer(target.x + 16, target.y + 16, "EffectsLayer", oBless)) {
				target = other.target;
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -= 1;
		actor.state = "endAction";
		actor.actionTimer = 15;
		break;
	
	case "Healing Word":
		target = oCursor.hoverNode.occupant;
		heal = irandom_range(1, 8) + actor.wisMod;
		heal = min(heal, target.maxHitPoints - target.hitPoints);
		target.hitPoints += heal;
		with(instance_create_layer(target.x + 28, target.y + 4, "TextLayer", oDamageText)) {
			ground = y;
			text = "+" + string(other.heal);
			color = c_lime;
		}
		
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "endAction";
		actor.actionTimer = 15;
		break;
	
	case "Guiding Bolt":
		target = oCursor.hoverNode.occupant;
		attackRoll = irandom_range(1, 20);
		attackStatus = attack_roll(actor, target);
		damageType = "radiant";
		tempDamage = 0;
		for(ii = 0; ii < 4; ii++) {
			tempDamage += irandom_range(1, 6);	
		}
		attackDir = point_direction(actor.x + 16, actor.y + 16, target.x + 16, target.y + 16);
		with(instance_create_layer(actor.x + 16, actor.y + 16, "EffectsLayer", oGuidingBolt)) {
			target = other.target;
			status = other.attackStatus;
			damage = other.tempDamage;
			path_add_point(movementPath, other.actor.x + 16, other.actor.y + 16, 100);
			if(status != "miss") {
				path_add_point(movementPath, target.x + 16, target.y + 16, 100);	
			}
			else {
				path_add_point(movementPath, target.x + 16 + (irandom_range(30, 50) * choose(-1, 1)), target.y + 16 + (irandom_range(30, 50) * choose(-1, 1)), 100);
			}
			
			path_start(movementPath, speed, true, true);
		}
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -= 1;
		actor.state = "endAction";
		actor.actionTimer = 30;
		break;
	
	
	// Wizard spells
	case "Acid Orb":
		target = oCursor.hoverNode.occupant;
		attackRoll = irandom_range(1, 20);
		attackStatus = attack_roll(actor, target);
		damageType = "acid";
		tempDamage = 0;
		for(ii = 0; ii < 3; ii++) {
			tempDamage += irandom_range(1, 10);	
		}
		attackDir = point_direction(actor.x + 16, actor.y + 16, target.x + 16, target.y + 16);
		with(instance_create_layer(actor.x + 16, actor.y + 16, "EffectsLayer", oAcidOrb)) {
			target = other.target;
			status = other.attackStatus;
			damage = other.tempDamage;
			path_add_point(movementPath, other.actor.x + 16, other.actor.y + 16, 100);
			if(status != "miss") {
				path_add_point(movementPath, target.x + 16, target.y + 16, 100);	
			}
			else {
				path_add_point(movementPath, target.x + 16 + (irandom_range(30, 50) * choose(-1, 1)), target.y + 16 + (irandom_range(30, 50) * choose(-1, 1)), 100);
			}
			
			path_start(movementPath, speed, true, true);
		}
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -= 1;
		actor.state = "endAction";
		actor.actionTimer = 30;
		break;
	
	case "Burning Hands":
		targets = ds_list_create();
		damage = 0;
		for(ii = 0; ii < 3; ii++) {
			damage += irandom_range(1, 6);
		}
		with(oNode) {
			if(actionNode) {
				ds_list_add(other.targets, id);	
			}
		}
		
		for(ii = 0; ii < ds_list_size(targets); ii++) {
			node = ds_list_find_value(targets, ii);
			with(instance_create_layer(node.x + 16, node.y + 16, "EffectsLayer", oFlameEmitter)) {
				target = other.node.occupant;
				saveDC = other.actor.spellSaveDC;
				damage = other.damage;
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -= 1;
		actor.state = "endAction";
		actor.actionTimer = 30;
		break;
	
	case "Magic Missiles":
		targets = ds_list_create();
		with(oNode) {
			if(actionNode) {
				ds_list_add(other.targets, id);	
			}
		}
		
		for(ii = 0; ii < ds_list_size(targets); ii++) {
			target = ds_list_find_value(targets, ii).occupant;
			with(instance_create_layer(other.actor.x + 16, other.actor.y + 16, "EffectsLayer", oArrow)) {
				target = other.target;
				status = "hit";
				damage = irandom_range(1, 4) + 1;
				damageType = "force";
				path_add_point(movementPath, other.actor.x + 16, other.actor.y + 16, 100);
				path_add_point(movementPath, other.target.x + 16, other.target.y + 16, 100);
				path_start(movementPath, speed, true, true);
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -= 1;
		actor.canAct = false;
		actor.actions -= 1;
		actor.state = "endAction";
		actor.actionTimer = 30;
		break;
}