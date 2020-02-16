/// @description Insert description here
// You can write your code in this editor

shake -= 1;

if(hitPoints <= 0) {
	map[gridX, gridY].occupant = noone;
	if(oGame.currentActor == id) {
		oGame.currentActor = noone;
		oCursor.selectedActor = noone;
	}
	with(instance_create_layer(x, y, "ActorLayer", oDying)) {
		sprite_index = other.sprite_index;	
	}
	instance_destroy();	
}

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
		
		state = "findTarget";
		break;
	
	case "findTarget":
		attackTarget = noone;
		node = map[gridX, gridY];
		
		targetList = ds_list_create();
		for(ii = 0; ii < ds_list_size(node.neighbours); ii++) {
			neighbour = ds_list_find_value(node.neighbours, ii);
			if(neighbour.occupant != noone) {
				if(neighbour.occupant.army == global.BLUE_ARMY) {
					//attackTarget = neighbour.occupant;
					ds_list_add(targetList, neighbour.occupant);
				}
			}
		}
		
		if(ds_list_size(targetList) > 0) {
			roll = irandom_range(1, 20);
			
			// Attack the most hurt target if we pass an int check
			if(roll + intMod > 10) {
				healthRatio = 1;
				
				for(ii = 0; ii < ds_list_size(targetList) - 1; ii++) {
					tempTarget = ds_list_find_value(targetList, ii);
					if(tempTarget.hitPoints / tempTarget.maxHitPoints < healthRatio) {
						attackTarget = tempTarget;
						healthRatio = tempTarget.hitPoints / tempTarget.maxHitPoints;
					}
				}
			}
			
			// If we still haven't selected a target, choose one at random
			if(attackTarget == noone) {
				attackTarget = ds_list_find_value(targetList, irandom_range(0, ds_list_size(targetList) - 1));
			}
		}
		
		ds_list_destroy(targetList);
		
		if(attackTarget != noone) {
			state = "attack";
			actionTimer = 10;
		}
		else {
			state = "findMoveNode";
		}
		
		break;
	
	case "findMoveNode":
		heroList = ds_priority_create();
		with(oActor) {
			if(army == global.BLUE_ARMY) {
				ds_priority_add(other.heroList, id, point_distance(x, y, other.x, other.y));	
			}
		}
		
		closestNode = noone;
		while(closestNode == noone) {
			targetHero = ds_priority_delete_min(heroList);
			targetNode = map[targetHero.gridX, targetHero.gridY];
			for(ii = 0; ii < ds_list_size(targetNode.neighbours); ii++) {
				// TODO Improvement - This selects a node adjacent to the target, but not the closest node adjacent to the target
				currentNode = ds_list_find_value(targetNode.neighbours, ii);
				if(currentNode.occupant == noone && currentNode.passable) {
					closestNode = currentNode;	
				}
			}
			
			if(ds_priority_size(heroList) <= 0) {
				targetHero = noone;
				flash = true;
				alarm[0] = 30;
				state = "idle";
				break;
			}
		}
		
		ds_priority_destroy(heroList);
		
		if(targetHero != noone) {
			ai_movement(map[gridX, gridY], closestNode);
			
			while(closestNode.G > move * actions) {
				closestNode = closestNode.parent;	
			}
			
			create_path(id, closestNode);
			
			map[gridX, gridY].occupant = noone;
			gridX = closestNode.gridX;
			gridY = closestNode.gridY;
			closestNode.occupant = id;
			
			state = "beginPath";
			if(closestNode.G > move) {
				actions -= 2;	
			}
			else {
				actions -= 1;	
			}
		}
		wipe_nodes();
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
			oGame.currentActor = noone;
			state = "idle";
		}
		break;
}