extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 50

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var input = Vector3(0,0,0)
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.z = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	move_and_slide(input.normalized()*speed*delta, Vector3(0,1,0))
