## An actor class which implements the autonomous motion techniques in chapter
## three of Mat Buckland's "Programming Game AI by Example".
##
## This inherits from CharacterBody3D, which means that many of the basic
## fields, such as velocity, are already present

class_name Actor
extends CharacterBody3D

## Basic mass, in kilograms. Used instead of Rigidbody for finer controls.
@export var mass : float = 1.0
@export var max_speed : float = 1.0
@export var max_force : float = 1.0
@export var max_turn_rate : float = PI #180°

@onready var steering := $SteeringBehaviors

const HEADING_CRITICAL_VELOCITY := 0.00001

var speed : float:
	get:
		return velocity.length()
	set(value):
		velocity = velocity.normalized() * value

var heading : Vector3:
	set(value):
		basis.z = -value
	get:
		return -basis.z

var side : Vector3:
	get:
		return basis.x

func _physics_process(delta: float) -> void:
	# Guards
	if velocity == Vector3.ZERO:
		velocity = -basis.z
	
	var steering_force := Vector3.ZERO
	#for behavior in steering:
	for behavior in steering.get_children():
		if behavior.enabled:
			var force = behavior.Calculate(self)
			steering_force += force
	
	var acceleration : Vector3 = steering_force / mass
	velocity += acceleration * delta
	
	#NOTE: subject to update for customization
	#Update heading if vehicle has a non-trivial velocity
	if velocity.length_squared() > HEADING_CRITICAL_VELOCITY:
		basis = Basis.looking_at(velocity)
	
	speed = min(max_speed, speed)
	
	move_and_slide()
