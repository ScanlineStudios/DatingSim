extends "res://scripts/miniGames/actorBaseClassKine.gd"

export (int) var speed = 200
export (float) var fire_cooldown = 5.0
export (float) var move_cooldown = 1.0
export (float) var move_spread = 80.0

var target_position = Vector2(0,0)
var velocity = Vector2()
var move_direction = Vector2.RIGHT

# TODO: consider threads array. then stop all threads on death?
var thread
var fire_thred

signal score_changed

onready var health_display = $HealthDisplay

func _ready():
	max_hp = hp
	health_display.set_max_value(max_hp)
	# begin pseudo random movement routine
	randomize()
	var pick_points_timer = Timer.new()
	pick_points_timer.set_wait_time(move_cooldown + randf()*move_cooldown)
	pick_points_timer.set_one_shot(false)
	pick_points_timer.connect("timeout", self, "_pick_points_routine",[move_spread])
	add_child(pick_points_timer)
	pick_points_timer.start()
	
	# TODO: begine weapon firing routine
	var fire_timer = Timer.new()
	fire_timer.set_wait_time(fire_cooldown + randf()*fire_cooldown)
	fire_timer.set_one_shot(false)
	fire_timer.connect("timeout", self, "_fire_routine")
	add_child(fire_timer)
	fire_timer.start()
	
	
	# Init score related things
	var label = get_tree().get_root().get_node("Galaga/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")
	# overwrite default score value 
	score_value = 10
	

func _physics_process(delta):
	velocity = position.direction_to(target_position) * speed * delta
	# look_at(target)
	if position.distance_to(target_position) > 5:
		move_and_collide(velocity)


func _on_Hurtbox_area_entered(area):
	_hit(area.get_groups()[0])

# override defult post hit function
func _post_hit():
	health_display.update_healthbar(hp)
	pass

# thread that shoots then sleeps for fire_cooldown seconds
func _fire_routine(fire_cooldown: float = 5.0) -> void:
	print("fire")
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
