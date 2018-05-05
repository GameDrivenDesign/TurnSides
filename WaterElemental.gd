extends "res://Elemental.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func isHostileTowards(node):
	if(node.is_in_group("FireElemental")):
		return true
	else:
		return false

func my_group_name():
	return "WaterElemental"

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
