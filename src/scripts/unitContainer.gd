extends Node2D


var unitOwner;
var allUnits = []
var unitEncap = load("res://src/characters/user/userUnitEncap.tscn")
var selectedUnit = null

func myInit(type):
	unitOwner = type

func addUnit(type,subtype,x=0,y=0):
	var tmp = unitEncap.instance();
	self.add_child(tmp)
	tmp.myInit(type,subtype);
	allUnits.push_back(tmp)
	tmp.connect("activeUnit",self,"_onActiveUnitUpdate")

func _onActiveUnitUpdate(unit):
	if(selectedUnit != null):
		selectedUnit.unSelectUnit();
	selectedUnit = unit

func getUnits():
	return allUnits

func _ready():
	pass # Replace with function body.
#	pass
