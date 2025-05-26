class_name WanderBehavior
extends SteeringBehavior

## Wander works by keeping an invisible target tied to a circle, kept at a
## set distance from the origin of the actor; it then offsets a point on that
## circle each frame, along the circle itself. The vector to that point is the
## wander impulse direction.

## Radius of the wander control circle.
@export var wander_radius := 1.0

## Distance forward of the origin of the wander circle
@export var wander_distance := 1.0

## Amount by which the wander coordinate may move each frame
@export var wander_jitter := 0.01

## Our specific point to direct toward
var wander_target : Vector3 = Vector3.ZERO

func _wander() -> Vector3:
	wander_target += Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)) * wander_jitter
	
	# Reproject onto unit sphere
	wander_target = wander_target.normalized() * wander_radius
	
	# Now, find the vector toward this point from agent origin.
	var target_local : Vector3 = wander_target + Vector3(wander_distance, 0.0, 0.0)
	return target_local

func Calculate(actor : Actor) -> Vector3:
	return _wander()
