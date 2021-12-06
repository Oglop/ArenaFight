extends Node2D

onready var room = $NodeSprite
onready var east = $Right
onready var north = $North
onready var west = $Left
onready var south = $South

var data: Dictionary = {
	"visited": false
}
var isCurrent: bool = false
var type: int = 0
var x: int = 0
var y: int = 0

func _ready():
	pass
	
func _physics_process(delta):
	if not get_tree().paused:
		room.hide()
		east.hide()
		north.hide()
		west.hide()
		south.hide()
		return
	else:
		room.show()
	if data.empty():
		room.play("notFound")
		east.hide()
		north.hide()
		west.hide()
		south.hide()
	elif data.visited == false:
		room.play("notFound")
		east.hide()
		north.hide()
		west.hide()
		south.hide()
	else:
		if data.type == Data.ROOM_TYPE.START:
			if isCurrent == true:
				room.play("startCur")
			else:
				room.play("start")
		elif data.type == Data.ROOM_TYPE.END:
			if isCurrent == true:
				room.play("endCur")
			else:
				room.play("end")
		else:
			if isCurrent == true:
				room.play("roomCur")
			else:
				room.play("room")
		if data.doorEast == true:
			east.show()
		else:
			east.hide()
		if data.doorNorth == true:
			north.show()
		else:
			north.hide()
		if data.doorWest == true:
			west.show()
		else:
			west.hide()
		if data.doorSouth == true:
			south.show()
		else:
			south.hide()
			
func updateData(value: Dictionary, mapx:int, mapy: int, current: bool, paused: bool) -> void:
	data = value
	x = mapx
	y = mapy
	isCurrent = current
	if isCurrent:
		data.visited = true
	
	
