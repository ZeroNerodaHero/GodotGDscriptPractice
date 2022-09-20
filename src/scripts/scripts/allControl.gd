extends Node2D

var unitContainer
var camera
var unitList


func _ready():
	camera = $Camera2D
	unitList = camera.getUnitList()
	unitContainer = load("res://src/characters/user/unitContainer.tscn").instance()
	self.add_child(unitContainer)
	for x in 3:
		unitContainer.addUnit(0,x)
	for x in 2:
		unitContainer.addUnit(1,x,true)
	for x in 2:
		unitContainer.addUnit(2,x)
		
	var px = 40; var py = 40
	for x in unitContainer.getUnits():
		x.global_position = Vector2(px,py)
		py += 300
		
		unitList.addUnit(x)
	#camera.myInit(unitContainer)
	pass # Replace with function body.
