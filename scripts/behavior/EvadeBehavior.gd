class_name EvadeBehavior
extends SteeringBehavior

@export var target : Actor

func _evade(actor : Actor, evader : Actor) -> FleeBehavior:
	var flee_behavior := FleeBehavior.new()
	var to_evader := (evader.position - actor.position)
	var relative_heading = actor.heading.dot(evader.heading)
	
	#Return a seek behavior to the intended look-ahead position
	flee_behavior.target = evader.position
	if !(to_evader.dot(actor.heading) > 0.0 && relative_heading < -0.95): #18°
		var look_ahead_time := to_evader.length() / (actor.max_speed + evader.speed)
		flee_behavior.target += evader.velocity * look_ahead_time
	
	return flee_behavior


func Calculate(actor : Actor) -> Vector3:
	return _evade(actor, target).Calculate(actor)
