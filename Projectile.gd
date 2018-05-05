extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FIRE_GROUP = "FireElemental"
const WATER_GROUP = "WaterElemental"
const SPEED = 10
var damage = 20
var my_group

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	translate(delta * Vector3(0, 0, -SPEED))

func shoot_at(from_position, to_position, from_group):
	my_group = from_group
	#translation = from_position
	look_at_from_position(from_position, to_position, Vector3(0, 1, 0))

func _on_Projectile_body_entered(body):
	if ((body.is_in_group(FIRE_GROUP) and my_group == WATER_GROUP) or 
		(body.is_in_group(WATER_GROUP) and my_group == FIRE_GROUP)):
		body.takeDamage(damage)
		queue_free()