extends KinematicBody

const PROJECTILE_COOLDOWN_TIME = 5
const SWITCH_SHIELD_COOLDOWN_TIME = 15

var hp = 3000
var projectileCooldown = 2
var switchShieldCooldown = 0
var player
var activated = false

func _ready():
	#print($BossShield.get_surface_material(0))#.albedo_color = Color(1, 1, 1)
	set_process(true)
	pass

func _process(delta):
	if(activated):
		projectileCooldown -= delta
		if(projectileCooldown <= 0): shotProjectile()
		switchShieldCooldown -= delta
		if(switchShieldCooldown <= 0): switchShield()
	
func startBossfight(playerNode):
	#destroy white shield
	if(not activated):
		player = playerNode
		self.add_to_group("WaterElemental")
		updateShieldColor()
		activated = true
	
func shotProjectile():
	#substitute projectile by huge projectile
	var projectile = preload("res://BossProjectile.tscn").instance()
	projectile.shoot_at(translation + Vector3(0, 1, 0), player.translation + Vector3(0, 1, 0))
	get_parent().add_child(projectile)
	projectileCooldown = PROJECTILE_COOLDOWN_TIME

func switchShield():
	if(self.is_in_group("WaterElemental")):
		self.add_to_group("FireElemental")
		self.remove_from_group("WaterElemental")
	else:
		self.add_to_group("WaterElemental")
		self.remove_from_group("FireElemental")
	updateShieldColor()
	switchShieldCooldown = SWITCH_SHIELD_COOLDOWN_TIME
	
func updateShieldColor():
	#if(self.is_in_group("WaterElemental")):
	#	$MeshInstance.get_surface_material(0).albedo_color = Color(0, 0, 1, 0.5)
	#if(self.is_in_group("FireElemental")):
	#	$MeshInstance.get_surface_material(0).albedo_color = Color(1, 0, 0, 0.5)