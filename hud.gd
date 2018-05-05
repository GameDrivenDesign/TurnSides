extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_is_over = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$GameOverScreen.hide() #to hide the screen when the game starts
	$BossHealthBar.hide()
	$VictoryScreen.hide()

func set_elemental_counts(fire, water, power, hp, maxHp):
	$elemental_stats/water_count.text = str(water)
	$elemental_stats/fire_count.text = str(fire)
	updateHealthBar(hp, maxHp)
	#power does not exists jet => error
	#$elemental_stats/power_count.text = str(power)

func update_for_player(player):
	if not game_is_over:
		set_elemental_counts(player.elemental_souls_counter[1], player.elemental_souls_counter[0], player.power, player.hp, player.MAX_HP)
	
func showGameOverScreen():
	$BossHealthBar.hide()
	$HealthBar.hide()
	$GameOverScreen.show()
	game_is_over = true
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$GameOverScreen.set_position(Vector2(x * 0.05, y * 0.05))
	$GameOverScreen.set_size(Vector2(x * 0.9, y * 0.9))
	
func showVictoryScreen():
	$BossHealthBar.hide()
	$HealthBar.hide()
	$VictoryScreen.show()
	game_is_over = true
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$VictoryScreen.set_position(Vector2(x * 0.05, y * 0.05))
	$VictoryScreen.set_size(Vector2(x * 0.9, y * 0.9))
	
	
func updateHealthBar(hp, maxHp):
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$HealthBar.set_position(Vector2(x * 0.05, y * 0.05))
	$HealthBar.set_size(Vector2(x * 0.45 * hp / maxHp, y))

func updateBossHealthBar(boss):
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$BossHealthBar.set_position(Vector2(x * 0.05, y * 0.05))
	$BossHealthBar.set_size(Vector2(x * 0.45 * boss.hp / boss.MAX_HP, y))
	
func showBossHealthBar():
	$BossHealthBar.show()
