extends Node2D


var unitOwner;
var allUnits = []
var unitEncap = load("res://src/characters/user/userUnitEncap.tscn")
var selectedUnit = null

func myInit(type):
	unitOwner = type

func addUnit(type,subtype,debug=false):
	var tmp = unitEncap.instance();
	self.add_child(tmp)
	tmp.myInit(type,subtype,debug);
	allUnits.push_back(tmp)
	tmp.connect("activeUnit",self,"_onActiveUnitUpdate")

func _onActiveUnitUpdate(unit):
	updateSelectedUnit(unit)
func getUnits():
	return allUnits
func updateSelectedUnit(unit):
	if(selectedUnit != null && is_instance_valid(selectedUnit)):
		selectedUnit.unSelectUnit();
	selectedUnit = unit

func _ready():
	pass # Replace with function body.
#	pass
