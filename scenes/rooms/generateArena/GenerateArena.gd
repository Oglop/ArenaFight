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

func _generateMap(size: int) -> void:
	var map: Array = []
	#map.resize(Data.mapConfigs.arenaSize)
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


func _generateLevel() -> void:
	_generateMap(MAP_SIZES.SMALL)
	
	
func _ready():
	$CanvasLayer/lblProgress.text = progressTexts.loadConfig
	$StartGenerating.wait_time = 0.4
	$StartGenerating.start()

func _on_StartGenerating_timeout():
	_generateLevel()
