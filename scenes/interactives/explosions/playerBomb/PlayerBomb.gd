extends Node2D

const duration = 0.5

func _ready():
	$Duration.wait_time = duration
	$Duration.start()



func _on_Duration_timeout():
	self.queue_free()
