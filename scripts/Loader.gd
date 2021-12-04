extends Node

enum TYPE {
	PLAYER,
	BULLET_AUTO,
	BULLET_LASER,
	ARENA,
	ARENA_DOOR
}

onready var Player = preload("res://scenes/player/Player.tscn")
onready var LaserBullet = preload("res://scenes/interactives/playerLaserBullet/PlayerLaserBullet.tscn")
onready var AutoBullet = preload("res://scenes/interactives/PlayerGunBullet/PlayerGunBullet.tscn")
onready var ArenaDoor = preload("res://scenes/rooms/entryBlock/EntryBlock.tscn")

#onready var Arena = preload("res://scenes/rooms/arena/Arena.tscn")

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
	
	

