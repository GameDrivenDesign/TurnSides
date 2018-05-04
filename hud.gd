extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_elemental_counts(fire, water):
	$elemental_stats/water_count.text = str(water)
	$elemental_stats/fire_count.text = str(fire)

func update_for_player(player):
	set_elemental_counts(player.elemental_souls_counter[1], player.elemental_souls_counter[0])