extends Node2D

var progressTexts = {
	"loadConfig": "loading level...",
	"generatingMap": "generating map",
	"generatingRoom": "generating rooms"
}

var state = STATES.IDLE

enum STATES {
	IDLE,
	BUILDING,
	DONE
}

enum MAP_SIZES {
	SMALL, MEDIUM, LARGE
}

enum DIRECTION {
	EAST, NORTH, WEST, SOUTH, NONE
}

func _getRoomRandomDesign(type: int) -> int:
	if type == Data.ROOM_TYPE.CORRIDOR:
		var i = Functions.randomInt(1, 2)
		if i == 0:
			return Data.ROOM_DESIGN.EMPTY
		elif i == 1:
			return Data.ROOM_DESIGN.CROSS
		elif i == 2:
			return Data.ROOM_DESIGN.RANDOM_OPEN
	
	return Data.ROOM_DESIGN.EMPTY

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
				"type": Data.ROOM_TYPE.START,
				"design": Data.ROOM_DESIGN.EMPTY,
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
					"type": Data.ROOM_TYPE.END,
					"design": Data.ROOM_DESIGN.EMPTY,
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
				var _design = _getRoomRandomDesign(Data.ROOM_TYPE.CORRIDOR)
				map[x][y] = {
					"type": Data.ROOM_TYPE.CORRIDOR,
					"design": _design,
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
		previousRoom = room# map[x][y]
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
				"type": Data.ROOM_TYPE.EXTRA,
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

func _isWall(_x: int, _y: int, room: Dictionary) -> bool:
	var x = _x % Data.mapConfigs.tilesHori
	var y = _y % Data.mapConfigs.tilesVert
	
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
	
func _setRoom(x: int, y: int, tiles: Array, map: Array) -> void:
	var mapy = y / Data.mapConfigs.tilesVert
	var mapx = x / Data.mapConfigs.tilesHori
	if mapx == 10:
		print('dfsdfd')
	if !map[mapx][mapy].empty():
		if _isWall(x, y, map[mapx][mapy]):
			tiles[x][y] = _getVariation(Data.mapConfigs.wallBase)
		else:
			tiles[x][y] = _getVariation(Data.mapConfigs.groundBase)

func _generateRooms(map: Array) -> Array:
	var tiles = []
	
	for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
		var row = []
		for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):	
			row.append(-1)
		tiles.append(row)
		
	for x in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesHori):
		for y in range(Data.mapConfigs.arenaSize * Data.mapConfigs.tilesVert):
			_setRoom(x, y, tiles, map)
	return tiles


func _generateLevel() -> void:
	var map = _generateMap(MAP_SIZES.SMALL)
	var tiles = _generateRooms(map)
	Global.CURRENT_MAP = map
	Global.CURRENT_TILES = tiles
	$Timer.wait_time = 0.5
	$Timer.start()
	
func _physics_process(delta):
	if state == STATES.DONE:
		get_tree().change_scene("res://scenes/rooms/arena/Arena.tscn")
	
func _ready():
	$CanvasLayer/lblProgress.text = progressTexts.loadConfig
	$Timer.wait_time = 0.5
	$Timer.start()

func _on_StartGenerating_timeout():
	if state == STATES.IDLE:
		_generateLevel()
		state = STATES.BUILDING
	elif state == STATES.BUILDING:
		state = STATES.DONE
		
	
