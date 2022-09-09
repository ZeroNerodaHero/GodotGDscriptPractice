extends Node2D
signal mouseCondition

var gunMuzzle;
var gunRot =0
var targetGunRot = 0
var rotationSpeed = 2
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
	targetGunRot = gunRot - degrees
	
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
	if(gunRot != targetGunRot):
		if(gunRot <targetGunRot):
			gunRot+=rotationSpeed
		elif(gunRot > targetGunRot):
			gunRot-=rotationSpeed
		self.set_rotation_degrees(gunRot)
	pass

var activeMat = load("res://src/UI/shaderActive.tres")
var inactiveMat = load("res://src/UI/shader.tres")

func _on_Area2D_mouse_entered():
	emit_signal("mouseCondition",1)
func _on_Area2D_mouse_exited():
	emit_signal("mouseCondition",0)
func inactiveShader():
	sprite.material = inactiveMat
func activeShader():
	sprite.material = activeMat

