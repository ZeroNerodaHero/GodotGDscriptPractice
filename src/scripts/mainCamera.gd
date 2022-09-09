extends Camera2D
var zoomLevel = 1.0;
var zoomIncrement = 1.2

func _process(_delta):
	pass

func _input(event):
	#print(event)
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
			self.position -= event.relative;
	self.set_zoom(Vector2(zoomLevel,zoomLevel))

	
#	#if ev is InputEventMouseButton and ev.is_pressed() and ev.doubleclick:
#	if ev is InputEventMouseButton and ev.get_factor():
#		print("factor"+str(ev.get_factor()))
#
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
