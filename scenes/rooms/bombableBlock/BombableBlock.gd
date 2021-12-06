extends Node2D



func _on_BombableBlockArea2D_area_entered(area):
	if area.name == "ExplosionFriendly":
		print(area.name)
		self.queue_free()
