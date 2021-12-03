extends Node

enum DIRECTIONS {
	EAST, NORTH, WEST, SOUTH, NONE
}

enum ARENA_STATES {
	IDLE,
	ROOM_PLAYING,
	SCREEN_TRANSITION
}

var defaultSettings: Dictionary = {
	"lastsave": "",
	"fullscreen": false,
}

var mapConfigs: Dictionary = {
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

var weapons: Dictionary = {
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
