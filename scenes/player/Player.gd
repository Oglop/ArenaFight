extends KinematicBody2D

var screenTransitionDirection = 0
var velocity = Vector2.ZERO
const MAX_SPEED = Data.gameConfigs.playerMaxSpeed
const ACCELERATION = Data.gameConfigs.playerAcceleration
const FRICTION = Data.gameConfigs.playerFriction
const moveOnTransition = 1.0

func _ready():
	Global.arenaState = Data.ARENA_STATES.ROOM_PLAYING
	Events.connect("cameraTransitionTo", self, "_on_ScreenTransition")
	Events.connect("roomTransitionDone", self, "_on_screenTransitionDone")
	for n in range(Global.TAIL_SIZE,-1,-1):
		Global.DROID_POSITION[n] = self.global_position

func _updateDroidPositions():
	for n in range(Global.TAIL_SIZE, 0, -1):
		Global.DROID_POSITION[n] = Global.DROID_POSITION[n - 1]
	Global.DROID_POSITION[0] = self.global_position

func _checkForScreenTransition():
	# arenaScreenTransitionTo
	if int(global_position.x) % Data.mapConfigs.screenSizeX < 10:
		Events.emit_signal("cameraTransitionTo", Data.DIRECTIONS.WEST)
	elif int(global_position.x) % Data.mapConfigs.screenSizeX > 310:
		Events.emit_signal("cameraTransitionTo", Data.DIRECTIONS.EAST)
	elif int(global_position.y) % Data.mapConfigs.screenSizeY < 10:
		Events.emit_signal("cameraTransitionTo", Data.DIRECTIONS.NORTH)
	elif int(global_position.y) % Data.mapConfigs.screenSizeY > 230:
		Events.emit_signal("cameraTransitionTo", Data.DIRECTIONS.SOUTH)

func _on_screenTransitionDone() -> void:
	Events.emit_signal("updateMiniMap", self.global_position.x, self.global_position.y)

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

func _on_ScreenTransition(direction):
	screenTransitionDirection = direction


func _physics_process(delta):
	if Global.arenaState == Data.ARENA_STATES.ROOM_PLAYING:
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
		_updateDroidPositions()
		
		_checkForScreenTransition()
	elif Global.arenaState == Data.ARENA_STATES.SCREEN_TRANSITION:
		if screenTransitionDirection == Data.DIRECTIONS.EAST:
			self.global_position.x += moveOnTransition
		elif screenTransitionDirection == Data.DIRECTIONS.NORTH:
			self.global_position.y -= moveOnTransition
		elif screenTransitionDirection == Data.DIRECTIONS.WEST:
			self.global_position.x -= moveOnTransition
		elif screenTransitionDirection == Data.DIRECTIONS.SOUTH:
			self.global_position.y += moveOnTransition
