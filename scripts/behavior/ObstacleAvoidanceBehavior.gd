class_name ObstacleAvoidanceBehavior
extends SteeringBehavior

@export var magnitude := 0.1

func _obstacle_avoidance(actor : Actor) -> Vector3:
	
	var rhand : RayCast3D = actor.get_node("Forward Whiskers/RHandAvoidance")
	var lhand : RayCast3D = actor.get_node("Forward Whiskers/LHandAvoidance")
	
	var magnitude := 0.1
	
	var sway : Vector3 = Vector3.ZERO
	var brake : Vector3 = Vector3.ZERO
	if rhand.is_colliding():
		# Handle lateral force
		var subject := rhand.get_collider()
		if subject is Obstacle:
			sway += actor.side * magnitude

			# Handle brake force
			var dist := (rhand.get_collision_point() - rhand.global_position).length()
			dist /= rhand.target_position.length()
			dist = 1.0 - dist
			sway += -actor.velocity * dist
	elif lhand.is_colliding():
		var subject := lhand.get_collider()
		if subject is Obstacle:
			sway -= actor.side * magnitude
			
			# Handle brake force
			var dist := (rhand.get_collision_point() - rhand.global_position).length()
			dist /= rhand.target_position.length()
			dist = 1.0 - dist
			sway += -actor.velocity * dist
	
	
	return sway

func Calculate(actor : Actor) -> Vector3:
	return _obstacle_avoidance(actor)
