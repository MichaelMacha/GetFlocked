class_name ArriveBehavior
extends SteeringBehavior

@export var deceleration := 1.3

var target : Vector3 = Vector3.ZERO

func _arrive(actor : Actor, target : Vector3, deceleration : float):
	var to_target := (target - actor.position)
	
	# Calculate distance to target position
	var dist := to_target.length()
	
	if dist > 0:
		var speed := dist / deceleration
		
		# Ensure we aren't moving any faster than we should be capable
		speed = min(speed, actor.max_speed)
		
		# Proceed much like seek from here
		var desired_velocity := to_target * speed / dist
		
		return desired_velocity - actor.velocity
		
	return Vector3.ZERO

func Calculate(actor : Actor) -> Vector3:
	print("Arriving")
	return _arrive(actor, target, deceleration)
