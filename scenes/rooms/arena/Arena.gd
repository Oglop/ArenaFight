extends Node2D

onready var nonCollision = $NonCollision
onready var collision = $Collision


func _drawTile(value: int, x: int, y: int) -> void:

	if value == 0:
		nonCollision.set_cell(x, y, 0)
	elif value == 1:
		nonCollision.set_cell(x, y, 2)
	elif value == 2:
		nonCollision.set_cell(x, y, 3)
		
	elif value == 10:
		collision.set_cell(x, y, 2)
	elif value == 11:
		collision.set_cell(x, y, 1)
	elif value == 12:
		collision.set_cell(x, y, 0)
		
func _addDoor(room: Dictionary, x: int, y: int) -> void:
	var modx = x % Data.mapConfigs.tilesHori
	var mody = y % Data.mapConfigs.tilesVert
	if modx == 0:
		if (mody == 6 || mody == 7 || mody == 8) && room.doorWest == true:
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.ARENA_DOOR, Vector2(x * Data.mapConfigs.tileSize,y * Data.mapConfigs.tileSize))
	if modx == Data.mapConfigs.tilesHori - 1:
		if (mody == 6 || mody == 7 || mody == 8) && room.doorEast == true:
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.ARENA_DOOR, Vector2(x * Data.mapConfigs.tileSize,y * Data.mapConfigs.tileSize))
	if mody == 0:
		if (modx == 9 || modx == 10) && room.doorNorth == true:
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.ARENA_DOOR, Vector2(x * Data.mapConfigs.tileSize,y * Data.mapConfigs.tileSize))
	if mody == Data.mapConfigs.tilesVert - 1:
		if (modx == 9 || modx == 10) && room.doorSouth == true:
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.ARENA_DOOR, Vector2(x * Data.mapConfigs.tileSize,y * Data.mapConfigs.tileSize))

func _addBombables(room: Dictionary, roomx: int, roomy: int) -> void:
	var baseX = roomx * Data.mapConfigs.tileSize
	var baseY = roomy * Data.mapConfigs.tileSize
	if room.type == Data.ROOM_TYPE.CORRIDOR:
		if room.design == Data.ROOM_DESIGN.CROSS:
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.BOMBABLE, Vector2(baseX + 9, baseY + 6) * 16)
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.BOMBABLE, Vector2(baseX + 10, baseY + 6) * 16)
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.BOMBABLE, Vector2(baseX + 9, baseY + 7) * 16)
			Events.emit_signal("arenaAddAssetAt", Loader.TYPE.BOMBABLE, Vector2(baseX + 10, baseY + 7) * 16)
		

func _drawLevel() -> void:
	
	for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
		for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
			var mapy = y / Data.mapConfigs.tilesVert
			var mapx = x / Data.mapConfigs.tilesHori
			var room = Global.CURRENT_MAP[mapx][mapy]
			if Global.CURRENT_TILES[x][y] >= 0:
				_drawTile(Global.CURRENT_TILES[x][y], x, y)
				_addDoor(room, x, y)
				
				
	for x in range(Data.mapConfigs.arenaSize):
		for y in range(Data.mapConfigs.arenaSize):
			var room: Dictionary = Global.CURRENT_MAP[x][y]
			if !room.empty():
				_addBombables(room, x, y)
				
			
func _ready():
	_drawLevel()
	Events.emit_signal("setCameraPosition", Global.START_ROOM_X, Global.START_ROOM_Y)
	Events.emit_signal("setArenaEntryBlockState", Data.ARENA_DOOR_STATES.OPEN)

