class_name AlignmentFlockBehavior
extends SteeringBehavior

@export var flock_radius := 1.0

func _alignment(actor : Actor, actors : Node) -> Vector3:
	var average_heading := Vector3.ZERO
	
	# Get the average heading of all neighbors within flocking radius
	var count := 0.0
	for child in actors.get_children():
		if child == actor:
			# Avoid infinite loops 
			continue
		if child is Actor:
			average_heading += child.heading
			count += 1.0
	
	if count > 0:
		average_heading /= count
		average_heading -= actor.heading
	
	return average_heading

func Calculate(actor : Actor) -> Vector3:
	# This one is a little quirky, as we're averaging a heading and not
	# technically applying a force. This is a little uncomfortable to me,
	# because it means we're intentionally leaning on a side-effect. However,
	# we can come back to that later if it becomes an issue; I just need
	# to keep it modular and accessible enough to efficiently change.
	actor.heading = _alignment(actor, $/root/World/Actors)
	return Vector3.ZERO
