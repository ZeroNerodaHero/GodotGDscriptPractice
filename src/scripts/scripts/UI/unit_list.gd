extends HBoxContainer
var currentChildren = []
var setChildren = null
var unitIcon = load("res://src/UI/unitIcon.tscn")

func _ready():
	pass # Replace with function body.
	
func addUnit(unit):
	var temp = unitIcon.instance();
	temp.myInit(unit)
	self.add_child(temp)
	temp.connect("unitClicked",self,"_unitClicked")
	unit.connect("activeUnit",temp,"_toActive")
	unit.connect("updateStatus",temp,"_updateStatus")
	unit.connect("unitDead",temp,"_unitDead")
	
	temp.connect("unitClicked",unit,"_unitUIClicked")

func _unitClicked(unit):
	if(setChildren != null && is_instance_valid(setChildren)):
		setChildren.modColor(0)
	setChildren = unit
	setChildren.modColor(1)

func updateUnitInfo(unit):
	pass
