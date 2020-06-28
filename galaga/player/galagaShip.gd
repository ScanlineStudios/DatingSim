extends KinematicBody2D


#Dircetion constants
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const FORWARD = UP

export var speed = 100 
export var bullet_speed = 100
# lazers/sec
export var fire_rate = 0.2

var bullet = preload("res://galaga/player/PlayerBullet.tscn")
var can_fire = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $FirePoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(),FORWARD.rotated(rotation)*bullet_speed)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
		
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
	
	move_and_collide(direction * speed * delta)
# Called when the node enters the scene tree for the first time.
func _ready():
	# put player ship in initial starting position 
	pass # Replace with function body.

