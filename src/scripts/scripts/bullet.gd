extends Area2D
#if boolets move too slow they hit the shooter
var speed = 2000;
var dist = 4000;
var totalDist = 4000;
var randVariation = 10;
var elevation = -1
func _init():
	self.set_rotation_degrees(randi() % randVariation - randVariation/2)
	pass

func _physics_process(delta):
	var chng =transform.x * speed * delta;
	position += chng
	dist -= chng.length();
	if(dist < 0):
		self.queue_free();

func reduceElevation():
	if(randi()%100 < 90):
		elevation -= 1;
		if(elevation < 0):
			self.queue_free()
		

func increaseElevation(height):
	print("upgradeElevation")
	if(elevation == -1):
		elevation = height
	elif(elevation > height):
		elevation = height

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
