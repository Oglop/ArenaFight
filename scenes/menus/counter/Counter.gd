extends CanvasLayer

var number:int = 25
var showLeadingNumbers: bool = false
onready var single = $Single
onready var tens = $Tens
onready var hundreds = $Hundreds

func _ready():
	pass
	
func getNumer() -> int:
	return number
	
func setNumer(value:int)-> void:
	number = value
	
func _setSingleAnimation(digit:int) -> void:
	single.play(str(digit))
	
func _setTensAnimation(digit:int) -> void:
	if digit == 0 and !showLeadingNumbers:
		tens.hide()
	else:
		tens.show()
		tens.play(str(digit))
	
func _setHundredsAnimation(digit:int) -> void:
	if digit == 0 and !showLeadingNumbers:
		hundreds.hide()
	else:
		hundreds.show()
		hundreds.play(str(digit))

func _physics_process(delta):
	if number <= 0:
		number = 0
	elif number >= 999:
		number = 999
	var temp = number
	var loopNo = 0
	if number < 100:
		_setHundredsAnimation(0)
	if number < 10:
		_setTensAnimation(0)
	while temp > 0:
		var digit = temp % 10
		temp = temp / 10
		if loopNo == 0:
			_setSingleAnimation(digit)
		elif loopNo == 1:
			_setTensAnimation(digit)
		elif loopNo == 2:
			_setHundredsAnimation(digit)
		loopNo += 1
		
