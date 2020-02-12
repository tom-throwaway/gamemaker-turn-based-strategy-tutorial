/// @description Insert description here
// You can write your code in this editor

shake -= 1;

switch(state) {
	case "beginPath":
		path_start(movementPath, moveSpeed, 0, true);
		state = "moving";
		break;
		
	case "beginAttack":
		attackTimer -= 1;
		if(attackTimer <= 0) {
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
		if(attackRoll == 20) {
			attackStatus = "crit";	
		}
		else {
			if(attackRoll + hitBonus >= attackTarget.armourClass) {
				attackStatus = "hit";	
			}
			else {
				attackStatus = "miss";	
			}
		}
				
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
				attackTimer = 30;
				break;
			
			case "melee":
				if(attackStatus != "miss") {
					for(ii = 0; ii < 6; ii++) {
						with(instance_create_layer(attackTarget.x + 16, attackTarget.y + 16, "BiffLayer", oBiff)) {
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
				attackTimer = 10;
				break;
		}
		break;
		
	case "endAttack":
		attackTimer -= 1;
		if(attackTimer <= 0) {
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
}