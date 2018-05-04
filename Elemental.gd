extends KinematicBody

var target
var state
var speed = 100
var hp = 100
var attackRange = 300

enum elementalState{
	passive,
	aggressive
}

func _ready():
	state = elementalState.passive
	set_process(true)

func _process(delta):
	walkToTarget(delta)

func walkToTarget(delta):
	var direction = target.translation - translation
	if(direction.length() > attackRange):
		translation = translation + direction.normalized() * speed * delta
	

func init(tar):
	target = tar