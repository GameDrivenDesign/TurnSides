extends KinematicBody

signal im_dead(deadObject)

var passiveTarget
var enemyList = []
var state
var strength = 10
var speed = 3
var hp = 100
var attackRange = 10

var proximitySphere

enum elementalState{
	passive,
	aggressive
}

func _ready():
	state = elementalState.passive
	proximitySphere = preload("res://ElementalProximitySphere.tscn").instance()
	proximitySphere.connect("body_entered", self, "handleProximityAlert")
	add_child(proximitySphere)
	set_process(true)
	
func isHostileTowards(node):
	pass

func _process(delta):
	walkToTarget(delta)
	if(state == elementalState.aggressive):
		attackTarget(delta)

func walkToTarget(delta):
	var direction
	if(state == elementalState.passive):
		direction = passiveTarget.translation - translation
	if(state == elementalState.aggressive):
		direction = enemyList[0].translation - translation
	if(direction.length() > attackRange/2):
		translation = translation + direction.normalized() * speed * delta
		
func attackTarget(delta):
	var direction = enemyList[0].translation - translation
	if(direction.length() <= attackRange):
		enemyList[0].takeDamage(strength * delta)

func takeDamage(dmg):
	hp = hp - dmg
	if(hp <= 0):
		die()

func die():
	emit_signal("im_dead", self)
	queue_free()

func init(tar):
	passiveTarget = tar
	
func handleProximityAlert(intruder):
	if(isHostileTowards(intruder)):
		intruder.connect("im_dead", self, "unregisterElemental")
		enemyList.append(intruder)
		if(state == elementalState.passive):
			state = elementalState.aggressive
		
func unregisterElemental(elemental):
	var index = enemyList.find(elemental)
	if(index < 0):
		return
	enemyList.remove(index)
	if(enemyList.empty()):
		state = elementalState.passive
		
		
		
	
	