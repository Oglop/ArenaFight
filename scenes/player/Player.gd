extends KinematicBody2D

var velocity = Vector2.ZERO
const MAX_SPEED = 5000
const ACCELERATION = 200
const FRICTION = 1000

func _ready():
	pass # Replace with function body.


func _on_HitBox_area_entered(area):
	pass # Replace with function body.
	
func _setDirection():
	if !Input.is_action_pressed("CANCEL"):
		if Input.is_action_pressed("RIGHT"):
			$Sprite.play("right")
		elif Input.is_action_pressed("LEFT"):
			$Sprite.play("left")
		if Input.is_action_pressed("UP"):
			$Sprite.play("up")
		elif Input.is_action_pressed("DOWN"):
			$Sprite.play("down")

func _physics_process(delta):
	
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	inputVector.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	inputVector = inputVector.normalized()

	if inputVector != Vector2.ZERO:
		velocity += inputVector * ACCELERATION
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	_setDirection()
	move_and_slide(velocity)
