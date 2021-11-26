extends Node

enum TYPE {
	PLAYER
}

onready var Player = preload("res://scenes/player/Player.tscn")

func _ready():
	Global.settings = Data.defaultSettings
	
	
func getScene(type):
	if type == TYPE.PLAYER:
		return Player.instance()

