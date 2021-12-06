extends Node2D

const duration = 0.2

func _ready():
	Events.emit_signal("shakeScreen")
	$Duration.wait_time = duration
	$Duration.start()



func _on_Duration_timeout():
	self.queue_free()
