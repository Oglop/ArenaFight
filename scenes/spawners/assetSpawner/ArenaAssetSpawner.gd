extends Node2D


func _ready():
	Events.connect("arenaAddAssetAt", self, "_on_addAssetAt")

func _on_addAssetAt(type: int, position: Vector2) -> void:
	if type == Loader.TYPE.ARENA_DOOR:
		var door = Loader.getScene(Loader.TYPE.ARENA_DOOR)
		self.add_child(door)
		door.global_position = position
