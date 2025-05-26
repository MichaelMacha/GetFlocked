class_name FollowActor
extends Actor

@export var followed : Actor:
	set(value):
		followed = value
		$"SteeringBehaviors/Offset Pursuit".target = followed
		$SteeringBehaviors/Pursue.target = followed
	get:
		return followed

@export var offset := Vector3.ZERO:
	set(value):
		offset = value
		$"SteeringBehaviors/Offset Pursuit".offset = offset
	get:
		return offset

func _ready() -> void:
	followed = followed
	offset = offset


func _on_squawk_detector_body_exited(body: Node3D) -> void:
	print("Squawk")
	$Squawk.pitch_scale = randf_range(0.8, 1.68)
	$Squawk.play()
