extends CanvasLayer

onready var hpCounter = $Counter
onready var bombCounter = $BombCounter
onready var hpBar = $TextureProgress

func _ready():
	pass
	
func _physics_process(delta):
	hpCounter.setNumer(20)
	hpBar.value = Global.CUR_HP / Global.MAX_HP * 100
	
	
	bombCounter.setNumer(99)
