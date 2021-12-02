extends Node2D

onready var nonCollision = $NonCollision
onready var collision = $Collision

func _drawTile(value: int, x: int, y: int) -> void:

	if value == 0:
		nonCollision.set_cell(x, y, 0)
	elif value == 1:
		nonCollision.set_cell(x, y, 1)
	elif value == 2:
		nonCollision.set_cell(x, y, 3)
		
	elif value == 10:
		collision.set_cell(x, y, 2)
	elif value == 11:
		collision.set_cell(x, y, 1)
	elif value == 12:
		collision.set_cell(x, y, 0)

func _drawLevel() -> void:
	
	for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
		for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
			if Global.CURRENT_TILES[x][y] >= 0:
				_drawTile(Global.CURRENT_TILES[x][y], x, y)

func _ready():
	_drawLevel()
	#print("(Global.START_ROOM_X * 200) * 16 " + str(Global.START_ROOM_X * 200) + "(Global.START_ROOM_Y * 150) * 16) " + str(Global.START_ROOM_Y * 150)) 
	Events.emit_signal("setCameraPosition", Global.START_ROOM_X, Global.START_ROOM_Y)

