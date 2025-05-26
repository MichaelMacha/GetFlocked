class_name SteeringBehavior
extends Node

@export var enabled := true

## Determine and return the force vector which follows the rules
## of this behavior.
func Calculate(actor : Actor) -> Vector3:
	return Vector3.ZERO
