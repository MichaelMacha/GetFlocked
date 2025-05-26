class_name InterposeBehavior
extends SteeringBehavior

@export var target1 : Actor
@export var target2 : Actor

func _interpose(actor : Actor, target1 : Actor, target2 : Actor) -> ArriveBehavior:
	# Figure out where our two targets will be at a certain point in the future.
	# Approximate this by determining the time taken to reach their midpoint,
	# at max speed.
	var midpoint := (target1.global_position + target2.global_position) / 2.0
	var T := (midpoint - actor.global_position) / actor.max_speed
	
	var extrap1 := target1.global_position + target1.velocity * T
	var extrap2 := target2.global_position + target2.velocity * T
	
	midpoint = (extrap1 + extrap2) / 2.0
	
	var arrive := ArriveBehavior.new()
	arrive.target = midpoint
	return arrive

func Calculate(actor : Actor) -> Vector3:
	return _interpose(actor, target1, target2).Calculate(actor)
