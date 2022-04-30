extends Label

var score: int = 0

func update_score(points_scored: int):
	score = int(text)
	score += points_scored
	text = str(score)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
