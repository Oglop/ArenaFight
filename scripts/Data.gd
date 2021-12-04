extends Node

enum DIRECTIONS {
	EAST, NORTH, WEST, SOUTH, NONE
}

enum ARENA_DOOR_STATES {
	OPEN, CLOSED
}

enum ARENA_STATES {
	IDLE,
	ROOM_PLAYING,
	SCREEN_TRANSITION
}

enum ROOM_TYPES {
	EMPTY,
	RANDOM_OPEN,
	CROSS
}



var defaultSettings: Dictionary = {
	"lastsave": "",
	"fullscreen": false,
}

const gameConfigs: Dictionary = {
	"playerMaxSpeed": 6000,
	"playerFriction": 1000,
	"playerAcceleration": 200
}

const mapConfigs: Dictionary = {
	"screenSizeX": 320,
	"screenSizeY": 240,
	"arenaSize": 10,
	"tilesHori": 20,
	"tilesVert": 15,
	"tileSize": 16,
	"cameraOffsetX": 160,
	"cameraOffsetY": 120,
	"groundBase": 0,
	"wallBase": 10,
	"small": {
		"size": 4,
		"secrets": 1,
	},
	"medium": {
		"size": 7,
		"secrets": 2,
	},
	"large": {
		"size": 12,
		"secrets": 3,
	}
}

const weapons: Dictionary = {
	"laser": {
		"name": "Laser",
		"speed": 300,
		"duration": 0.5,
		"cooldown": 0.3
	},
	"auto": {
		"name": "Auto",
		"speed": 400,
		"duration": 0.5,
		"cooldown": 0.3
	},
	"missile": {
		"name": "Rocket",
		"speed": 200,
		"duration": 0.6,
		"cooldown": 0.6
	}
}
