extends Node2D

onready var nonCollision = $NonCollision
onready var collision = $Collision

func _drawTile(value: int, x: int, y: int) -> void:
	var actualX = x * Data.mapConfigs.tileSize
	var actualY = y * Data.mapConfigs.tileSize
	if value == 0:
		nonCollision.set_cell(0, 0, 0)
		nonCollision.set_cell(actualX, actualY, 0)
	elif value == 0:
		nonCollision.set_cell(actualX, actualY, 1)
		
	elif value == 10:
		collision.set_cell(actualX, actualY, 0)
	elif value == 11:
		collision.set_cell(actualX, actualY, 1)
	elif value == 12:
		collision.set_cell(actualX, actualY, 2)

func _drawLevel() -> void:
	for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
		for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
			if Global.CURRENT_TILES[x][y] >= 0:
				_drawTile(Global.CURRENT_TILES[x][y], x, y)


func _ready():
	_drawLevel()
	#Events.emit_signal("setCameraPosition", (Global.START_ROOM_X * 200) * 16, (Global.START_ROOM_Y * 150) * 16)

