extends Camera3D

@export var target : Actor
@export var follow_distance := 5.0
@export var follow_height := 3.0

func _process(delta: float) -> void:
	# Rotate to face lead
	if target:
		var current_rotation := self.rotation
		#var target_rotaiton := Quaternion.look_at(target.global_position)
		#var smooth_rotation := current_rotation.slerp(target_rotation, 0.1)
		self.look_at(target.global_position)
		
	# Follow lead
	var move_target := (target.global_position + 
		-target.heading * follow_distance +
		Vector3.UP * follow_height)
	self.global_position = lerp(self.global_position, move_target, 0.1)
