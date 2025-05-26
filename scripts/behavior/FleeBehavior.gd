class_name FleeBehavior
extends SteeringBehavior

# NOTE: It may be better to have target be an actual transform, in many cases.
# Consider this.
@export var target : Vector3 = Vector3.ZERO

func _flee(actor : Actor, target : Vector3) -> Vector3:
	var desired_velocity : Vector3 = (actor.position - target).normalized() \
		* actor.max_speed
	return desired_velocity - actor.velocity

func Calculate(actor : Actor) -> Vector3:
	return _flee(actor, target)
