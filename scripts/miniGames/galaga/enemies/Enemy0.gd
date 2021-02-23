extends "res://scripts/miniGames/actorBaseClassKine.gd"

export (int) var speed = 200

var target_position = Vector2(0,0)
var velocity = Vector2()

var thread
var move_direction = Vector2.RIGHT


func _ready():
	# TODO: begin pseudo random movement routine
	randomize()
	thread = Thread.new()
	thread.start(self, "_pick_points_routine", 80.0)

func _physics_process(delta):
	velocity = position.direction_to(target_position) * speed * delta
	# look_at(target)
	if position.distance_to(target_position) > 5:
		move_and_collide(velocity)

func _on_Hurtbox_area_entered(area):
	_hit(area.get_groups()[0])
	
# TODO: pick random point to move to inside a circle relative to parent node 
func _pick_points_routine(radius: float = 30.0, cooldown: float = 1.0) -> void:
	var i = 0
	while true:
		# Pick random point in radius
		var r = sqrt(rand_range(0.0, 1.0)) * radius
		var t = rand_range(0.0, 1.0) * TAU
		target_position = Vector2(r * cos(t), r * sin(t))
		
		var timer = Timer.new()
		timer.set_wait_time(cooldown + randf()*cooldown)
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		yield(timer,"timeout")

