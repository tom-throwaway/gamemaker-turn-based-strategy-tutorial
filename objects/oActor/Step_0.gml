/// @description Insert description here
// You can write your code in this editor

shake -= 1;

switch(state) {
	case "beginpath":
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
		switch(attackType) {
			case "ranged":
				// Make the attack roll
				attackRoll = irandom_range(1, 20);
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
					
					if(attackStatus == "crit") {
						tempDamage += irandom_range(1, damageDice);
					}
				}
				
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