/// @description Insert description here
// You can write your code in this editor

shake -= 1;

switch(state) {
	case "initializeTurn":
		if(blessed > oGame.roundCounter) {
			with(instance_create_layer(x, y, "EffectsLayer", oBless)) {
				target = other;	
			}
		}
		else {
			blessed = 0;	
		}
		
		if(acidBurn > 0) {
			damage = irandom_range(1, 4);
			with(instance_create_layer(x + 28, y + 2, "TextLayer", oDamageText)) {
				text = "-" + string(other.damage);
				ground = y;
			}
			hitPoints -= damage;
			acidBurn -= 1;
		}
		
		if(army == global.BLUE_ARMY) {
			movement_range(map[gridX, gridY], move, actions);
			switch(attackType) {
				case "melee":
					melee_attack_range(id);
					break;
				
				case "ranged":
					ranged_attack_range(id);
					break;
			}
			
			oCursor.selectedActor = id;
		}
		else {
			flash = true;
			alarm[0] = 30;
		}
		
		state = "ready";
		break;
		
	case "beginPath":
		path_start(movementPath, moveSpeed, 0, true);
		state = "moving";
		break;
		
	case "beginAttack":
		actionTimer -= 1;
		if(actionTimer <= 0) {
			state = "attack";
		}
		break;
		
	case "attack":
		// Make the attack roll
		attackRoll = irandom_range(1, 20);
		
		// Determine whether this is a sneak attack
		applySneakAttack = false;
		if(sneakAttack) {
			tempNode = map[attackTarget.gridX, attackTarget.gridY];
			
			for(ii = 0; ii < ds_list_size(tempNode.neighbours); ii++) {
				current	= ds_list_find_value(tempNode.neighbours, ii++);
				if(current.occupant != noone) {
					if(current.occupant.army != attackTarget.army) {
						applySneakAttack = true;	
					}
				}
			}
		}
		
		// Determine outcome of attack
		attackStatus = attack_roll(id, attackTarget);
				
		// Make the damage roll
		tempDamage = 0;
		if(attackStatus != "miss") {
			tempDamage = irandom_range(1, damageDice) + damageBonus;
			
			if(applySneakAttack) {
				tempDamage += irandom_range(1, sneakAttackDamage);	
			}
					
			if(attackStatus == "crit") {
				tempDamage += irandom_range(1, damageDice);
				
				if(applySneakAttack) {
					tempDamage += irandom_range(1, sneakAttackDamage);	
				}
			}
		}
				
		switch(attackType) {
			case "ranged":
				attackDir = point_direction(x + 16, y + 16, attackTarget.x + 16, attackTarget.y + 16);
				beginX = x + 16 + lengthdir_x(30, attackDir);
				beginY = y + 16 + lengthdir_y(30, attackDir);
				
				with(instance_create_layer(beginX, beginY, "ActorLayer", oArrow)) {
					target = other.attackTarget;
					status = other.attackStatus;
					damage = other.tempDamage;
					damageType = other.damageType;
					
					path_add_point(movementPath, other.beginX, other.beginY, 100);
					if(status != "miss") {
						path_add_point(movementPath, target.x + 16, target.y + 16, 100);
					}
					else {
						path_add_point(movementPath, target.x + 16 + (irandom_range(30, 50) * choose(-1, 1)), target.y + 16 + (irandom_range(30, 50) * choose(-1, 1)), 100);
					}
					
					path_start(movementPath, speed, true, true);
				}
				
				state = "endAttack";
				actionTimer = 30;
				break;
			
			case "melee":
				if(attackStatus != "miss") {
					for(ii = 0; ii < 6; ii++) {
						with(instance_create_layer(attackTarget.x + 16, attackTarget.y + 16, "EffectsLayer", oBiff)) {
							direction = irandom(360);
							speed = choose(2, 4);
							scale = choose(2, 3);
							image_speed = 0.5;
							
							if(other.attackStatus == "crit") {
								color = c_yellow;	
							}
						}
					}
					
					if(attackStatus == "crit") {
						attackTarget.shake = 8;
						attackTarget.shakeMag = 8;
					}
					else {
						attackTarget.shake = 4;
						attackTarget.shakeMag = 4;
					}
					
					attackTarget.hitPoints -= tempDamage;
					
					with(instance_create_layer(attackTarget.x + 28, attackTarget.y + 2, "TextLayer", oDamageText)) {
						text = "-" + string(other.tempDamage);
						ground = y;
						
						if(other.attackStatus == "crit") {
							font = fCrit;
						}
					}
				}
				else {
					// Miss
					with(instance_create_layer(attackTarget.x + 28, attackTarget.y + 2, "TextLayer", oDamageText)) {
						text = "miss";
						ground = y;
					}
				}
				
				state = "endAttack";
				actionTimer = 10;
				break;
		}
		break;
		
	case "endAttack":
		actionTimer -= 1;
		if(actionTimer <= 0) {
			if(actions > 0) {
				oCursor.selectedActor = id;
				movement_range(map[gridX, gridY], move, actions);
			}
			else {
				oGame.currentActor = noone;
			}
			
			state = "idle";
		}
		break;
		
	case "beginAction":
		wipe_nodes();
		action_targeting(id, targetingType, actionRange);
		break;
		
	case "performAction":
		perform_action(id, readiedAction);
		wipe_nodes();
		break;
	
	case "endAction":
		actionTimer -= 1;
		if(actionTimer <= 0) {
			state = "idle";
			if(actions > 0) {
				movement_range(map[gridX, gridY], move, actions);
			}
			else {
				state = "idle";
				oCursor.selectedActor = noone;
				oGame.currentActor = noone;
			}
		}
		break;
	
	case "endTurn":
		actionTimer -= 1;
		if(actionTimer <= 0) {
			oCursor.selectedActor = noone;
			oGame.currentActor = noone;
			state = "idle";
		}
		break;
}