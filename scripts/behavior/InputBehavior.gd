class_name InputBehavior
extends SteeringBehavior

## This class is very similar to WanderBehavior, but polls user input
## to control the target, instead of using noise.

## Radius of the wander control circle.
@export var wander_radius := 1.0

## Distance forward of the origin of the wander circle
@export var wander_distance := 1.0

## Amount by which the wander coordinate may move each frame
@export var wander_jitter := 0.01

## Our specific point to direct toward
var wander_target : Vector3 = Vector3.ZERO

var delta := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion : InputEventMouseMotion = event
		delta = motion.velocity
		delta.x *= (PI/2400.0)/6.0
		delta.y *= (PI/2400.0)/3.0
		#print(delta)
		
func Calculate(actor : Actor) -> Vector3:
	#print("Delta: ", delta)
	#print("Rotation: ", actor.rotation)
	var v := actor.velocity
	v = v.rotated(actor.basis.x, delta.y)
	v = v.rotated(actor.basis.y, delta.x)
	actor.velocity = v
	#actor.rotate_x(delta.y)
	#actor.heading = actor.heading.rotated(actor.basis.x, 10.0)
	
	#Adjust heading
	#var x_rot = actor.rotation.x + delta.y
	#if abs(x_rot) > PI / 6.0:
		#x_rot = (PI / 6.0) * sign(x_rot)
	#actor.rotation.x = x_rot
	#
	#actor.rotate_y(delta.x)
	#print("Rotation: ", actor.rotation, "\n")
	
	delta = Vector2.ZERO
	
	#Add impulse
	#print("Speed: ", actor.speed)
	actor.speed = actor.max_speed
	
	return Vector3.ZERO
	#return _wander()
