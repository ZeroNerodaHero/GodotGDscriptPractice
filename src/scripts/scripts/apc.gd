extends Node2D
signal mouseCondition

var gunner; var gunMuzzle; var sprite
var icon
var gunRot =0
var targetGunRot = 0; var rotationClock = 1
var bodyRot = 0
var targetBodyRot = 0
var debugMod = 1
var rotationGunSpeed = 0.5
var rotationBodySpeed = 0.3

# Called when the node enters the scene tree for the first time.
func myInit(type=0):
	if(type == 0):
		icon.texture = load("res://src/imgSrc/apc/ammoicon.png")
	elif(type == 1):
		icon.texture = load("res://src/imgSrc/apc/medicicon.png")
	$Area2D/gunner/Position2D/detection.detectInit($Area2D)
	pass

func rotateDeg(degrees):
	targetGunRot = degrees
func rotateGunTo(degrees):
	var cw = (360 +degrees-int(gunRot))%360
	var ccw = 360-cw
	if cw < ccw:
		rotationClock = 1
		targetGunRot = cw
	else:
		rotationClock = -1
		targetGunRot = ccw
func rotateBody(degrees):
	targetBodyRot = degrees
func rotateBodyTo(degrees):
	targetBodyRot = degrees
func getGunDegree():
	return gunner.rotation_degrees
	
#every chareacter will have its own roateDeg function that 
#the main thing will call
func getMuzzle():
	return gunMuzzle
	
func _ready():
	sprite = get_node("Area2D/Sprite")
	gunner = get_node("Area2D/gunner")
	gunMuzzle = get_node("Area2D/gunner/Position2D")
	icon = get_node("Area2D/icon")
	#myInit(0)
	pass # Replace with function body.

func frameRotate(rot,target,speed):
	if(rot != target):
		if(rot <target):
			rot+=speed
		elif(rot > target):
			rot-=speed
	return rot

func _process(_delta):
	if(targetGunRot > 0):
		gunRot=gunRot+(rotationGunSpeed*rotationClock)
		targetGunRot -= rotationGunSpeed
		gunner.set_rotation_degrees(gunRot)
		if(abs(gunRot) == 180):
			gunRot *= -1
	
	pass
	
#a lot of copied code
var activeMat = load("res://src/imgSrc/themes/shaderActive.tres")
var inactiveMat = load("res://src/imgSrc/themes/shader.tres")

func _on_Area2D_mouse_entered():
	emit_signal("mouseCondition",1)
func _on_Area2D_mouse_exited():
	emit_signal("mouseCondition",0)
func inactiveShader():
	sprite.material = inactiveMat
func activeShader():
	sprite.material = activeMat

func getDetection():
	return get_node("Area2D/gunner/Position2D/detection")
func getArea2d():
	return get_node("Area2D")
