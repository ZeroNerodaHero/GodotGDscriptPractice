extends Node2D
export(int) var wallHeight = 1

func _ready():
	pass # Replace with function body.


func _on_wallHardArea_1_area_entered(area):
	if area.is_in_group("bullet"):
		bulletStuff(area)

func _on_wallHardArea_2_area_entered(area):
	if area.is_in_group("bullet"):
		bulletStuff(area)

func bulletStuff(area):
	area.reduceElevation()


func _on_wallCoverPos_area_entered(area):
	if area.is_in_group("bullet"):
		coverEnter(area)

func coverEnter(area):
	area.increaseElevation(wallHeight)
	
