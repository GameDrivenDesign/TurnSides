extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 100
const elemental_enum = ["water", "fire"]
var current_element
var hp
var elemental_souls_counter = [0, 0]
const switch_costs_souls = 5 #change for editing the soul costs when switching

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	hp = 500 #initial HP from the player, can be changed later
	elemental_souls_counter[0] = 0
	elemental_souls_counter[1] = 1

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var input = Vector3(0,0,0)
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.z = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	move_and_slide(input.normalized() * speed * delta, Vector3(0,1,0))
	
	#handles the elemental-group-changig !INCOMPELE!
	if Input.is_action_pressed("ui_accept"):
		#check if the player has enough souls
		if current_element == elemental_enum[0] and elemental_souls_counter[1] >= switch_costs_souls:
			current_element = elemental_enum[1]
		elif elemental_souls_counter[0] >= switch_costs_souls:
			current_element = elemental_enum[0]
		#else:
			#TODO add message to the player that indicates that he has not enough souls to switch
			
