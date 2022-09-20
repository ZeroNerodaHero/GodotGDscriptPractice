extends Node2D
signal mouseCondition

var gunMuzzle;
var gunRot =0
var targetGunRot = 0; var rotationClock = 1
var rotationSpeed = 1
var sprite

# Called when the node enters the scene tree for the first time.
func myInit(type=0):
	if(type==0): 
		sprite.texture = load("res://src/imgSrc/moto/moto.png")
	elif(type==1): 
		sprite.texture = load("res://src/imgSrc/moto/moto_armored.png")
	pass

func rotateDeg(degrees):
	targetGunRot = gunRot - degrees
func rotateGunTo(degrees):
	var cw = (360 +degrees-int(gunRot))%360
	var ccw = 360-cw
	if cw < ccw:
		rotationClock = 1
		targetGunRot = cw
	else:
		rotationClock = -1
		targetGunRot = ccw
func getGunDegree():
	return self.rotation_degrees

func getMuzzle():
	return gunMuzzle
	
#func fireBullet(var bulletInst):
#	gunMuzzle.add_child(bulletInst)
#	pass
	
func _ready():
	sprite = get_node("Area2D/Sprite")
	gunMuzzle = get_node("Position2D")
	myInit(1)
	pass # Replace with function body.


func _process(_delta):
	if(targetGunRot > 0):
		gunRot=gunRot+(rotationSpeed*rotationClock)
		targetGunRot -= rotationSpeed
		self.set_rotation_degrees(gunRot)
		if(abs(gunRot) == 180):
			gunRot *= -1
	pass

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
	return get_node("Position2D/detection")
func getArea2d():
	return get_node("Area2D")
