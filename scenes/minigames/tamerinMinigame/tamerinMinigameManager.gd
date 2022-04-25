extends Node2D

onready var spawner = get_node("Spawner")
onready var enenmy0 = preload("res://scenes/minigames/tamerinMinigame/enemies/Enemy0-1.tscn")
onready var squad = preload("res://scenes/minigames/tamerinMinigame/enemies/EnemySquad.tscn")
#other enemies here

onready var score_label: Label = get_node("GUI/MarginContainer/HBoxContainer/VBoxContainer/Score") 
onready var countdown_timer_label : Label = get_node("GUI/MarginContainer3/HBoxContainer2/VBoxContainer/CenterLabel")
onready var countdown_tick_timer = Timer.new()


# Initialize tamerinMinigame but do not start spawning
func _ready():
	
	add_child(countdown_tick_timer) #to process
	var _error = SignalManager.connect("tamerin_minigame_player_destroyed", self, "_on_tamerin_minigame_player_destroyed")
	
	# todo: Configure squads?
	
	# do test sequence if this node is the root
	if (get_tree().get_root() == self.get_parent()):
		start() 

# called after ending triger (player death, time out, all enemies dead)
func end():
	update_center_label("GAME OVER")
	
	var score = score_label.score
	SignalManager.emit_signal("tamerin_minigame_ended", score)
	pass

# begine countdown then start spawning and rest of minigame. 
# TODO: potential dificulty input, timer input?
func start(duration_seconds: int = 100, dificulty: int = 50) -> void:
	
	# Countdown timer
	var seconds_to_countdown : int = 4 
	for num in range(3,-1, -1):
		countdown_tick_timer.start(1)
		var label_text : String = String(num)
		if (num == 0):
			label_text = "GO!"
		yield(countdown_tick_timer, "timeout")
		update_center_label(label_text)
		
	spawner.spawn_squads(squad, 7, 3)
	
	# clear center label
	countdown_tick_timer.start(2)
	yield(countdown_tick_timer, "timeout")
	update_center_label("")
	

func update_center_label(update_string : String = "") -> void:
	countdown_timer_label.text = update_string

#func _on_countdown_tick_timer_timeout(update_string : String = ""):
#   update_center_label(update_string)


func _on_tamerin_minigame_player_destroyed():
	end()
