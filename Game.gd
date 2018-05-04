extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	spawnFire(Vector3(0,0,0))
	spawnFire(Vector3(5,0,-3))
	spawnFire(Vector3(-3,0,3))
	spawnWater(Vector3(0,0,0))
	spawnWater(Vector3(3,0,-3))
	spawnWater(Vector3(-5,0,3))

func spawnFire(offset):
	var fire = preload("res://FireElemental.tscn").instance()
	fire.translation = $FireSpawn.translation + offset
	fire.passiveTarget = $FireTarget
	add_child(fire)

func spawnWater(offset):
	var water = preload("res://WaterElemental.tscn").instance()
	water.translation = $WaterSpawn.translation + offset
	water.passiveTarget = $WaterTarget
	add_child(water)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
