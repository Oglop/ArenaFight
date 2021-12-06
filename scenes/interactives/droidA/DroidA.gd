extends Node2D

onready var bombSpawnPoint = $BombSpawnPoint

func _ready():
	pass


func _physics_process(delta):
	self.global_position = Global.DROID_POSITION[8]

	if Input.is_action_just_pressed("ACTION2"):
			Events.emit_signal("firedBomb", bombSpawnPoint.global_position)


