class_name SeekBehavior
extends SteeringBehavior

@export var target : Vector3 = Vector3.ZERO

func _seek(actor : Actor, target : Vector3) -> Vector3:
	var desired_velocity : Vector3 = (target - actor.position).normalized() \
		* actor.max_speed
	return desired_velocity - actor.velocity

func Calculate(actor : Actor) -> Vector3:
	return _seek(actor, target)
