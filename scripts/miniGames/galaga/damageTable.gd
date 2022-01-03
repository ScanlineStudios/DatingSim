extends Node

# Dictionary that maps tags to damage values
var damageTable = {}
export(String, FILE, "*.json") var damageTableFileName = "res://gameData/galagaDmgTable.json" 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# read file containing damage mappings? 
	# file is json in form { "<collision mask name>": <damage value>, }   
	var file = File.new()
	print(damageTableFileName)
	file.open(damageTableFileName, file.READ)
	var json = file.get_as_text()
	var jsonParseOut = JSON.parse(json)
	if typeof(jsonParseOut.result) == TYPE_DICTIONARY:
		damageTable = jsonParseOut.result
	else: 
		print("Failed to parse json " + jsonParseOut.result)

func _getDamage(tag):

	if damageTable.has(tag):
		return damageTable.get(tag)
	else:
		return 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
