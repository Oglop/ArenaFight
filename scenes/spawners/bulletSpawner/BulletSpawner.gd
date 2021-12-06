extends Node2D

func _ready():
	Events.connect("firedAuto", self, "_on_firedAuto")
	Events.connect("playerExplosions", self, "_on_playerExplosition")

func _on_firedAuto(globalPosition: Vector2, direction: int) -> void:
	var newBullet = Loader.getScene(Loader.TYPE.BULLET_AUTO)
	newBullet.global_position = globalPosition
	newBullet.direction = direction


func _on_playerExplosition(globalPosition: Vector2) -> void:
	var newExplosion = Loader.getScene(Loader.TYPE.EXPLOSION_FRIENDLY)
	newExplosion.global_position = globalPosition
	self.add_child(newExplosion)
