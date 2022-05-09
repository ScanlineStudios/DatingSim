extends Label

var score: int = 0

func update_score(points_scored: int):
	score = int(text)
	score += points_scored
	text = str(score)

