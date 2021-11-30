extends Node2D

onready var sprite = $AnimatedSprite

const duration = 0.7
enum STATES {
	SLOW, FAST, CRITICAL
}
var state = STATES.SLOW

func _ready():
	_setTimer()

func _physics_process(delta):
	if state == STATES.SLOW:
		sprite.play("slow")
	elif state == STATES.FAST:
		sprite.play("fast")
	else:
		sprite.play("critical")

func _setTimer():
	$Timer.wait_time = duration
	$Timer.start()

func _on_Timer_timeout():
	if state == STATES.SLOW:
		_setTimer()
		state = STATES.FAST
	elif state == STATES.FAST:
		_setTimer()
		state = STATES.CRITICAL
	else:
		Events.emit_signal("playerExplosions", self.global_position)
		self.queue_free()
