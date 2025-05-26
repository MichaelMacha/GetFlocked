extends Node3D

func _on_goal_area_body_entered(body: Node3D) -> void:
	print("GOAL!")
	$/root/World/Universals/Status.increment_score()
	var bang := preload("res://scenes/splash.tscn").instantiate()
	$/root/World.add_child(bang)
	bang.global_position = body.global_position + body.velocity * 0.25 #- body.velocity * 1.0
	pass # Replace with function body.
