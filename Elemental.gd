extends KinematicBody

signal im_dead(deadObject)

const WEAPON_COOLDOWN_TIME = 0.6

var minRand
var maxRand
var groupSeed

var weapon_cooldown = 0
var passiveTarget
var enemyList = []
var state
var strength = 10
var speed = 3
var hp = 100
var attackRange = 10
var player = null

var proximitySphere

enum elementalState{
	passive,
	aggressive
}

func init(mapTopLeftCorner, mapBottomRightCorner, assignedSeed):
	minRand = Vector2(mapTopLeftCorner.x, mapTopLeftCorner.y)
	maxRand = Vector2(mapBottomRightCorner.x, mapBottomRightCorner.y)
	groupSeed = assignedSeed
	
func _ready():
	state = elementalState.passive
	proximitySphere = preload("res://ElementalProximitySphere.tscn").instance()
	proximitySphere.connect("body_entered", self, "handleProximityAlert")
	proximitySphere.connect("body_exited", self, "unregisterElemental")
	add_child(proximitySphere)
	set_process(true)
	setRandomPassiveTarget()
	
func setRandomPassiveTarget():
	var posX
	var posZ
	groupSeed = rand_seed(groupSeed)[1]
	posX = (groupSeed % int(maxRand.x - minRand.x)) + minRand.x
	groupSeed = rand_seed(groupSeed)[1]
	posZ = (groupSeed % int(maxRand.y - minRand.y)) + minRand.y
	passiveTarget = Vector3(posX, self.translation.y, posZ)
	
	for body in proximitySphere.get_overlapping_bodies():
		handleProximityAlert(body)
	
func isHostileTowards(node):
	pass

func my_group_name():
	pass

func my_element_name():
	pass

func _process(delta):
	walkToTarget(delta)
	if(state == elementalState.aggressive):
		attackTarget(delta)
	
	if weapon_cooldown > 0:
		weapon_cooldown -= delta

func walkToTarget(delta):
	var direction
	if(state == elementalState.passive):
		if(player):
			direction = player.translation - translation
		else:
			direction = passiveTarget - translation
	if(state == elementalState.aggressive):
		direction = enemyList[0].translation - translation
	if(direction.length() > attackRange/4):
		move_and_collide(direction.normalized() * speed * delta)
	else:
		if(state == elementalState.passive):
			setRandomPassiveTarget()
		
func attackTarget(delta):
	if weapon_cooldown <= 0:
		var projectile = preload("res://Projectile.tscn").instance()
		projectile.shoot_at(translation + Vector3(0, 1, 0),
			enemyList[0].translation + Vector3(0, 1, 0),
			my_group_name())
		get_parent().add_child(projectile)
		weapon_cooldown = WEAPON_COOLDOWN_TIME

func takeDamage(dmg):
	hp = hp - dmg
	if(hp <= 0):
		die()

func die():
	emit_signal("im_dead", self)
	queue_free()
	
func handleProximityAlert(intruder):
	if(intruder.is_in_group("player")):
		player = intruder
		player.connect("turned_side", self, "playerChangedSide")
	if(isHostileTowards(intruder) and not intruder.is_in_group("BigBoss")):
		intruder.connect("im_dead", self, "unregisterElemental")
		enemyList.append(intruder)
		if(state == elementalState.passive):
			state = elementalState.aggressive
			
func removeFromEnemies(elemental):	
	var index = enemyList.find(elemental)
	if(index < 0):
		return
	enemyList.remove(index)	
	if(enemyList.empty()):
		state = elementalState.passive

func unregisterElemental(elemental):
	if(elemental.is_in_group("player")):
		elemental.disconnect("turned_side", self, "playerChangedSide")
		player = null
	removeFromEnemies(elemental)
		
func playerChangedSide():
	if(isHostileTowards(player)):
		enemyList.push_front(player)
		if(state == elementalState.passive):
			state = elementalState.aggressive
	else:
		removeFromEnemies(player)
		
		
	
	
