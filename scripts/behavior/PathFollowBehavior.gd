class_name PathFollowBehavior
extends SteeringBehavior

@export var path : Array[Vector3]
@export var looping := true
@export var seek_distance := 0.25

# Index should never be above-or-equal-to the total number of elements in path
var index := 0

func _path(actor : Actor) -> SteeringBehavior:
	# Track to the next point on the path, using our index
	var behavior : SteeringBehavior
	
	# Guard against breaking requests
	if path.is_empty():
		behavior = SeekBehavior.new()
		behavior.target = actor.global_position
		return behavior
	
	if index >= path.size():
		if looping:
			index = 0
		else:
			#Seek to our current location. There's probably a cleaner way
			#to do this, like a nullary.
			behavior = SeekBehavior.new()
			behavior.target = actor.global_position
			return behavior
	
	if index == path.size() - 1:
		behavior = ArriveBehavior.new()
		behavior.target = path[index]
	else:
		behavior = SeekBehavior.new()
		behavior.target = path[index]
	
	if path[index].distance_squared_to(actor.global_position) < seek_distance:
		index += 1
	
	return behavior
func Calculate(actor : Actor) -> Vector3:
	return _path(actor).Calculate(actor)
