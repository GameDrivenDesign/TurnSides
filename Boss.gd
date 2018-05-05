extends KinematicBody

const COOLDOWN_TIME = 5

var hp = 3000
var cooldown = 0
var player

func _ready():
	#print($BossShield.get_surface_material(0))#.albedo_color = Color(1, 1, 1)
	pass

func _process(delta):
	if cooldown > 0: cooldown -= delta
	
func startBossfight(playerNode):
	#destroy white shield
	player = playerNode
	self.add_to_group("WaterElemental")
	updateShieldColor()
	set_process(true)
	
func lookAtPlayer():
	#rotate accordingly
	pass
	
func fireProjectile():
	#fire huge projectile at player
	pass

func switchShield():
	if(self.is_in_group("WaterElemental")):
		self.add_to_group("FireElemental")
		self.remove_from_group("WaterElemental")
	else:
		self.add_to_group("WaterElemental")
		self.remove_from_group("FireElemental")
	updateShieldColor()
	
func updateShieldColor():
	#if(self.is_in_group("WaterElemental")):
	#	$MeshInstance.get_surface_material(0).albedo_color = Color(0, 0, 1, 0.5)
	#if(self.is_in_group("FireElemental")):
	#	$MeshInstance.get_surface_material(0).albedo_color = Color(1, 0, 0, 0.5)