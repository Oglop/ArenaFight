extends Node2D


var duration = 3.0

func _ready():
	$PlayerSpawner.wait_time = duration
	$PlayerSpawner.start()
	Events.connect("firedBomb", self, "_on_firedBomb")

func _on_PlayerSpawner_timeout():
	var player = Loader.getScene(Loader.TYPE.PLAYER)
	var droid = Loader.getScene(Loader.TYPE.DROID)
	self.add_child(droid)
	self.add_child(player)
	player.global_position = Vector2(Global.START_ROOM_X  * 320 + Data.mapConfigs.cameraOffsetX, Global.START_ROOM_Y  * 240 + Data.mapConfigs.cameraOffsetY)
	droid.global_position = player.global_position

func _on_firedBomb(bombSpawnPoint: Vector2) -> void:
	var bomb = Loader.getScene(Loader.TYPE.PLAYER_BOMB)
	self.add_child(bomb)
	bomb.global_position = bombSpawnPoint
