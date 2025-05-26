class_name WallAvoidanceBehavior
extends SteeringBehavior

func _wall_avoidance(actor : Actor) -> Vector3:
	var rhand : RayCast3D = actor.get_node("Side Whiskers/RHandAvoidance")
	var lhand : RayCast3D = actor.get_node("Side Whiskers/LHandAvoidance")
	
	var current : Vector3 = Vector3.INF
	var deflector : RayCast3D = null
	
	if rhand.is_colliding():
		var relative = (rhand.get_collision_point() - actor.global_position)
		if relative.length() < current.length():
			current = relative
			deflector = rhand
	if lhand.is_colliding():
		var relative = (lhand.get_collision_point() - actor.global_position)
		if relative.length() < current.length():
			current = relative
			deflector = lhand
	
	if deflector:
		return deflector.get_collision_normal() * (deflector.target_position - current).length()
	
	return Vector3.ZERO

func Calculate(actor : Actor) -> Vector3:
	return _wall_avoidance(actor)
