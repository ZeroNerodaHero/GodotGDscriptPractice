extends Control
signal unitClicked
var isHover = false
var textRect
var unit

func _ready():
	textRect = get_node("TextureRect")
	pass # Replace with function body.

func myInit(_unit):
	unit = _unit
	self.connect("unitClicked",unit,"_unitUIClicked")

func _on_unitIcon_mouse_entered():
	self.rect_position.y = -30;
	isHover = true

func _on_unitIcon_mouse_exited():
	self.rect_position.y = 0
	isHover = false
	
func _input(event):
	if(isHover):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				emit_signal("unitClicked",self)
func modColor(case):
	if case == 1:
		$TextureRect.modulate = Color(0,1,0)
	else:
		$TextureRect.modulate = Color(255,255,255)		
	
func _toActive(unit):
	emit_signal("unitClicked",self)

func _updateStatus(health,morale,ammo):
	$Health.value = health
	$Morale.value = morale
func _unitDead():
	self.queue_free()
	
	#not toos sure why active unit thing works rethink at least
