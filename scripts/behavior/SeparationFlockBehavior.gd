class_name SeparationFlockBehavior
extends SteeringBehavior

@export var flock_radius := 1.0

func _separate(actor : Actor, actors : Node) -> Vector3:
	var steering : Vector3 = Vector3.ZERO
	
	for child in actors.get_children():
		if child.global_position == actor.global_position:
			# Avoid infinite loops 
			continue
		if child is Actor:
			var to_actor : Vector3 = child.global_position - actor.global_position
			if to_actor.length() < flock_radius:
				# Steering force should be proportional to distance:
				#steering += to_actor.normalized()/to_actor.length()
				steering += -to_actor.normalized() * flock_radius
				pass
	
	return steering

func Calculate(actor : Actor) -> Vector3:
	return _separate(actor, $/root/World/Actors)
