extends Node

var defaultSettings: Dictionary = {
	"lastsave": "",
	"fullscreen": false,
}

var mapConfigs: Dictionary = {
	"arenaSize": 10,
	"tilesHori": 20,
	"tilesVert": 15,
	"tilesSize": 16,
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
