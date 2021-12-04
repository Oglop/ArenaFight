extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func copyDictionary(source: Dictionary) -> Dictionary:
	var copy: Dictionary = source.duplicate()
	return copy

func copyArray(source: Array) -> Array:
	var copy: Array = source.duplicate()
	return copy
	
func randomInt(from: int, to: int) -> int:
	return rng.randi_range(from, to)
	
func plusOneLimit(value: int, maximum: int) -> int:
	if value + 1 > maximum:
		return maximum
	return value + 1

func minusOneLimit(value: int, minimum: int) -> int:
	if value - 1 < minimum:
		return minimum
	return value - 1

func chance(test: int) -> bool:
	var value = rng.randi_range(0, 100)
	if value <= test:
		return true
	return false
	
