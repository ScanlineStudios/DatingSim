extends KinematicBody2D


#Dircetion constants
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)

export var speed = 100 
var
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction += UP
	if Input.is_action_pressed("move_down"):
		direction += DOWN
	if Input.is_action_pressed("move_left"):
		direction += LEFT
	if Input.is_action_pressed("move_right"):
		direction += RIGHT
	
	move_and_slide(direction * speed)
# Called when the node enters the scene tree for the first time.
func _ready():
	# put player ship in initial starting position 
	pass # Replace with function body.

