extends Node2D

var firstRoom = "res://scenes/rooms/generateArena/GenerateArena.tscn"

func _ready():
	
	Global.settings = Functions.copyDictionary(Data.defaultSettings)
	get_tree().change_scene(firstRoom)
	
	
	
	
	
