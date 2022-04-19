extends "res://scripts/miniGames/actorBaseClassKine.gd"

# export (int) var speed = 200
export (float) var fire_cooldown = 5.0
export (float) var move_cooldown = 1.0
export (float) var move_spread = 80.0
export (int) var bullet_speed = 10

var target_position = Vector2(0,0)
var velocity = Vector2()
var move_direction = Vector2.RIGHT

var enemy_bullet = preload("res://scenes/minigames/tamerinMinigame/enemies/EnemyBullet.tscn")
onready var tamerinMinigame = get_node("../../..") #get_node("../Galaga")

signal score_changed
#onready var health_display = $HealthDisplay

func _ready():
	max_hp = hp
	#health_display.set_max_value(max_hp)
	# begin pseudo random movement routine
	randomize()
	var pick_points_timer = Timer.new()
	pick_points_timer.set_wait_time(move_cooldown + randf()*move_cooldown)
	pick_points_timer.set_one_shot(false)
	pick_points_timer.connect("timeout", self, "_pick_points_routine",[move_spread])
	add_child(pick_points_timer)
	pick_points_timer.start()
	
	# begine weapon firing routine
	var fire_timer = Timer.new()
	fire_timer.set_wait_time(fire_cooldown + randf()*fire_cooldown)
	fire_timer.set_one_shot(false)
	fire_timer.connect("timeout", self, "_fire_routine")
	add_child(fire_timer)
	fire_timer.start()
	
	
	# Init score related things
	var score_label_path = String(tamerinMinigame.get_path()) + "/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score"
	var label = get_node(score_label_path)
	var error = self.connect("score_changed", label, "update_score")
	if error:
		print("Error: ", error)
	
	# overwrite default score value 
	score_value = 10

func _physics_process(delta):
	velocity = position.direction_to(target_position) * move_speed * delta
	
	var _collision = move_and_collide(velocity)


func _on_Hurtbox_area_entered(area):
	_hit(area.get_groups()[0])

# override defult post hit function
func _post_hit():
	#health_display.update_healthbar(hp)
	pass

# thread that shoots then sleeps for fire_cooldown seconds
func _fire_routine(_fire_cooldown: float = 5.0) -> void:
	
	var bullet_instance = enemy_bullet.instance()
	bullet_instance.position = $FirePoint.get_global_position()
	bullet_instance.global_rotation_degrees = global_rotation_degrees
	bullet_instance.move_speed = bullet_speed
	
	get_tree().get_root().add_child(bullet_instance)
	#can_fire = false
	#yield(get_tree().create_timer(fire_rate),"timeout")
	#can_fire = true
	pass
	

# pick random point to move to inside a circle relative to parent node 
func _pick_points_routine(radius: float = 30.0) -> void:
	# Pick random point in radius
	var r = sqrt(rand_range(0.0, 1.0)) * radius
	var t = rand_range(0.0, 1.0) * TAU
	target_position = Vector2(r * cos(t), r * sin(t))
	
	

# sleep for sleep_time seconds
func my_sleep(sleep_time: float) -> void:
	var timer = Timer.new()
	timer.set_wait_time(sleep_time)
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()
	yield(timer,"timeout")
