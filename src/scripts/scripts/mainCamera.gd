extends Camera2D
var zoomLevel = 1.0;
var zoomIncrement = 1.2

func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		#event as InputEventMouseButton
		if event.pressed:
			match event.button_index:
				BUTTON_WHEEL_UP:
					zoomLevel /= zoomIncrement
				BUTTON_WHEEL_DOWN:
					zoomLevel *= zoomIncrement
	elif event is InputEventKey:
		#im not sure why event doesn't work
		#only use input here allowed
		if(Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_S) ||
		 Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_D)):
			self.position += Vector2(int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)), 
			 int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W)))
	elif event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_MIDDLE:
			self.position -= event.relative*zoomLevel;
	self.set_zoom(Vector2(zoomLevel,zoomLevel))

func getUnitList():
	return $CanvasLayer/unit_list
	
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
