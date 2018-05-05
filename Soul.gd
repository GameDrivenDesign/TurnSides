extends Spatial

var target
const SPEED = 5

func _physics_process(delta):
	if not target:
		translation += Vector3(0, SPEED  * delta, 0)
		if translation.y > 200:
			queue_free()
	
	if target:
		if translation.distance_to(target.translation):
			target.soul_collected()
			queue_free()
		else:
			translation = lerp(translation, target.translation, delta * SPEED)
