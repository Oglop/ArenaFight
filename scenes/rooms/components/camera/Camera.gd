extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("setCameraPosition", self, "_on_cameraSetPosition")


func _on_cameraSetPosition(x, y):
	self.global_position.x = x * 16
	self.global_position.y = y * 16
