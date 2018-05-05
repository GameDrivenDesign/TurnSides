extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	hide() #to hide the screen when the game starts
	pass

func set_elemental_counts(fire, water):
	$elemental_stats/water_count.text = str(water)
	$elemental_stats/fire_count.text = str(fire)

func update_for_player(player):
	set_elemental_counts(player.elemental_souls_counter[1], player.elemental_souls_counter[0])
	
func showGameOverScreen(score):
	$GameOverScreen.show()
	var x = $hud.get_viewport().size.x
	var y = $hud.get_viewport().size.y
	set_rect(Vector2(x * 0.05, y * 0.05))
	rect_size(Vector2(x * 0.9, y * 0.9))
	