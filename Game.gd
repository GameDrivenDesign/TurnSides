extends Spatial

const MAX_COLLECT_SOUL_DISTANCE = 30
const MAP_TOP_LEFT_CORNER = Vector2(-20,-20)
const MAP_BOTTOM_RIGHT_CORNER = Vector2(20,20)


onready var hud = $Player/Camera/CanvasLayer/hud

func _ready():
	var boss = preload("res://Boss.tscn").instance()
	boss.translation = Vector3(10,0,10)
	boss.init($Player)
	$Player.connect("start_endphase", boss, "startBossfight")
	add_child(boss)
	$Player.connect("souls_changed", hud, "update_for_player", [$Player])
	$Player.connect("hp_changed", hud, "update_for_player", [$Player])
	$Player.connect("player_dead", hud, "showGameOverScreen")
	$Player.connect("start_endphase", hud, "showBossHealthBar")
	#TODO maybe wrong, try $Boss
	boss.connect("boss_hp_changed", hud, "updateBossHealthBar", [boss])
	boss.connect("victory", hud, "showVictoryScreen")
	hud.update_for_player($Player)
	$Player/Camera.look_at_from_position(Vector3(5, 50, 30), $Player.translation, Vector3(0, 1, 0))
	
	spawn_wave()

func spawnFire(offset, groupSeed):
	var fire = preload("res://FireElemental.tscn").instance()
	fire.init(MAP_TOP_LEFT_CORNER, MAP_BOTTOM_RIGHT_CORNER, groupSeed)
	fire.translation = $FireSpawn.translation + offset
	fire.passiveTarget = $FireTarget
	fire.connect("im_dead", self, "checkCollectSoul")
	add_child(fire)

func spawnWater(offset, groupSeed):
	var water = preload("res://WaterElemental.tscn").instance()
	water.init(MAP_TOP_LEFT_CORNER, MAP_BOTTOM_RIGHT_CORNER, groupSeed)
	water.translation = $WaterSpawn.translation + offset
	water.passiveTarget = $WaterTarget
	water.connect("im_dead", self, "checkCollectSoul")
	add_child(water)

func checkCollectSoul(elemental):
	var soul = preload("res://Soul.tscn").instance()
	if elemental.translation.distance_to($Player.translation) <= MAX_COLLECT_SOUL_DISTANCE:
		soul.target = $Player
	soul.translation = elemental.translation
	soul.type = elemental.my_element_name()
	add_child(soul)

func _on_SpawnTimer_timeout():
	spawn_wave()

func spawn_wave():
	randomize()
	var fireSeed = randi()
	var waterSeed = randi()
	for i in range(3):
		spawnFire(Vector3(rand_range(-5,5),0,rand_range(-5,5)), fireSeed)
		spawnWater(Vector3(rand_range(-5,5),0,rand_range(-5,5)), waterSeed)
