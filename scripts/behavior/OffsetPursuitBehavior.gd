class_name OffsetPursuitBehavior
extends SteeringBehavior

@export var target : Actor
@export var offset : Vector3

func _offset_pursuit(actor : Actor) -> ArriveBehavior:
	var arrive := ArriveBehavior.new()
	
	var world_pos := target.global_position + offset #target.to_global(offset)
	var to_world_pos = world_pos - actor.global_position
	
	# Calculate the time offset necessary to reach this point
	var T := to_world_pos.length() / (actor.max_speed + target.speed)
	
	arrive.target = world_pos + T * target.velocity
	
	return arrive

func Calculate(actor : Actor) -> Vector3:
	return _offset_pursuit(actor).Calculate(actor)
