extends Node2D

const duration = 3.0
onready var timer = get_node("PlayerSpawnerTimer.tscn")

func _ready():
	timer.wait_time = duration
	timer.start()

func _on_Timer_timeout():
	var player = Loader.getScene(Loader.TYPE.PLAYER)
	self.add_child(player)
	player.global_position = Vector2(Global.START_ROOM_X  * 320 + Data.mapConfigs.cameraOffsetX, Global.START_ROOM_Y  * 240 + Data.mapConfigs.cameraOffsetY)
