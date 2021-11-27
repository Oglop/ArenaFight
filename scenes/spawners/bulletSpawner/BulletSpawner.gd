extends Node2D

func _ready():
	Events.connect("firedAuto", self, "_on_firedAuto")

func _on_firedAuto(globalPosition: Vector2, direction: int) -> void:
	var newBullet = Loader.getScene(Loader.TYPE.BULLET_AUTO)
	newBullet.global_position = globalPosition
	newBullet.direction = direction
