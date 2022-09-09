extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var unitContainer
var currentActive = null;


func _ready():
	unitContainer = load("res://src/characters/user/unitContainer.tscn").instance()
	self.add_child(unitContainer)
	for x in 3:
		unitContainer.addUnit(0,x)
	for x in 2:
		unitContainer.addUnit(1,x)
	for x in 2:
		unitContainer.addUnit(2,x)
		
	var px = 40; var py = 40
	for x in unitContainer.getUnits():
		x.position = Vector2(px,py)
		px += 300
	pass # Replace with function body.

func _process(_delta):
	for x in unitContainer.getUnits():
		x.rotate(1)
	pass
