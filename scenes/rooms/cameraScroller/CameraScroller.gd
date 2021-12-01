extends Node2D

func _ready():
	Events.connect("setCameraPosition", self, "_on_cameraSetPosition")


func _on_cameraSetPosition(x, y):
	print("x: " + str(x) + "y: " + str(y))
	self.global_position.x = x * 320
	self.global_position.y = y * 240
	
func _physics_process(delta):
	#self.global_position.x += 1
	#self.global_position.y += 1
	if Input.is_mouse_button_pressed(1):
		print("x: " + str(self.global_position.x) + "y: " + str(self.global_position.y))
	
	if Input.is_action_just_pressed("RIGHT"):
		self.global_position.x += 320
	if Input.is_action_just_pressed("UP"):
		self.global_position.y -= 240
	if Input.is_action_just_pressed("LEFT"):
		self.global_position.x -= 320
	if Input.is_action_just_pressed("DOWN"):
		self.global_position.y += 240
	
		
