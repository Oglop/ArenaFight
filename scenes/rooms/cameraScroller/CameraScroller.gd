extends Node2D

var transitionToDirection = 99
const duration = 1.0
var stepsX = Data.mapConfigs.screenSizeX / 30
var stepsY = Data.mapConfigs.screenSizeY / 30
var moveToX = 0
var moveToY = 0

func _ready():
	Events.connect("setCameraPosition", self, "_on_cameraSetPosition")
	Events.connect("cameraTransitionTo", self, "_on_cameraTransitionTo")

func _on_cameraSetPosition(x, y):
	moveToX = x * Data.mapConfigs.screenSizeX# + Data.mapConfigs.cameraOffsetX
	moveToY = y * Data.mapConfigs.screenSizeY# + Data.mapConfigs.cameraOffsetY
	
	self.global_position.x = x * Data.mapConfigs.screenSizeX
	self.global_position.y = y * Data.mapConfigs.screenSizeY
	
	
func _on_cameraTransitionTo(direction):
	Global.arenaState = Data.ARENA_STATES.SCREEN_TRANSITION
	_startTransitionDuration()
	if direction == Data.DIRECTIONS.EAST:
		moveToX = self.global_position.x + Data.mapConfigs.screenSizeX
	elif direction ==  Data.DIRECTIONS.WEST:
		moveToX = self.global_position.x - Data.mapConfigs.screenSizeX
	elif direction == Data.DIRECTIONS.NORTH:
		moveToY = self.global_position.y - Data.mapConfigs.screenSizeY
	elif direction == Data.DIRECTIONS.SOUTH:
		moveToY = self.global_position.y + Data.mapConfigs.screenSizeY
		

func _physics_process(delta):		
	if Global.arenaState == Data.ARENA_STATES.SCREEN_TRANSITION:
		if moveToX > self.global_position.x:
			self.global_position.x += stepsX
		elif moveToX < self.global_position.x:
			self.global_position.x -= stepsX
		elif moveToY > self.global_position.y:
			self.global_position.y += stepsY
		elif moveToY < self.global_position.y:
			self.global_position.y -= stepsY

func _startTransitionDuration():
	$TransitiomDuration.wait_time = duration
	$TransitiomDuration.start()

func _on_TransitiomDuration_timeout():
	Global.arenaState = Data.ARENA_STATES.ROOM_PLAYING
