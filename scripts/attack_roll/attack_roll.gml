function attack_roll(argument0, argument1) {
	//argument0 - id of actor making attack
	//argument1 - id of target

	actor = argument0;
	target = argument1;

	roll = actor.attackRoll;
	status = "miss";

	if(target.guidingBolt) {
		roll = max(roll, irandom_range(1, 20));
		target.guidingBolt = false;
	}

	if(actor.attackRoll == 20) {
		status = "crit";	
	}
	else {
		if(actor.blessed > 0) {
			roll += irandom_range(1, 4);	
		}
	
		if(roll + actor.hitBonus >= target.armourClass) {
			status = "hit";
		}
		else {
			status = "miss";	
		}
	}

	return status;


}
