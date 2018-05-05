extends KinematicBody

signal souls_changed()
signal hp_changed()
signal im_dead(deadObject)
signal turned_side()

var speed = 600
const FIRE = 1
const WATER = 0
const elemental_enum = ["water", "fire"]
const FIRE_GROUP = "FireElemental"
const WATER_GROUP = "WaterElemental"
var current_element = "water"
var hp
var elemental_souls_counter = [10, 10]
const switch_costs_souls = 5 #change for editing the soul costs when switching

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	hp = 500 #initial HP from the player, can be changed later
	update_elemental_color()
	emit_signal("souls_changed")
	emit_signal("hp_changed")

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var input = Vector3(0,0,0)
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.z = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	move_and_slide(input.normalized() * speed * delta, Vector3(0,1,0))
	
	#handles the elemental-group-changig !INCOMPELE!
	if Input.is_action_just_pressed("ui_accept"):
		tryChangingSide()

func tryChangingSide():
	#check if the player has enough souls
	if current_element == elemental_enum[WATER] and elemental_souls_counter[FIRE] >= switch_costs_souls:
		current_element = elemental_enum[FIRE]
		elemental_souls_counter[FIRE] -= switch_costs_souls
		remove_from_group(WATER_GROUP)
		add_to_group(FIRE_GROUP)
		update_elemental_color()
		yield(get_tree().create_timer(3), "timeout")
		emit_signal("turned_side")
	elif elemental_souls_counter[WATER] >= switch_costs_souls:
		current_element = elemental_enum[WATER]
		elemental_souls_counter[WATER] -= switch_costs_souls
		remove_from_group(FIRE_GROUP)
		add_to_group(WATER_GROUP)
		update_elemental_color()
		yield(get_tree().create_timer(3), "timeout")
		emit_signal("turned_side")
	#else:
		#TODO add message to the player that indicates that he has not enough souls to switch

func update_elemental_color():
	$Mesh.get_surface_material(0).albedo_color = Color(1, 0, 0) if current_element == elemental_enum[FIRE] else Color(0, 0, 1)
	emit_signal("souls_changed")
	emit_turn_particles()

func takeDamage(damage):
	hp -= damage
	emit_signal("hp_changed")
	if hp <= 0:
		#TODO game over screen
		emit_signal("im_dead", self)
		emit_signal("player_dead")
		print("the player died") #just for check at the moment
	
func emit_turn_particles():
	var particles = preload("res://turn_particles.tscn").instance()
	add_child(particles)
	yield(get_tree().create_timer(1), "timeout")
	particles.queue_free()