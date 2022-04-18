extends "res://scripts/miniGames/actorBaseClassKine.gd"

# export var speed = 100 
export var bullet_speed = 100
# lazers/sec
export var fire_rate = 0.2

var bullet = preload("res://scenes/miniGames/tamerinMinigame/player/PlayerBullet.tscn")
var can_fire = true

var velocity = Vector2()

onready var health_display = $HealthDisplay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $FirePoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.move_speed = bullet_speed
		
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity += UP
	if Input.is_action_pressed("move_down"):
		velocity += DOWN
	if Input.is_action_pressed("move_left"):
		velocity += LEFT
	if Input.is_action_pressed("move_right"):
		velocity += RIGHT
	velocity = velocity.normalized() * move_speed
	
	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	max_hp = hp
	health_display.set_max_value(max_hp)
	print("Player Ship Ready")
	#set_mode(MODE_CHARACTER) 


func _on_Hurtbox_area_entered(area):
	_hit(area.get_groups()[0])
	

# Override base _post_hit function
func _post_hit():
	health_display.update_healthbar(hp)
	
	
# Override default death function
func _die():
	
	# TODO: If health <= 0 do something. Send signal? 
	print_debug("Galaga: GAME OVER")
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
