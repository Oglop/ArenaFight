extends Node2D


var duration = 3.0

func _ready():
	$PlayerSpawner.wait_time = duration
	$PlayerSpawner.start()

func _on_PlayerSpawner_timeout():
	var player = Loader.getScene(Loader.TYPE.PLAYER)
	self.add_child(player)
	player.global_position = Vector2(Global.START_ROOM_X  * 320 + Data.mapConfigs.cameraOffsetX, Global.START_ROOM_Y  * 240 + Data.mapConfigs.cameraOffsetY)

