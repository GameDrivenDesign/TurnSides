extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$GameOverScreen.hide() #to hide the screen when the game starts
	pass

func set_elemental_counts(fire, water, power, hp, maxHp):
	$elemental_stats/water_count.text = str(water)
	$elemental_stats/fire_count.text = str(fire)
	updateHealthBar(hp, maxHp)
	#power does not exists jet => error
	#$elemental_stats/power_count.text = str(power)

func update_for_player(player):
	print(player)
	set_elemental_counts(player.elemental_souls_counter[1], player.elemental_souls_counter[0], player.power, player.hp, player.MAX_HP)
	
func showGameOverScreen():
	$HealthBar.hide()
	$GameOverScreen.show()
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$GameOverScreen.set_position(Vector2(x * 0.05, y * 0.05))
	$GameOverScreen.set_size(Vector2(x * 0.9, y * 0.9))
	
	
func updateHealthBar(hp, maxHp):
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	$HealthBar.set_position(Vector2(x * 0.05, y * 0.05))
	$HealthBar.set_size(Vector2(x * 0.45 * hp / maxHp, y))
	
