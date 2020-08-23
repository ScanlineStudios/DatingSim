extends Node2D

onready var _bodyLabel = self.find_node("bodyLabel")
onready var _dialogBox = self.find_node("dialogBox")
onready var _nameLabel = self.find_node("nameLabel")
onready var _spaceBarIcon = self.find_node("spaceBarNinePatchRect")

var _did = 0
var _nid = 0
var _storyReader
var _playingDialog = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var storyRenderClass = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	self._storyReader = storyRenderClass.new()
	
	var story = load("res://dialogTest.tres")
	self._storyReader.read(story)
	
	self.d


