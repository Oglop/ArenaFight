extends Node

enum TYPE {
	PLAYER,
	BULLET_AUTO,
	BULLET_LASER,
	ARENA,
	ARENA_DOOR,
	BOMBABLE,
	MAP_NODE,
	DROID,
	PLAYER_BOMB
	EXPLOSION_FRIENDLY
}

onready var Player = preload("res://scenes/player/Player.tscn")
onready var LaserBullet = preload("res://scenes/interactives/playerLaserBullet/PlayerLaserBullet.tscn")
onready var AutoBullet = preload("res://scenes/interactives/PlayerGunBullet/PlayerGunBullet.tscn")
onready var ArenaDoor = preload("res://scenes/rooms/entryBlock/EntryBlock.tscn")
onready var Bombable = preload("res://scenes/rooms/bombableBlock/BombableBlock.tscn")
onready var PlayerBomb = preload("res://scenes/interactives/playerBomb/PlayerBomb.tscn")
onready var PlayerExplosion = preload("res://scenes/interactives/explosions/playerBomb/PlayerBomb.tscn")
onready var MapNode = preload("res://scenes/rooms/components/mapNode/MapNode.tscn")
onready var Droid = preload("res://scenes/interactives/droidA/DroidA.tscn")

func _ready():
	pass
	
func getScene(type):
	if type == TYPE.PLAYER:
		return Player.instance()
	elif type == TYPE.BULLET_AUTO:
		return AutoBullet.instance()
	elif type == TYPE.BULLET_LASER:
		return LaserBullet.instance()
	elif type == TYPE.ARENA_DOOR:
		return ArenaDoor.instance()
	elif type == TYPE.BOMBABLE:
		return Bombable.instance()
	elif type == TYPE.MAP_NODE:
		return MapNode.instance()
	elif type == TYPE.DROID:
		return Droid.instance()
	elif type == TYPE.PLAYER_BOMB:
		return PlayerBomb.instance()
	elif type == TYPE.EXPLOSION_FRIENDLY:
		return PlayerExplosion.instance()

