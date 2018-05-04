extends Area


signal proximityAlert(collisionPartners)

func _ready():
	set_process(true)

func _process(delta):
	var overlappingBodies = get_overlapping_bodies()
	


