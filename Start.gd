extends Node2D

var firstRoom = "res://scenes/rooms/generateArena/GenerateArena.tscn"

func _ready():
	var a = [
		[1,2,3],
		[4,5,6],
		[7,8,9]
		]
	for x in range(3):
		for y in range(3):
			print(a[x][y])
	
	
	Global.settings = Functions.copyDictionary(Data.defaultSettings)
	get_tree().change_scene(firstRoom)
	
	
	
	
	
