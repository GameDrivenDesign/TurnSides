extends KinematicBody

signal victory()

const PROJECTILE_COOLDOWN_TIME = 5
const SWITCH_SHIELD_COOLDOWN_TIME = 15

var hp = 3
var projectileCooldown = 2
var switchShieldCooldown = 0
var player
var activated = false

func _ready():
	$BossShield.mesh.material.albedo_color = Color(1, 1, 1, 0.3)
	set_process(true)
	pass

func _process(delta):
	if(activated):
		projectileCooldown -= delta
		if(projectileCooldown <= 0): shotProjectile()
		switchShieldCooldown -= delta
		if(switchShieldCooldown <= 0): switchShield()
	
func init(playerNode):
	player = playerNode
	
func startBossfight():
	#destroy white shield
	if(not activated):
		self.add_to_group("WaterElemental")
		updateShieldColor()
		activated = true
		
func takeDamage(dmg):
	hp -= dmg
	if(hp <= 0):
		emit_signal("victory")
		queue_free()
	
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
	if(self.is_in_group("WaterElemental")):
		$BossShield.mesh.material.albedo_color = Color(0, 0, 1, 0.3)
	if(self.is_in_group("FireElemental")):
		$BossShield.mesh.material.albedo_color = Color(1, 0, 0, 0.3)