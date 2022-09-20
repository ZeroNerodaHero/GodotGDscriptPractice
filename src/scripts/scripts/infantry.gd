extends Node2D
signal mouseCondition

var gunMuzzle;
var gunRot =0
var targetGunRot = 0
var rotationSpeed = 2; var rotationClock = 1;
var sprite
# Called when the node enters the scene tree for the first time.
func myInit(type=0):
	if(type==0): 
		sprite.texture = load("res://src/imgSrc/infantry/infantry_rifle.png")
	elif(type==1): 
		sprite.texture = load("res://src/imgSrc/infantry/infantry_pistol.png")
	elif(type==2): 
		sprite.texture = load("res://src/imgSrc/infantry/infantry_shield.png")
	pass

func rotateDeg(degrees):
	targetGunRot = degrees
func rotateGunTo(degrees):
	var cw = (360 +degrees-gunRot)%360
	var ccw = 360-cw
	if cw < ccw:
		rotationClock = 1
		targetGunRot = cw
	else:
		rotationClock = -1
		targetGunRot = ccw
func getGunDegree():
	return self.rotation_degrees

#every chareacter will have its own roateDeg function that 
#the main thing will call
func getMuzzle():
	return gunMuzzle

#func fireBullet(var bulletInst):
#	gunMuzzle.add_child(bulletInst)
#	#bulletInst.transform = gunMuzzle.global_transform;
#	pass
	
func _ready():
	gunMuzzle = get_node("Position2D")
	sprite = get_node("Area2D/CollisionShape2D/Sprite")
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
