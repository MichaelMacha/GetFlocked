class_name CohesionFlockBehavior
extends SteeringBehavior

func _cohere(actor : Actor, actors : Node) -> SeekBehavior:
	var center_of_mass : Vector3
	var behavior := SeekBehavior.new()
	behavior.target = actor.global_position
	
	# Get our center of mass by averaging
	var count := 0.0
	for child in actors.get_children():
		if actor == child:
			continue
		if child is Actor:
			center_of_mass += child.global_position * child.mass
			count += 1.0
	
	if count > 0:
		center_of_mass /= count
		behavior.target = center_of_mass
	
	return behavior

func Calculate(actor : Actor) -> Vector3:
	return _cohere(actor, $/root/World/Actors).Calculate(actor)
