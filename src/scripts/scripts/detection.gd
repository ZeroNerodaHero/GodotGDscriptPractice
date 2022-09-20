extends Node2D
signal updateVision


var area2d
var ray
var detected = []
var debugLines = []
var lineTest = null
var doNotAdd = null
func detectInit(parentArea):
	doNotAdd = parentArea
func _ready():
	area2d = get_node("Area2D")
	ray = get_node("RayCast2D")
func _process(_delta):
	while !(debugLines.empty()):
		var tp = debugLines.back()
		debugLines.pop_back()
		if(tp != null):
			tp.queue_free()
	for unit in detected:
		var lineDrawer = Line2D.new();
		lineDrawer.width = 1;
		lineDrawer.default_color=Color(255, 0, 0, 0.1)
		lineDrawer.add_point(Vector2(self.position))
		lineDrawer.add_point(to_local(Vector2(unit.global_position)))
		self.add_child(lineDrawer)
		debugLines.push_back(lineDrawer)

func _on_Area2D_area_entered(area):
	if(area.is_in_group("npc") && area != doNotAdd):
		detected.push_back(area)
		emit_signal("updateVision",detected)
func _on_Area2D_area_exited(area):
	if(area.is_in_group("npc") && area != doNotAdd):
		detected.erase(area)
		emit_signal("updateVision",detected)
