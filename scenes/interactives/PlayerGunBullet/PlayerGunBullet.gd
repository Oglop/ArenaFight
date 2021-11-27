extends KinematicBody2D

var duration = Data.weapons.auto.duration

func _ready():
	$Duration.wait_time = duration
	$Duration.start()

func _on_Duration_timeout():
	self.queue_free()
