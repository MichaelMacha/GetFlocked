extends SteeringBehavior

@export var target : Actor
@export var obstacle_parent : Node

func _hide(actor : Actor) -> ArriveBehavior:
	# To handle hiding, we first need to identify hiding spots. This means,
	# we need to iterate over all obstructions under obstacle_parent
	# (they'll all be CollisionObject3D type).
	#
	# In the iteration, we find the vector between the target actor (who we're
	# hiding from) and the obstacle, and go beyond that by a set ratio to find
	# our hiding point.
	#
	# Then, we return an ArriveBehavior directed at the closest of the points.
	
	# NOTE: This will not function properly for collision objects with unusual,
	# non-origin-encompassing shapes; or shapes which occupy the point
	# behind them.
	
	#Get our hiding places first.
	var hiding_places : Array[Vector3] = []
	for obstacle in obstacle_parent.get_children():
		if obstacle is CollisionObject3D:
			var separation : Vector3 = (obstacle.global_position - \
				target.global_position) * 1.5
			hiding_places.append(obstacle.global_position + separation)
	
	var arrive := ArriveBehavior.new()
	
	if hiding_places.is_empty():
		arrive.target = actor.global_position
		return arrive
	
	#Find the closest hiding place to us.
	var hiding_place : Vector3 = Vector3.INF
	for place in hiding_places:
		var place_length = (place - actor.global_position).length()
		if place_length < (hiding_place - actor.global_position).length():
			hiding_place = place
			
	arrive.target = hiding_place
	return arrive
	

func Calculate(actor : Actor) -> Vector3:
	return _hide(actor).Calculate(actor)
