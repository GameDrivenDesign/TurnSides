extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FIRE_GROUP = "FireElemental"
const WATER_GROUP = "WaterElemental"
const SPEED = 1
var damage = 20
var my_group

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	translate_object_local(delta * Vector3(0, 0, SPEED))

func shoot_at(position, from_group):
	my_group = from_group
	look_at(position, Vector3(0, 1, 0))

func _on_Projectile_body_entered(body):
	if ((body.is_in_group(FIRE_GROUP) and my_group) or 
		(body.is_in_group(WATER_GROUP) and my_group)):
		body.take_damage(damage)
		queue_free()