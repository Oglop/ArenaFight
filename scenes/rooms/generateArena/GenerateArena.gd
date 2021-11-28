extends Node2D

var progressTexts = {
	"loadConfig": "loading level...",
	"generatingMap": "generating map",
	"generatingRoom": "generating rooms"
}

enum MAP_SIZES {
	SMALL, MEDIUM, LARGE
}

enum ROOM_TYPE {
	NONE, START, END, CORRIDOR, EXTRA
}

enum DIRECTION {
	EAST, NORTH, WEST, SOUTH, NONE
}

func _getRandomDirection(previousDirection: int, allowPreviousDirection: bool = true) -> int:
	var i = Functions.randomInt(0,3)
	if i == 0:
		return DIRECTION.EAST
	elif i == 1:
		return DIRECTION.NORTH
	elif i == 2:
		return DIRECTION.WEST
	elif i == 3:
		return DIRECTION.SOUTH
	return DIRECTION.NONE
	
func _getRandomRoom(map: Array, size: int) -> Dictionary:
	var rooms = []
	for y in range(size):
		for x in range(size):
			if !map[x][y].empty():
				rooms.append({"x":x, "y": y})
	var room = rooms[Functions.randomInt(0, len(rooms) - 1)]
	return room
	
func _linkRooms(direction: int, currentRoom: Dictionary, previousRoom: Dictionary) -> void:
	if direction == DIRECTION.EAST:
		currentRoom.doorWest = true
		previousRoom.doorEast = true
	elif direction == DIRECTION.NORTH:
		currentRoom.doorSouth = true
		previousRoom.doorNorth = true
	elif direction == DIRECTION.WEST:
		currentRoom.doorEast = true
		previousRoom.doorWest = true
	elif direction == DIRECTION.SOUTH:
		currentRoom.doorNorth = true
		previousRoom.doorSouth = true

func _crawlMap(map: Array, roomsToGenerate: int, extraRooms: int, mapSize: int) -> Array:
	var x = 0
	var y = 0
	
	var dir = DIRECTION.NONE
	var previousRoom = {}
	
	var noAddedRooms = 0
	while noAddedRooms <= roomsToGenerate:
		if noAddedRooms == 0:
			x = Functions.randomInt(0, mapSize - 1)
			y = Functions.randomInt(0, mapSize - 1)
			map[x][y] = {
				"type": ROOM_TYPE.START,
				"hidden": false,
				"doorEast": false,
				"doorNorth": false,
				"doorWest": false,
				"doorSouth": false,
			}
			Global.START_ROOM_X = x
			Global.START_ROOM_Y = y
			noAddedRooms += 1
		if noAddedRooms == roomsToGenerate:
			previousRoom = map[x][y]
			dir = _getRandomDirection(dir)
			if dir == DIRECTION.EAST:
				x = Functions.plusOneLimit(x, mapSize - 1)
			elif dir == DIRECTION.NORTH:
				y = Functions.minusOneLimit(y, 0)
			elif dir == DIRECTION.WEST:
				x = Functions.minusOneLimit(x, 0)
			elif dir == DIRECTION.SOUTH:
				y = Functions.plusOneLimit(y, mapSize - 1)
			if map[x][y].empty():
				map[x][y] = {
					"type": ROOM_TYPE.END,
					"hidden": false,
					"doorEast": false,
					"doorNorth": false,
					"doorWest": false,
					"doorSouth": false,
				}
				Global.END_ROOM_X = x
				Global.END_ROOM_Y = y
				_linkRooms(dir, map[x][y], previousRoom)
				noAddedRooms += 1
		else:
			previousRoom = map[x][y]
			dir = _getRandomDirection(dir)
			if dir == DIRECTION.EAST:
				x = Functions.plusOneLimit(x, mapSize - 1)
			elif dir == DIRECTION.NORTH:
				y = Functions.minusOneLimit(y, 0)
			elif dir == DIRECTION.WEST:
				x = Functions.minusOneLimit(x, 0)
			elif dir == DIRECTION.SOUTH:
				y = Functions.plusOneLimit(y, mapSize - 1)
			if map[x][y].empty():
				map[x][y] = {
					"type": ROOM_TYPE.CORRIDOR,
					"hidden": false,
					"doorEast": false,
					"doorNorth": false,
					"doorWest": false,
					"doorSouth": false,
				}
				_linkRooms(dir, map[x][y], previousRoom)
				noAddedRooms += 1

	var addedExtras = 0
	while addedExtras < extraRooms:
		var room = _getRandomRoom(map, mapSize)
		previousRoom = map[x][y]
		dir = _getRandomDirection(dir)
		if dir == DIRECTION.EAST:
			x = Functions.plusOneLimit(room.x, mapSize - 1)
		elif dir == DIRECTION.NORTH:
			y = Functions.minusOneLimit(room.y, 0)
		elif dir == DIRECTION.WEST:
			x = Functions.minusOneLimit(room.x, 0)
		elif dir == DIRECTION.SOUTH:
			y = Functions.plusOneLimit(room.y, mapSize - 1)
		if map[x][y].empty():
			map[x][y] = {
				"type": ROOM_TYPE.EXTRA,
				"hidden": false,
				"doorEast": false,
				"doorNorth": false,
				"doorWest": false,
				"doorSouth": false,
			}
			_linkRooms(dir, map[x][y], previousRoom)
			addedExtras += 1
	return map

