extends Spatial

<<<<<<< HEAD
const MAX_COLLECT_SOUL_DISTANCE = 80
=======
const MAP_TOP_LEFT_CORNER = Vector2(-20,-20)
const MAP_BOTTOM_RIGHT_CORNER = Vector2(20,20)

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
>>>>>>> b99c26828c37e5ab79f2e3c7c3bffa81594310d8

onready var hud = $Player/Camera/CanvasLayer/hud

func _ready():
	
	$Player.connect("souls_changed", hud, "update_for_player", [$Player])
	$Player.connect("hp_changed", hud, "update_for_player", [$Player])
	$Player.connect("player_dead", hud, "showGameOverScreen")
	hud.update_for_player($Player)
	$Player/Camera.look_at_from_position(Vector3(5, 50, 30), $Player.translation, Vector3(0, 1, 0))
	$hud.updateHealthBar() #to fix the healthBar position

func spawnFire(offset, groupSeed):
	var fire = preload("res://FireElemental.tscn").instance()
	fire.init(MAP_TOP_LEFT_CORNER, MAP_BOTTOM_RIGHT_CORNER, groupSeed)
	fire.translation = $FireSpawn.translation + offset
<<<<<<< HEAD
	fire.passiveTarget = $FireTarget
	fire.connect("imdead", self, "checkCollectSoul", [fire])
=======
	#fire.passiveTarget = $FireTarget
>>>>>>> b99c26828c37e5ab79f2e3c7c3bffa81594310d8
	add_child(fire)

func spawnWater(offset, groupSeed):
	var water = preload("res://WaterElemental.tscn").instance()
	water.init(MAP_TOP_LEFT_CORNER, MAP_BOTTOM_RIGHT_CORNER, groupSeed)
	water.translation = $WaterSpawn.translation + offset
<<<<<<< HEAD
	water.passiveTarget = $WaterTarget
	water.connect("imdead", self, "checkCollectSoul", [water])
	add_child(water)

func checkCollectSoul(elemental):
	var soul = preload("res://Soul.tscn").instance()
	if elemental.translation.distance_to($Player.translation) <= MAX_COLLECT_SOUL_DISTANCE:
		soul.target = $Player
	soul.translation = elemental.translation
	add_child(soul)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
=======
	#water.passiveTarget = $WaterTarget
	add_child(water)

func _on_SpawnTimer_timeout():
	print("action!")
	randomize()
	var fireSeed = randi()
	var waterSeed = randi()
	for i in range(3):
		spawnFire(Vector3(rand_range(-5,5),0,rand_range(-5,5)), fireSeed)
		spawnWater(Vector3(rand_range(-5,5),0,rand_range(-5,5)), waterSeed)
>>>>>>> b99c26828c37e5ab79f2e3c7c3bffa81594310d8
