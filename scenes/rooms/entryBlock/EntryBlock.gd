extends Node2D

onready var collisionBox = $StaticBody2D/CollisionShape2D
onready var sprite = $EntryBlockSprite
var state = Data.ARENA_DOOR_STATES.OPEN

func _checkState() -> void:
	if state == Data.ARENA_DOOR_STATES.CLOSED:
		sprite.play("closed")
		collisionBox.disabled = false
	else:
		sprite.play("open")
		collisionBox.disabled = true
	
func _on_blockStateChange(newState: int) -> void: 
	state = newState
	
func _physics_process(delta):
	_checkState()
	
func _ready():
	Events.connect("setArenaEntryBlockState", self, "_on_blockStateChange")