func _generateMap(size: int) -> Array:
	var map: Array = []
	for y in range(Data.mapConfigs.arenaSize):
		var row = []
		for x in range(Data.mapConfigs.arenaSize):
			row.append({})
		map.append(row)

	var count: int = 0
	var extras: int = 0
	if size == MAP_SIZES.SMALL:
		count = Data.mapConfigs.small.size
		extras = Functions.randomInt(0, Data.mapConfigs.small.size)
	elif size == MAP_SIZES.MEDIUM:
		count = Data.mapConfigs.medium.size
		extras = Functions.randomInt(0, Data.mapConfigs.medium.size)
	elif size == MAP_SIZES.LARGE:
		count = Data.mapConfigs.large.size
		extras = Functions.randomInt(0, Data.mapConfigs.large.size)
	map = _crawlMap(map, count, extras, Data.mapConfigs.arenaSize)
	return map

func _isWall(x: int, y: int, room: Dictionary) -> bool:
	if x == 0:
		if (y == 6 || y == 7 || y == 8) && room.doorWest == true:
			return false
		return true
	if x == Data.mapConfigs.tilesHori - 1:
		if (y == 6 || y == 7 || y == 8) && room.doorEast == true:
			return false
		return true
	if y == 0:
		if (x == 9 || x == 10) && room.doorNorth == true:
			return false
		return true
	if y == Data.mapConfigs.tilesVert - 1:
		if (x == 9 || x == 10) && room.doorSouth == true:
			return false
		return true
	return false
	
func _getVariation(value: int) -> int:
	if Functions.chance(30):
		value += 1
	if Functions.chance(20):
		value += 1
	return value
	
func _setRoom(mapx: int, mapy: int, tiles: Array, map: Array) -> void:
	for y in range(Data.mapConfigs.tilesVert):
		for x in range(Data.mapConfigs.tilesHori):
			if _isWall(x, y, map[mapx][mapy]):
				tiles[(mapx * Data.mapConfigs.tilesVert) + x][(mapy * Data.mapConfigs.tilesVert) + y] = _getVariation(Data.mapConfigs.wallBase)
			else:
				tiles[(mapx * Data.mapConfigs.tilesHori) + x][(mapy * Data.mapConfigs.tilesHori) + y] = _getVariation(Data.mapConfigs.groundBase)

func _generateRooms(map: Array) -> Array:
	var tiles = []
	for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
		var row = []
		for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
			row.append(-1)
		tiles.append(row)
	
	for y in range(Data.mapConfigs.arenaSize):
		for x in range(Data.mapConfigs.arenaSize):
			if !map[x][y].empty():
				_setRoom(x, y, tiles, map)
	return tiles


func _generateLevel() -> void:
	var map = _generateMap(MAP_SIZES.SMALL)
	var tiles = _generateRooms(map)
	Global.CURRENT_MAP = map
	Global.CURRENT_TILES = tiles
	
	
func _ready():
	$CanvasLayer/lblProgress.text = progressTexts.loadConfig
	$StartGenerating.wait_time = 0.4
	$StartGenerating.start()

func _on_StartGenerating_timeout():
	_generateLevel()
	
