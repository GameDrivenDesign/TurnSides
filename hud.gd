extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$GameOverScreen.hide() #to hide the screen when the game starts
	pass

func set_elemental_counts(fire, water, power, hp):
	$elemental_stats/water_count.text = str(water)
	$elemental_stats/fire_count.text = str(fire)
	updateHealthBar()
	$elemental_stats/power_count.text = str(power)

func update_for_player(player):
	set_elemental_counts(player.elemental_souls_counter[1], player.elemental_souls_counter[0], player.power, player.hp)
	
func showGameOverScreen():
	$GameOverScreen.show()
	var x = $hud.get_viewport().size.x
	var y = $hud.get_viewport().size.y
	$GameOverScreen.set_rect(Vector2(x * 0.05, y * 0.05))
	$GameOverScreen.rect_size(Vector2(x * 0.9, y * 0.9))
	
	
func updateHealthBar():
	var x = $hud.get_viewport().size.x
	var y = $hud.get_viewport().size.y
	$HealthBar.set_rect(Vector2(x * 0,05, y * 0,05))
	$HealthBar.rect_size(Vector2(x * 0.45 * $Player.hp / $Player.MAX_HP))
	
