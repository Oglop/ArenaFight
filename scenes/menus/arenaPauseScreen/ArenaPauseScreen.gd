extends Node2D

onready var colorRect = $ColorRect
onready var canvas = $ArenaPauseScreen
onready var minimapBoarder = $ArenaPauseScreen/minimapBoarder

var mapPosX = 224
var mapPosY = 16
var miniMap = []
var mapNodeSize = 8


func togglePause():
	var pauseState = not get_tree().paused
	get_tree().paused = pauseState
	self.visible = pauseState
	minimapBoarder.visible = pauseState


func _ready():
	Events.connect("updateMiniMap", self, "_on_pausePressed")
	_buildMap()
	
func _buildMap() -> void:
	for x in range(Data.mapConfigs.arenaSize):
		var miniMapRow = []
		for y in range(Data.mapConfigs.arenaSize):
			var r = Loader.getScene(Loader.TYPE.MAP_NODE)
			var current = true if r.type == Data.ROOM_TYPE.START else false
			r.updateData(Global.CURRENT_MAP[x][y], x, y, current, false)
			canvas.add_child(r)
			miniMapRow.append(r)
			r.position = Vector2(mapPosX + (x * mapNodeSize), mapPosY + (y * mapNodeSize))
		miniMap.append(miniMapRow)

func _updateMap(mapx: int, mapy: int) -> void:
	for x in range(Data.mapConfigs.arenaSize):
		for y in range(Data.mapConfigs.arenaSize):
			var current = true if mapx == x && mapy == y else false
			miniMap[x][y].updateData(Global.CURRENT_MAP[x][y], x, y, current, get_tree().paused)

func _on_pausePressed(x:int, y:int) -> void:
	var mapy = (y / 16) / Data.mapConfigs.tilesVert
	var mapx = (x / 16) / Data.mapConfigs.tilesHori
	_updateMap(mapx, mapy)
	
func checkForInput():
	if Input.is_action_just_pressed("PAUSE"):
		togglePause()
	
func _physics_process(delta):
	checkForInput()
