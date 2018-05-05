extends Spatial

var target
var type
const SPEED = 1
const RAISE_SPEED = 100

func _physics_process(delta):
	if not target:
		translation += Vector3(0, RAISE_SPEED  * delta, 0)
		if translation.y > 200:
			queue_free()
	
	if target:
		if translation.distance_to(target.translation) < 1:
			target.collect_soul(type)
			queue_free()
		else:
			translation = translation.linear_interpolate(target.translation, delta * SPEED)
