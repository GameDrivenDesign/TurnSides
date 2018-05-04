extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var fire = preload("res://FireElemental.tscn").instance()
	fire.translation = $FireSpawn.translation
	add_child(fire)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
