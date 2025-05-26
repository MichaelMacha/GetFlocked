class_name PursuitBehavior
extends SteeringBehavior

@export var target : Actor

func _pursuit(actor : Actor, evader : Actor) -> SeekBehavior:
	var seek_behavior := SeekBehavior.new()
	var to_evader := (evader.position - actor.position)
	var relative_heading = actor.heading.dot(evader.heading)
	
	#Return a seek behavior to the intended look-ahead position
	seek_behavior.target = evader.position
	if !(to_evader.dot(actor.heading) > 0.0 && relative_heading < -0.95): #18°
		var look_ahead_time := to_evader.length() / (actor.max_speed + evader.speed)
		seek_behavior.target += evader.velocity * look_ahead_time
	
	return seek_behavior

func Calculate(actor : Actor) -> Vector3:
	return _pursuit(actor, target).Calculate(actor)
