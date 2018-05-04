extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FIRE_GROUP = "FireElemental"
const WATER_GROUP = "WaterElemental"
var damage = 20

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Projectile_body_entered(body):
	if ((body.is_in_group(FIRE_GROUP) and self.is_in_group(WATER_GROUP)) or 
		(body.is_in_group(WATER_GROUP) and self.is_in_group(FIRE_GROUP))):#error
		body.take_damage(damage)
	pass # replace with function body
