extends Spatial

const MAX_COLLECT_SOUL_DISTANCE = 80

onready var hud = $Player/Camera/CanvasLayer/hud

func _ready():
	spawnFire(Vector3(0,0,0))
	spawnFire(Vector3(5,0,-3))
	spawnFire(Vector3(-3,0,3))
	spawnFire(Vector3(0,0,6))
	spawnFire(Vector3(-5,0,3))
	spawnFire(Vector3(3,0,-3))
	spawnWater(Vector3(0,0,0))
	spawnWater(Vector3(3,0,-3))
	spawnWater(Vector3(-5,0,3))
	spawnWater(Vector3(7,0,0))
	spawnWater(Vector3(-3,0,3))
	spawnWater(Vector3(5,0,3))
	
	$Player.connect("souls_changed", hud, "update_for_player", [$Player])
	$Player.connect("hp_changed", hud, "update_for_player", [$Player])
	hud.update_for_player($Player)
	$Player/Camera.look_at_from_position(Vector3(5, 50, 30), $Player.translation, Vector3(0, 1, 0))

func spawnFire(offset):
	var fire = preload("res://FireElemental.tscn").instance()
	fire.translation = $FireSpawn.translation + offset
	fire.passiveTarget = $FireTarget
	fire.connect("imdead", self, "checkCollectSoul", [fire])
	add_child(fire)

func spawnWater(offset):
	var water = preload("res://WaterElemental.tscn").instance()
	water.translation = $WaterSpawn.translation + offset
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
