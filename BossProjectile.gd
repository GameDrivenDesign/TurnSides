extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SPEED = 10
var damage = 100
var penetrationPower = 3

func _ready():
	yield(get_tree().create_timer(10), "timeout")
	queue_free()

func _physics_process(delta):
	translate(delta * Vector3(0, 0, -SPEED))

func shoot_at(from_position, to_position):
	look_at_from_position(from_position, to_position, Vector3(0, 1, 0))

func _on_Projectile_body_entered(body):
	if(body.is_in_group("WaterElemental") or body.is_in_group("FireElemental")):
		if(not body.is_in_group("BigBoss")):
			body.takeDamage(damage)
			penetrationPower -= 1
	if(penetrationPower <= 0):
		queue_free()
	if(body.is_in_group("Rock")):
		queue_free()