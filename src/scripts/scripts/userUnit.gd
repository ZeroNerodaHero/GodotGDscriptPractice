extends KinematicBody2D
signal activeUnit
signal unitClicked
signal updateStatus
signal unitDead

var character; 
#var charInfo
var fireRateTimer; var reloadTimer
var fireRate = 1000
var canShoot = true
var bullet = load("res://src/materials/bullet.tscn")

var health = 100; var morale =100; var ammo =100;
var detectedUnits=[]; var selected = 0; 
var active =false; var rotating =false;
var stop = false
var dragDisplayInit = null; 
var unitSpeed = Vector2(100,100)

var isActive = 0; var isSelected = 0;
#type 1-3
#subtype is an int that does the 00001
#where 1 stands for an opt(like armor)
func myInit(type,subtype,debug=true):
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
	character.getDetection().connect("updateVision",self,"_onUpdateVision")
	character.getArea2d().connect("area_entered",self,"_onAreaEnter")
	pass
	
func rotate(degrees):
	character.rotateDeg(degrees)
func rotateTo(degrees):
	character.rotateGunTo(degrees)
	
func fireBullet():
	if(canShoot):
		var newBullet = bullet.instance()
		newBullet.position = character.getMuzzle().global_position;
		newBullet.rotation = character.getMuzzle().global_rotation;
		self.get_parent().add_child(newBullet)
		canShoot = false;
		fireRateTimer.start(fireRate/3600)
	
func _process(_delta):
	if(detectedUnits.size() != 0):
		rotateToEnemy()
		fireBullet()
#	charInfo.updateHealth(health)
#	charInfo.updateMorale(morale)
#	charInfo.updateAmmo(ammo)
	emit_signal("updateStatus",health,morale,ammo)
	
func _physics_process(delta):
	move()

func _unhandled_input(event):
	if(isActive):
		if event is InputEventMouseButton:
			if !isSelected && event.button_index == BUTTON_LEFT:
				if event.pressed:
					setActive()
	if(isSelected):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_RIGHT && event.pressed:
				dragDisplayInit = get_global_mouse_position()
			if event.button_index == BUTTON_RIGHT && !event.pressed:
				var dragDisplayFinal = get_global_mouse_position()
				var dy = dragDisplayFinal.y-dragDisplayInit.y
				var dx = dragDisplayFinal.x-dragDisplayInit.x
				if(abs(dy) > 1 && abs(dx) > 1):
					var angle = atan2(dy,dx)
					rotateTo(int(rad2deg(angle)))
				active = false;rotating =false
func setActive():
	isSelected ^= 1;
	set_active()
	emit_signal("activeUnit",self)
	active = false;rotating =false
func _unitUIClicked(unit):
	
func move():
	if(dragDisplayInit != null):
		var velocityVec = (dragDisplayInit - global_position)
		if(velocityVec.length() < 5):
			return
		move_and_slide(velocityVec.normalized() * unitSpeed)
func set_active():
	print("act")
	if isSelected:
		character.activeShader()
	else:
		character.inactiveShader()

func _ready():
	fireRateTimer = get_node("timers/fireRateTimer")
	reloadTimer = get_node("timers/reloadTimer")
#	charInfo = get_node("unitInfo")

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
func _onUpdateVision(detected):
	detectedUnits = detected
	if(!active && detectedUnits.size() != 0):
		rotating = true;
		selected = 0;
	else:
		rotating = false;
func rotateToEnemy():
	var unitPos = detectedUnits[selected].global_position;
	var dx = unitPos.x - self.global_position.x 
	var dy = unitPos.y - self.global_position.y
	var angle =int(rad2deg(atan2(dy,dx)))
	rotateTo(angle)
func _onAreaEnter(area):
	if area.is_in_group("bullet"):
		print("boolet")
		area.queue_free()
		health -= 20
		if(health <= 0):
			emit_signal("unitDead")
			self.queue_free()
func _unitClicked(unit):
	print("click")
