extends Node2D
signal activeUnit

var character
var fireRateTimer
var reloadTimer
var fireRate = 650
var canShoot = true
var bullet = load("res://src/materials/bullet.tscn")

var isActive = 0; var isSelected = 0;
#type 1-3
#subtype is an int that does the 00001
#where 1 stands for an opt(like armor)
func myInit(type,subtype):
	var newChild = null
	if(type==0): 
		newChild = load("res://src/characters/user/infantry.tscn")
		$unitInfo.set_position(Vector2(-48,-77))
	elif(type==1): 
		newChild = load("res://src/characters/user/motocycle.tscn")
		$unitInfo.set_position(Vector2(-48,-92))
	elif(type==2): 
		newChild = load("res://src/characters/user/apc.tscn")
	character = newChild.instance()
	self.add_child(character)
	character.myInit(subtype)
	character.set_scale(Vector2(3,3))
	
	character.connect("mouseCondition",self,"_onMouseCondition")
	pass
	
func rotate(degrees):
	character.rotateDeg(degrees)
	
func fireBullet():
	if(canShoot):
		var newBullet = bullet.instance()
		newBullet.position = character.getMuzzle().global_position;
		newBullet.rotation = character.getMuzzle().global_rotation;
		self.get_parent().add_child(newBullet)
		canShoot = false;
		fireRateTimer.start(fireRate/3600)
	
func _process(_delta):
	fireBullet()

func _unhandled_input(event):
	if(isActive):
		if event is InputEventMouseButton:
			if !isSelected && event.button_index == BUTTON_LEFT:
				if event.pressed:
					isSelected ^= 1;
					set_active()
					emit_signal("activeUnit",self)
	if(isSelected):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_RIGHT:
				print("true")
				if(event.pressed):
					print(event.global_position)
					#self.global_position = event.global_position
					self.global_position = get_global_mouse_position() 
					
func set_active():
	if isSelected:
		character.activeShader()
	else:
		character.inactiveShader()

func _ready():
	fireRateTimer = get_node("timers/fireRateTimer")
	reloadTimer = get_node("timers/reloadTimer")

func _on_fireRateTimer_timeout():
	canShoot = true;

func _onMouseCondition(cond):
	isActive = cond
	if(isActive || isSelected):
		character.activeShader()
	else:
		character.inactiveShader()

func unSelectUnit():
	character.inactiveShader()
	isSelected = 0
