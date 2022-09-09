extends Area2D


var speed = 500;
var dist = 100;
var totalDist = 100;
var randVariation = 10;
func _init():
	self.set_rotation_degrees(randi() % randVariation - randVariation/2)

func _physics_process(delta):
	var chng =transform.x * speed * delta;
	position += chng
	dist -= chng.length();
	if(dist < 0):
		self.queue_free();
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
