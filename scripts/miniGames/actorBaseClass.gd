extends RigidBody2D 

# This is the base actor script that all 2d enteties that move or do actions will 
# inherit from. this includes players and enemies 

# Dircetion constants
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const FORWARD = UP

export var move_speed = 250 # default move speed
export var hp = 100 # default hit point total


func _ready():
	# default to no gravity
	set_gravity_scale(0)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
