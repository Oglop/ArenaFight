extends Node

var arenaState = Data.ARENA_STATES.IDLE
var settings = {}
var CURRENT_MAP = []
var CURRENT_TILES = []
var START_ROOM_X = 0
var START_ROOM_Y = 0
var END_ROOM_X = 0
var END_ROOM_Y = 0
var MAX_HP:float = 100
var CUR_HP:float = 90
var TAIL_SIZE = 10
var DROID_POSITION: Array = [
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0),
	Vector2(0,0)
]
