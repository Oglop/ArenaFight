extends Node2D


func _drawTile(value: int, x: int, y: int) -> void:
	$NonCollision.set_cell(0, 0, 0)
	var actualX = x * Data.mapConfigs.tileSize
	var actualY = y * Data.mapConfigs.tileSize
	if value == 0:
		$NonCollision.set_cell(actualX, actualY, 0)
	elif value == 0:
		$NonCollision.set_cell(actualX, actualY, 1)
		
	elif value == 10:
		$Collision.set_cell(actualX, actualY, 0)
	elif value == 11:
		$Collision.set_cell(actualX, actualY, 1)
	elif value == 12:
		$Collision.set_cell(actualX, actualY, 2)

func _drawLevel() -> void:
	
	for i in range(Global.CURRENT_TILES[0][0].length):
		print("i " + str(i))
	
	
	
	print("Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert " + str(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert))
	print("Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori " + str(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori))
	for y in range((Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert)):
		for x in range((Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori)):
			if x >= Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori || y >= Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert:
				print("x " + str(x) + ",y " + str(y))
	
	for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
		for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
			print("draw " + str(Global.CURRENT_TILES[x][y]))
			if Global.CURRENT_TILES[x][y] >= 0:
				
				_drawTile(Global.CURRENT_TILES[x][y], x, y)


func _ready():
	_drawLevel()

